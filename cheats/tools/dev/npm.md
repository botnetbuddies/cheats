# NPM

## npm

### Init

Start an interactive package setup.

```sh title:"Initialize npm package interactively"
npm init
```
<!-- cheat -->

### Init yes

Create a package with defaults.

```sh title:"Initialize npm package with defaults"
npm init -y
```
<!-- cheat -->

### Install dependencies

Install dependencies from `package.json`.

```sh title:"Install npm dependencies"
npm install
```
<!-- cheat -->

### Install package

Install a package.

```sh title:"Install npm package"
npm install "$package_name"
```
<!-- cheat
var package_name
-->

### Install dev package

Install a package as a dev dependency.

```sh title:"Install npm dev dependency"
npm install "$package_name" --save-dev
```
<!-- cheat
var package_name
-->

### Install global

Install a package globally.

```sh title:"Install npm package globally"
npm install "$package_name" -g
```
<!-- cheat
var package_name
-->

## nvm

### Install node

Install a Node.js version with nvm.

```sh title:"NPM Install Node.js version with nvm"
nvm install "$version"
```
<!-- cheat
var version
-->

### List remote

List available Node.js versions.

```sh title:"NPM List available Node.js versions"
nvm ls-remote
```
<!-- cheat -->

### Use version

Use an installed Node.js version.

```sh title:"NPM Use Node.js version"
nvm use "$version"
```
<!-- cheat
var version
-->

### Default version

Set the default Node.js version.

```sh title:"NPM Set default Node.js version"
nvm alias default "$version"
```
<!-- cheat
var version
-->
