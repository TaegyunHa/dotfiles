# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\taegyun.ha.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord "Ctrl+l" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+shift+l" -Function AcceptSuggestion
# Set PredictionSource only if it's supported
try {
    $options = Get-PSReadLineOption
    if ($options.PredictionSource -ne $null) {
        Set-PSReadLineOption -PredictionSource History
    }
} catch {
    # Suppress the error silently
}

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias ex explorer
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function .. {
    param(
        [int]$levels = 1
    )
    # Ensure at least one level
    if ($levels -lt 1) {
        $levels = 1
    }
    else {
        # For more than 3 levels, build a single concatenated "..\..\..\..."
        # 1..$levels creates an array [1,2,…,$levels]; ForEach-Object { '..' } makes an array of '..' repeated
        # Joining with '\' yields "..\..\..\.." (as many times as $levels)
        $relativePath = (1..$levels | ForEach-Object { '..' }) -join '\'
        Set-Location $relativePath
    }
}

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch {
    $file = $args[0]
    if ($file -eq $null) {
        throw "touch: missing file operand"
    }

    if (Test-Path $file) {
        (Get-ChildItem $file).LastWriteTime = Get-Date
    } else {
        echo $null > $file
    }
}

function cwd {
    (pwd).Path | Set-Clipboard
}

# Anaconda utility
function myconda {
    param(
        [string]$cmd = "activate"
    )
    if ($cmd -eq "activate") {
        if (Test-Path "$env:MINICONDA_EXE") {
            (& "$env:MINICONDA_EXE" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
            (& Write-Output "Miniconda activated")
        }
    } else {
        & Write-Output "Invalid command"
    }
}
