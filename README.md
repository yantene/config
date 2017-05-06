$HOME/.config
=============

setup
-----

### 1. Git clone

```bash
git clone git@github.com:yantene/config $HOME/.config
```

#### 2. Solution to issue of boot strap

```bash
ln -s $HOME/.config/zsh/.zshenv $HOME/.zshenv
mkdir -p $HOME/.xmonad
ln -s $HOME/.config/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
ln -s $HOME/.config/X11/Xmodmap $HOME/.Xmodmap
ln -s $HOME/.config/fbterm/fbtermrc $HOME/.fbtermrc
```
