# Zsh Setup

## Reference

> https://www.josean.com/posts/terminal-setup

## Xcode command line tool

```
xcode-select --install
```

## Homebrew

> https://brew.sh

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### wget

```
brew install wget
```

## Oh-My-Zsh

> https://ohmyz.sh

```
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

### powerlevel10k theme 

```
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

Restart
```
p10k configure
```

iterm colour theme

```
https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/nord-light.itermcolors
```

### Auto completion

```
vim $ZSH_CUSTOM/shortcuts.zsh
```

```zsh
# $ZSH_CUSTOM/shortcuts.zsh

# autosuggest settings
bindkey '^]' autosuggest-accept
bindkey '^[' autosuggest-clear
```
