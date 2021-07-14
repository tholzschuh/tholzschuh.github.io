---
title: Declarative and Reproducible System and User Management with Nix(OS)
author: Tim Holzschuh
tags: nixos
---

I've been using [NixOS](https://nixos.org/) as my main operating system for quite some time now.

As I recently upgraded my computer equipment by acquiring a new laptop, I decided that it's time to invest some more time into further capitalizing on the feature of NixOS.
The main purpose of this post is to collect all the things I learned while doing so in a single place so that I'll always be able to look it up again if need be.

# Overview
In NixOS, the whole system configuration takes place in a single file, `/etc/nixos/configuration.nix`:

```nix
  { config, pkgs, ... } :

  {
    # boot configuration
    boot.loader.systemd-boot.enable      = true;
    boot.loader.efi.canTouchEfiVariables = true;

    ...

    # set timezone to Berlin
    time.timeZone = "Europe/Berlin";

    ...

    # set up user "tim"
    users.users.tim = {
      isNormalUser = true;
      ...
    };

    # install firefox
    environment.systemPackages = [ pkgs.firefox ]; 
  }
```

I want to use a single repository of customized nix configurations to set up both my laptop as well as my desktop as easily as possible.

As I usually use my laptop and my desktop for similar but not exactly identical tasks, I want the configuration to be as *modular* as possible:
For example, there should be a module enabling and setting up LaTeX exactly as I use it: texlive with this and that package, my favorite text editor [vim](https://www.vim.org/download.php) set up with additional plugins to support LaTeX syntax highlighting et cetera.

If I now plan to use LaTeX on a computer, I essentially just want to add something like
```nix
  custom.latex.enable = true;
```
in my `configuration.nix` to have my LaTeX tools installed and customized exactly like I want them to be.

For practical as well aesthetical reasons, I'd like this configuration to be user-specific whenever possible:
I don't want to configure `vim` globally on the whole machine, but just the user I'm writing LaTeX code on.
(What if someone else would want to write some LaTeX on my laptop?)
Turns out the [home-manager](https://github.com/nix-community/home-manager) project is adding tons of user-specific configuration options to the NixOS Ecosystem.

To keep the configurations of my laptop and my desktop in sync with each other, I want to store my configuration in some git repository (added benefit: version control).
This way, whenever I for example add a `vim` macro for my editing a LaTeX file, I'll only have to commit my changes to the git repository and execute
```bash
git pull origin master
sudo nixos-rebuild switch
```
on my desktop to have the exact same configuration applied on my desktop as well.

# My current setup
As both NixOS as well as home-manager still often lack proper documentation, I ended up mostly reading other people's configuration files and stealing things from there.

My current configuration looks roughly like this:
```bash
nixos-conf
+-- machines
|   +-- defaultMachine.nix
|   +-- thinkpad.nix
|   +-- desktop.nix
|   +-- ...
+-- modules
|   +-- nixos
    |   +-- sys
        |   +-- ...
    |   +-- wm
        |   +-- gnome
	    |   +-- ...
        +-- ...    
|   +-- hm
    |   +-- dev
        |   +-- latex
            |   +-- latex.nix
            |   +-- config
	            |   +-- tex.vim
	    |   +-- haskell
            |  +-- haskell.nix
	        |  +-- config
               |   +-- hs.vim
	|   +-- ...
+-- profiles
|   +-- development.nix
|   +-- ...
+-- users
|   +-- tim
    |  +-- default.nix
```


