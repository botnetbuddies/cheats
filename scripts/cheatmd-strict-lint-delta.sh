#!/usr/bin/env bash
set -u -o pipefail

# Enforce that CheatMD strict-lint findings do not regress versus a git baseline.
#
# Environment overrides:
#   BASE_REF       git ref used as the baseline snapshot (default: origin/main)
#   CHEATS_PATH    path to lint in the current worktree and baseline (default: cheats)
#   CHEATMD_BIN    cheatmd binary name/path (default: cheatmd)

BASE_REF="${BASE_REF:-origin/main}"
CHEATS_PATH="${CHEATS_PATH:-cheats}"
CHEATMD_BIN="${CHEATMD_BIN:-cheatmd}"

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'error: required command not found: %s\n' "$1" >&2
    exit 127
  fi
}

count_findings() {
  local output_file="$1"
  local summary_count warning_count

  summary_count=$(sed -nE 's/^Error: lint failed with ([0-9]+) finding\(s\)$/\1/p' "$output_file" | tail -n 1)
  warning_count=$(grep -c 'warning:' "$output_file" || true)

  if [ -n "$summary_count" ]; then
    printf '%s\n' "$summary_count"
  else
    printf '%s\n' "$warning_count"
  fi
}

run_lint() {
  local target_path="$1"
  local output_file="$2"
  local rc

  "$CHEATMD_BIN" --lint --strict "$target_path" >"$output_file" 2>&1
  rc=$?

  # cheatmd --lint --strict exits non-zero when strict warnings exist. That is
  # expected for inherited baseline debt; callers compare finding counts.
  printf '%s\n' "$rc"
}

require_cmd git
require_cmd "$CHEATMD_BIN"

if [ ! -d "$CHEATS_PATH" ]; then
  printf 'error: current CHEATS_PATH does not exist or is not a directory: %s\n' "$CHEATS_PATH" >&2
  exit 2
fi

if ! git rev-parse --verify --quiet "$BASE_REF^{commit}" >/dev/null; then
  printf 'error: baseline ref not found: %s\n' "$BASE_REF" >&2
  exit 2
fi

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/cheatmd-lint-delta.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT INT TERM

baseline_root="$tmp_dir/baseline"
mkdir -p "$baseline_root"

if ! git archive "$BASE_REF" | tar -x -C "$baseline_root"; then
  printf 'error: failed to create baseline snapshot from ref: %s\n' "$BASE_REF" >&2
  exit 2
fi

baseline_path="$baseline_root/$CHEATS_PATH"
if [ ! -d "$baseline_path" ]; then
  printf 'error: baseline CHEATS_PATH does not exist at %s:%s\n' "$BASE_REF" "$CHEATS_PATH" >&2
  exit 2
fi

current_output="$tmp_dir/current.out"
baseline_output="$tmp_dir/baseline.out"

current_rc=$(run_lint "$CHEATS_PATH" "$current_output")
baseline_rc=$(run_lint "$baseline_path" "$baseline_output")

current_count=$(count_findings "$current_output")
baseline_count=$(count_findings "$baseline_output")
delta=$((current_count - baseline_count))

printf 'CheatMD strict-lint baseline delta\n'
printf '  base_ref: %s\n' "$BASE_REF"
printf '  cheats_path: %s\n' "$CHEATS_PATH"
printf '  baseline_findings: %s (raw_exit=%s)\n' "$baseline_count" "$baseline_rc"
printf '  current_findings: %s (raw_exit=%s)\n' "$current_count" "$current_rc"
printf '  delta: %+d\n' "$delta"

if [ "$baseline_rc" -ne 0 ] && [ "$baseline_count" -eq 0 ]; then
  printf 'FAIL: baseline lint command failed without parseable lint findings.\n' >&2
  printf '\nBaseline lint output follows:\n' >&2
  cat "$baseline_output" >&2
  exit 2
fi

if [ "$current_rc" -ne 0 ] && [ "$current_count" -eq 0 ]; then
  printf 'FAIL: current lint command failed without parseable lint findings.\n' >&2
  printf '\nCurrent lint output follows:\n' >&2
  cat "$current_output" >&2
  exit 2
fi

if [ "$delta" -gt 0 ]; then
  printf 'FAIL: current strict-lint findings increased by %d versus %s.\n' "$delta" "$BASE_REF" >&2
  printf '\nCurrent lint output follows:\n' >&2
  cat "$current_output" >&2
  exit 1
fi

printf 'PASS: current strict-lint findings did not increase versus %s.\n' "$BASE_REF"
