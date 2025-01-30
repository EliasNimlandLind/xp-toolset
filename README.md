# xp-toolset

## Introduction

This repository is a collection of simple scripts used in a local organization called XP Ängelholm. These are structured to be used by people with limited technical abilities, therefore advanced tools such as applications are contained in seperate repositories.

## Scripts

### user-removal

These scripts are designed to be executed during startup and deletes user information to forcefully logout users of applications not affected by a similar process done by ggLeap.

### installer-scripts

The scripts found in _installer-scripts_ are used to simplify the install process for the other scripts. A seperate folder is used instead of dividing the install scripts based on usage to simplify the main install script.

## Preparing files and installing

### Building files

1. Open PowerShell in the root folder.
2. Execute `Install-Module -Name ps2exe -Force`.
3. Execute `build.ps1`.
4. The files are found in _distribution_.

### Installing

1. Start the computer in administrator mode.
2. Go to [the download page](https://github.com/EliasNimlandLind/xp-toolset/releases/).
3. Click on _distribution.zip_ to start the download.
4. Extract the ZIP file.
5. Open the resulting folder.

#### Installing using the main installer

6. Click on _main-installer.exe_.

#### Installing each script seperately

6. Open _installer-scripts_.
7. Click on each file seperately.
