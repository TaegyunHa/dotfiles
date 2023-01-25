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

<br>

## Scoop

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm get.scoop.sh | iex
```

### neovim | gcc

```powershell
scoop install neovim gcc
```

<br>

## Git

```powershell
winget install -e --id Git.Git
```

<br>

## Oh My Posh

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

### Font

```powershell
oh-my-posh font install # install Hack
```

<br>


<br>

# Load Settings on Start

```
nvim $PROFILE.CurrentUserCurrentHost
```

### $PROFILE.CurrentUserCurrentHost

```
. $env:USERPROFILE\.config\powershell\profile.ps1
```
