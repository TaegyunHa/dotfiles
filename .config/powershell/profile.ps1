$startTime = Get-Date

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Fast operations first
Import-Module Microsoft.PowerShell.Security -ErrorAction SilentlyContinue

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"
$env:MINICONDA_EXE = "$env:USERPROFILE\miniconda3\Scripts\conda.exe"

# Alias# Aliases (fast)
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias ex explorer
Set-Alias dm 'C:\Program Files\d3 Production Suite\build\msvc\d3manager.exe'

# PSReadLine configuration (fast)
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord "Ctrl+l" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+shift+l" -Function AcceptSuggestion
try {
    $options = Get-PSReadLineOption
    if ($options.PredictionSource -ne $null) {
        Set-PSReadLineOption -PredictionSource History
    }
} catch {
    # Suppress the error silently
}

# Utilities
function .. {
    param([int]$levels = 1)
    if ($levels -lt 1) { $levels = 1 }
    $relativePath = (1..$levels | ForEach-Object { '..' }) -join '\'
    Set-Location $relativePath
}

function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch {
    $file = $args[0]
    if ($file -eq $null) { throw "touch: missing file operand" }
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

function Import-PSFzf {
    if (-not (Get-Module -Name PSFzf)) {
        Remove-PSReadLineKeyHandler -Chord 'Ctrl+f'
        Remove-PSReadLineKeyHandler -Chord 'Ctrl+r'
        Import-Module PSFzf -ErrorAction SilentlyContinue
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
    }
}

function Initialize-OhMyPosh {
    if (-not (Get-Variable -Name omp_initialized -ErrorAction SilentlyContinue)) {
        $omp_config = Join-Path $PSScriptRoot ".\taegyun.ha.json"
        oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression
        Set-Variable -Name omp_initialized -Value $true -Scope Global
    }
}

# Once PSFzf is loaded, these key handlers will be removed
Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -ScriptBlock {
    Import-PSFzf
    Invoke-Fzf
}
Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock {
    Import-PSFzf
    Invoke-FuzzyHistory
}

# Initialize oh-my-posh immediately (required for prompt)
Initialize-OhMyPosh

Write-Host "PowerShell profile loaded in $(((Get-Date) - $startTime).TotalMilliseconds)ms" -ForegroundColor Blue
