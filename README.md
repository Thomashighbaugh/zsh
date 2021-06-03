# zsh configuration


## Introduction
This configuration utilizes a modular approach to assembling a collection of zsh configurations that are arranged in a modular format where the various topical elements of the configuration have been placed within their own files, within the `modules` subdirectory specifically. This enables easier maintenance to the configuration and allows me to add in plugins, portions of other configurations and more without needing a plugin manager or other third party tool of dubious quality. 


## Interconnection to my Dotfiles Ecosystem 

This repository and its configurations are installed on my system via my [dotfiles](https://github.com/Thomashighbaugh/dotfiles) installation script and are intended to function within that overall ecosystem. As such, the template `zshenv` file calls my `.profile` and `.aliases` files that are where my shell agnostic configurations are stored. You probably want to remove these source statements, or make your own variants I suppose, in order to integrate this configuration best into your environment if you intend to bring it in alone. 

## Installation
To install the repository locally, first backup any files that make up your current configuration such that they are not lost as you may want to add pieces there of back in or hate this configuration's work flow entirely and will thus have a way of returning to your current configuration. Once complete you can install using two methods, outlined below.

### Method One: Just the ZSH
If you have no need for any of my other configurations and don't like using a TUI menu to select configurations to install then the process of obtaining this configuration locally is:
```bash
git clone https://github.com/Thomashighbaugh/zsh .zsh

sh .zsh/install 

```

### Method Two: Dotfiles in General

For those who want a more full experience of my configuration, including more programs than I even want to type out and a fancy menu to select what you want (for Arch based distros only, sorry to those using other systems stay tuned I might switch to Void Linux or Gentoo in the future as I tire of Systemd) 

## Credit Where It Is Due

based on the zsh configuration [dotzsh by dotphiles](https://github.com/dotphiles/dotzsh)

All plugins are the property of their respective owners, see the licenses within their subrepos for more. 
