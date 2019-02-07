$HOME/.config
=============

## setup

### 1. Git clone

```bash
git clone git@github.com:yantene/config $HOME/.config
```

### 2. symbolic link を張る

```bash
ln -s $HOME/.config/zsh/.zshenv $HOME/.zshenv
ln -s $HOME/.config/X11/Xmodmap $HOME/.Xmodmap
ln -s $HOME/.config/X11/xprofile $HOME/.xprofile
ln -s $HOME/.config/fbterm/fbtermrc $HOME/.fbtermrc # 必要であれば
```

## dependency

この config ファイル群が必要とするパッケージ (すべてではない)

- zsh
- git
- hub
- neovim
- ripgrep
- skim
- yarn

## その他

### SSH Agent

```bash
systemctl --user enable --now ssh-agent
```

### \*env のインストール

install anyenv

```bash
git clone https://github.com/anyenv/anyenv $HOME/.anyenv
mkdir $HOME/.anyenv/plugins
git clone https://github.com/znz/anyenv-update $HOME/.anyenv/plugins
anyenv install --init
```

install ruby

```bash
anyenv install rbenv
rbenv install 2.6.1
rbenv global 2.6.1
```

install node

```bash
anyenv install nodenv
nodenv install 8.15.0
nodenv install 10.15.1
nodenv global 8.15.0
```

### linter のインストール

主に vim で使っているもの

```bash
gem install rubocop
yarn global add eslint stylelint
```

### language servers のインストール

```bash
yarn global add vue-language-server
yarn global add javascript-typescript-langserver
gem install solargraph haml-lint
```
