---
title: "Declarative and Reproducible System and User Management With Nixos"
date: 2021-07-14T18:15:26+02:00
tags: ["nixos", "nix"]
type: "post"
---

I've been using [NixOS](https://nixos.org/) as my main operating system for quite some time now.

As I recently upgraded my computer equipment by acquiring a new laptop, I decided that it's time to invest some more time into further capitalizing on the features of NixOS.
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
Turns out the [home-manager](https://github.com/nix-community/home-manager) project is adding tons of user-specific configuration options to the NixOS ecosystem.

To keep the configurations of my laptop and my desktop in sync with each other, I want to store my configuration in some git repository (added benefit: version control).
This way, whenever I for example add a `vim` macro for editing LaTeX files, I'll only have to commit my changes to the git repository and execute (something similar to)
```bash
git pull origin master
sudo nixos-rebuild switch
```
on my desktop to have the exact same configuration applied on my desktop as well.

# My current setup
As both NixOS as well as home-manager still often lack proper documentation, I ended up mostly reading other people's configuration files and stealing things from there.

Since it seems like the next major update of the nix package manager will introduce [nix flakes](https://nixos.wiki/wiki/Flakes), I decided to set up my system configuration using flakes as a (fairly stable) experimental feature.
My current `flake.nix` file looks as follows:

```nix
{
  description = "tim's personal flake";

  inputs = rec {

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-21.05";
    };

    unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

  };

  outputs = {self, nixpkgs, unstable, home-manager, nixos-hardware, nur} :
  let
    lib = nixpkgs.lib;
  in
  {

    nixosConfigurations = {

      thinkpad = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [

          nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1

          home-manager.nixosModules.home-manager

          ./machines/thinkpad/configuration.nix
        ];
      };

    };

    thinkpad = self.nixosConfigurations.thinkpad.config.system.build.toplevel;
  };
}
```

The `inputs` record consists of all repositories that would otherwise be manually added to the available `nix-channels`.
In my case, I usually use the most recent stable version of NixOS and its package tree `nixpkgs`.
In case I need some test features (like `flakes`!), I have the `unstable` input source pointing to the current `nixos-unstable` git repository.
`home-manager` also comes with its own set of nix expressions, `nixos-hardware` has some hardware-specific nix expressions that come in handy for my laptop and finally `nur` is the Nix User Repository.

Then I declare one configuration for my laptop `thinkpad` that uses the laptop-specific nix expressions of `nixos-hardware`, enables `home-manager` and refers to a `configuration.nix` file that I specifically prepared for this machine with it's hardware-specific like partitioning etc.

This configuration file also includes all the remaining configuration I want to use.

The rough setup is as follows:

```bash
tims-flake/
├── flake.lock
├── flake.nix
├── machines/
│   ├── defaultMachine.nix
│   └── thinkpad/
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── thinkpad.nix
├── modules/
│   ├── custom/
│   │   ├── hm/
│   │   │   ├── default.nix
│   │   │   ├── dev/
│   │   │   │   ├── nix/
│   │   │   │   │   └── nix.nix
│   │   │   │   └── latex/
│   │   │   │       ├── latex.nix
│   │   │   │       └── config/
│   │   │   │           └── tex.vim
│   │   │   └── media/
│   │   │       └── ...
│   │   └── nixos/
│   │       ├── sys/
│   │       │   ├── ...
│   │       │   └── ...
│   │       ├── wm/
│   │       │   ├── x11/
│   │       │   │   └── x11.nix
│   │       │   └── gnome/
│   │       │       └── gnome.nix
│   │       └── default.nix
│   └── default.nix
├── profiles/
│   ├── default.nix
│   ├── development.nix
│   ├── multimedia.nix
│   └── research.nix
└── users/
    └── tim/
        ├── base.nix
        ├── default.nix
        └── networks/
            └── eduroam.nix
```

With this general setup, I now implement the system configuration as I see fit.
For example, here's the content of the `latex.nix` file of above:

```bash
### HOME MANAGER MODULE
{ config, lib, pkgs, ... } :

with lib;

let cfg = config.custom.hm.dev.latex;

in

{

  ### interface
  options = {

    custom.hm.dev.latex.enable     = mkEnableOption "config for latex";

    custom.hm.dev.latex.vim.enable = mkEnableOption "enable vim with latex plugins";

  };

  ### implementation
  config = mkMerge [

    (mkIf cfg.enable {

      home.packages = with pkgs; [

        # install texlive with all available packages
        texlive.combined.scheme-full

        # install the zathura pdf viewer (vim keybindings)
        zathura

        # also install texstudio
        texstudio
      ];
    })

    (mkIf cfg.vim.enable {

      programs.vim = {

        enable = true;

        plugins = with pkgs.vimPlugins; [
          vimtex
          ultisnips
          YouCompleteMe
        ];

        # enable custom settings for each filetype
        extraConfig =
        ''
        filetype plugin on
        '';
      };

      # use custom settings for .tex files
      home.file = {

        ".vim/ftplugin/tex.vim".source = ./config/tex.vim;

      };
    })
  ];
}
```

# Workflow
Since I'm using nix flakes, I need to change the update procedure a little bit:

```bash
sudo nix flake update .

git add -A
git commit -m "flake update."
git push origin master

sudo nixos-rebuild --switch --flake .
```

First, I update the flake, then I upload the changes to its git repository and then I tell NixOS to rebuild itself using the updated flake.

