# xp-toolset

## Introduction

This repository is a collection of simple scripts used in a local organization called XP Ängelholm. These are structured to be used by people with limited technical abilities, therefore advanced tools such as applications are contained in seperate repositories.

## Scripts

### user-removal

These scripts are designed to be executed during startup and deletes user information to forcefully logout users of applications not affected by a similar process done by ggLeap.

### installer-scripts

The scripts found in _installer-scripts_ are used to simplify the install process for the other scripts. A seperate folder is used instead of dividing the install scripts based on usage to simplify the main install script.

## Main installer

### Create an exe file from the ps1 file

1. Open PowerShell in the root folder.
2. Execute `Install-Module -Name ps2exe -Force`.
3. Execute `ps2exe .\main-installer.ps1 .\main-installer.exe`

### Installing using main installer

1. Start the computer in administrator mode.
2. Download all files by pressing the green button with the text _Code_ and press _Download as Zip_.
3. Extract the ZIP file.
4. Open the resulting folder.
5. Click on _main-installer.exe_.
