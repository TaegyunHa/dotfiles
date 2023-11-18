# PowerShell Setup

## Modules

- Terminal-Icons
- z
- PSReadLine
- PSFzf

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name z -Force
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name PSFzf -Scope CurrentUser -Force
```

## Scoop

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm get.scoop.sh | iex
```

**neovim | gcc | fzf**

```powershell
scoop install neovim gcc fzf sudo
```

## Git

```powershell
winget install -e --id Git.Git
```

## Oh My Posh

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

**Font**

```powershell
oh-my-posh font install # install Hack
```

<br>

# Load Settings on Start

```
nvim $PROFILE.CurrentUserCurrentHost
```

### $PROFILE.CurrentUserCurrentHost

```
. $env:USERPROFILE\.config\powershell\profile.ps1
```

<br>

# Colour Scheme

```json
{
    "background": "#001B26",
    "black": "#282C34",
    "blue": "#61AFEF",
    "brightBlack": "#5A6374",
    "brightBlue": "#61AFEF",
    "brightCyan": "#56B6C2",
    "brightGreen": "#98C379",
    "brightPurple": "#C678DD",
    "brightRed": "#E06C75",
    "brightWhite": "#DCDFE4",
    "brightYellow": "#E5C07B",
    "cursorColor": "#FFFFFF",
    "cyan": "#56B6C2",
    "foreground": "#DCDFE4",
    "green": "#98C379",
    "name": "One Half Dark (mod)",
    "purple": "#C678DD",
    "red": "#E06C75",
    "selectionBackground": "#FFFFFF",
    "white": "#DCDFE4",
    "yellow": "#E5C07B"
},
```

<br>

# Anaconda

**Remove prefix of anaconda virtual environment**

```powershell
conda config --set changeps1 false
```
