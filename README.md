# Agent Ruler

#### Portable configuration for A.I coding agents. Including styles and skills.

## Table of Contents
1. Installation.
2. Usage and Commands.
3. Agentic Packs.

## Installation
Simply run the .sh or .bat file (install) depending on your operating system. 

For MacOS/Linux:
```bash
./install-ruler.sh
```

For Windows: 
```bat
cd scripts
install-ruller.bat
```

Then, follow these simple configuration commands to easily set up your coding agent into the rules.

## Usage and Commands
Ruler come with a set of commands. Here is the configuration set:
|Command|Usage|
|---|---|
|`ruler-init`| Initializes the packages rules inside the current directory, so any A.I coding agent will be able to read the rules inside this directory whenever launched inside it.|
|`ruler-remove`| Removes and deletes all initialized files (reversing `ruler-init`)|
|`ruler-setup`| A configuration command to set up the coding agent globally, not on a specified directory. Walks you through a set of steps that configures the package globally.|
|`ruler-install <package_name>`| Installs additional packages from internet. Packages are defined inside the github repository.|
|`ruler-browse`| Shows all current additional packages trusted to install and use.|
|`ruler-add <package_local_path>`| Adds a new package (from untrusted locations) to the agent.|
|`ruler-show`| Shows all installed packages locally.|

## Agentic Packs
For additional packages related to a certain programming language, you can install any and use. We provide a set of trusted and tested rules for each programming language. You are also free to download and install any other packages or build your own (though untrusted).

## A Word to Users
Thanks for using Ruler. Our agents packages manager. Feel free to give us your feedback too.