# NPM

## npm

### Init

Run init with NPM.

Start an interactive package setup.

```sh title:"NPM Run Init"
npm init
```
<!-- cheat -->

### Init yes

Run init yes with NPM.

Create a package with defaults.

```sh title:"NPM Run Init Yes"
npm init -y
```
<!-- cheat -->

### Install dependencies

Install dependencies with NPM.

Install dependencies from `package.json`.

```sh title:"NPM Install Dependencies"
npm install
```
<!-- cheat -->

### Install package

Install package with NPM.

Install a package.

```sh title:"NPM Install Package"
npm install "$package_name"
```
<!-- cheat
var package_name
-->

### Install dev package

Install dev package with NPM.

Install a package as a dev dependency.

```sh title:"NPM Install Dev Package"
npm install "$package_name" --save-dev
```
<!-- cheat
var package_name
-->

### Install global

Install global with NPM.

Install a package globally.

```sh title:"NPM Install Global"
npm install "$package_name" -g
```
<!-- cheat
var package_name
-->

## nvm

### Install node

Install node with NPM.

Install a Node.js version with nvm.

```sh title:"NPM Install Node"
nvm install "$version"
```
<!-- cheat
var version
-->

### List remote

List remote with NPM.

List available Node.js versions.

```sh title:"NPM List Remote"
nvm ls-remote
```
<!-- cheat -->

### Use version

Run use version with NPM.

Use an installed Node.js version.

```sh title:"NPM Run Use Version"
nvm use "$version"
```
<!-- cheat
var version
-->

### Default version

Set default version with NPM.

Set the default Node.js version.

```sh title:"NPM Set Default Version"
nvm alias default "$version"
```
<!-- cheat
var version
-->
