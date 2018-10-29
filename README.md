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
ln -s $HOME/.config/X11/Xmodmap $HOME/.Xmodmap
ln -s $HOME/.config/X11/xprofile $HOME/.xprofile
ln -s $HOME/.config/fbterm/fbtermrc $HOME/.fbtermrc
```

#### 3. Other settings

##### SSH Agent

```bash
systemctl --user enable --now ssh-agent
```
