# $HOME/.config

This repository is `$HOME/.config` which I use on my desktop Linux.

## Environment

I'm using this repository in the following environment.

### Operating System

Arch Linux

### Command Line

I prefer to use fish shell and command line tools made of Rust.

I have used Zsh in the past.
See the git history to see its configuration file.

For example, I have installed the following packages.

- fish
- tmux
- neovim
- git
- openssh
- coreutils
- ripgrep
- exa
- bat
- git-delta
- unarchiver

### Desktop Environment

I prefer Sway (Wayland) as Window Manager.

I have used Xmonad, Qtile and i3wm in the past.
See the git history to see their configuration files.

For example, I have installed the following packages.

- sway
- swaylock
- swayidle
- swaybg
- polkit
- xorg-xwayland
- qt5-wayland
- wofi
- waybar
- mako
- grim
- slurp
- wl-clipboard
- clipman
- alacritty

### Fonts

- noto-fonts{,-cjk,-emoji,-extra}
- otf-ipamjfont
- ttf-hack

## Setup

To use this repository, clone it to `$HOME.config`.

```bash
git clone git@github.com:yantene/config $HOME/.config
```

### Git

I don't want to commit my personal information to this repository,
so I don't put my git user settings in `/git/config`.

Therefore, write the following lines in `$HOME/.gitconfig`.

```
[user]
  email = contact@yantene.net
  name = yantene
  signingkey = contact@yantene.net
```

### SSH Agent

To auto-start the ssh agent, run the following once.

```bash
systemctl --user enable --now ssh-agent
```

### MPRIS

To auto-start the MPRIS proxy, run the following once.

```bash
systemctl --user enable --now mpris-proxy
```
