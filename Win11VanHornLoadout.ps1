winget install --id=AgileBits.1Password -e --accept-package-agreements
winget install --id=AgileBits.1Password.CLI -e
winget install --id Microsoft.PowerShell --source winget
wsl --install -n Ubuntu
winget install --id Docker.DockerDesktop -e --source winget
winget install --id Git.Git -e --source winget
winget install -e --id Python.Python.3.12 --scope machine
winget install OpenJS.NodeJS.LTS
winget install vscodium
winget install Microsoft.DotNet.SDK.9
winget install Microsoft.DotNet.DesktopRuntime.9
winget install Microsoft.DotNet.AspNetCore.9
winget install --id=Microsoft.VisualStudio.2022.BuildTools -e
winget install JanDeDobbeleer.OhMyPosh -s winget
winget install --id=WinMerge.WinMerge -e
winget install --id=Postman.Postman -e
winget install --id=Brave.Brave -e
winget install --id=Oracle.JavaRuntimeEnvironment -e
winget install --id=GIMP.GIMP -e
winget install --id=MongoDB.DatabaseTools -e
winget install --id=Amazon.Kindle -e
winget install --id=SomePythonThings.WingetUIStore -e
winget install --id=Inkscape.Inkscape -e
winget install --id=Neovim.Neovim -e
winget install --id=beekeeper-studio.beekeeper-studio -e
winget install --id=Termius.Termius -e
winget install --id=Notepad++.Notepad++ -e
winget install DevToys-app.DevToys

# Set up my start menu the way I want it
Import-StartLayout -Path ".\.StartMenuLayout.json" -MountPath $env:SystemDrive\

# Set up my terminal with Oh-My-Posh
# nerd fonts
oh-my-posh font install 0xProto
oh-my-posh font install DaddyTimeMono
oh-my-posh font install DroidSansMono
oh-my-posh font install FirraCode
oh-my-posh font install Hack
oh-my-posh font install NerdFontsSymbolsOnly
oh-my-posh font install Ubuntu

$profilePath = $PROFILE
if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}

# Define paths
$themeDir = "$HOME\.poshthemes"
$themePath = "$themeDir\custom.omp.json"
$gistUrl = "https://gist.githubusercontent.com/brucevanhorn2/2710cdfd8a85f4473c1efc3b9c9c2a52/raw/1f2d049b07b5918fda8258c115bd801d708e298d/1_shell.omp.json"

# Create .poshthemes directory if it doesn't exist
if (!(Test-Path -Path $themeDir)) {
    New-Item -ItemType Directory -Path $themeDir -Force
}

# Download the theme file
Invoke-WebRequest -Uri $gistUrl -OutFile $themePath


# Update PowerShell Profile to use the downloaded theme
$profilePath = $PROFILE
if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}

# Add Oh My Posh initialization to profile
$ompInit = "`noh-my-posh init pwsh --config `"$themePath`" | Invoke-Expression"
if (-not (Select-String -Path $profilePath -Pattern "oh-my-posh init pwsh" -Quiet)) {
    Add-Content -Path $profilePath -Value "`n$ompInit"
}

# Restart PowerShell for changes to apply
Write-Host "Oh My Posh has been set up with your custom theme. Restart PowerShell to apply changes." -ForegroundColor Green
