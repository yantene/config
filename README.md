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

### 3. xmonad バイナリを配置するディレクトリを作成

`~/.xmonad` ディレクトリを削除。

```bash
rm -rf ~/.xmonad
```

XDG 対応のディレクトリを作成。

```bash
mkdir -p $XDG_DATA_HOME/xmonad
```

## dependency

この config ファイル群が必要とするパッケージ (すべてではない)

- coreutils
- grep
- gawk
- sed
- zsh
- zsh-syntax-highlighting
- git
- anyenv
- neovim
- ripgrep
- skim
- git-delta
- exa
- yarn

## その他

### git の user 設定

個人に依存するファイルをここで管理したくないため、
git の user 設定は `git/config` には記述していない。

`$HOME/.gitconfig` に以下のようなファイルを配置する。

```bash
[user]
  email = contact@yantene.net
  name = yantene
  signingkey = contact@yantene.net
```

### SSH Agent

```bash
systemctl --user enable --now ssh-agent
```

### \*env のインストール

install anyenv

Install from AUR or...

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

### Neovim のセットアップ

#### CoC

CoC プラグインをインストール。
nvim 内にて以下を実行。

```
CocInstall coc-sh coc-clangd coc-css coc-html coc-tsserver coc-vetur coc-json coc-docker coc-sql coc-solargraph
```

CoC やプラグインが依存するパッケージをインストール。

```bash
yay -S \
  nodejs \
  clang \
  terraform-lsp-bin \
  efm-langserver

gem install \
  solargraph
```

efm-langserver が利用できる linter 類をインストール。

cf. https://github.com/tsuyoshicho/vim-efm-langserver-settings

```bash
yay -S \
  shellcheck \
  pandoc \
  jq

npm i -g \
  jsonlint \
  fixjson \
  htmllint \
  markdownlint-cli
```

その他、`textlint`、`rubocop`、`eslint`、`stylelint` などは、
プロジェクトごとの bundler や npm でインストールすると発動するみたい。
