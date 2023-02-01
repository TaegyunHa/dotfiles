# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\taegyun.ha.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

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
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
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

# Anaconda utility
function anaconda {
    $command = $args[0]
    if($null -eq $command) {
        throw "anaconda: missing command [activate/deactivate]"
    }
    
    if ($command -eq "activate") {
        Start-Process -FilePath $env:userprofile\Anaconda3\condabin\conda.bat -ArgumentList "init powershell" -Wait -NoNewWindow
        Invoke-Command { & "pwsh.exe" } -NoNewScope
    } elseif ($command -eq "deactivate") {
        Start-Process -FilePath $env:userprofile\Anaconda3\condabin\conda.bat -ArgumentList "init powershell --reverse" -Wait -NoNewWindow
        Invoke-Command { & "pwsh.exe" } -NoNewScope
    } else {
        throw "anaconda: missing command [activate/deactivate]"
    }
}
