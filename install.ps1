$DownloadUrl = "https://oryonix-ai-downloads.s3.us-east-1.amazonaws.com/oryonix-ai-1.0.1-chrome.zip"
$InstallDir = "C:\Oryonix AI"
$ZipFile = Join-Path $env:TEMP "oryonix-ai-1.0.1-chrome.zip"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Oryonix AI Beta Extension Installer (Windows)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Create install directory if it doesn't exist
if (-not (Test-Path $InstallDir)) {
    Write-Host "[*] Creating installation directory at $InstallDir..." -ForegroundColor Gray
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
}

Write-Host "[*] Downloading extension from server..." -ForegroundColor Gray
try {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipFile -UseBasicParsing
} catch {
    Write-Error "[!] Error: Failed to download the extension. Check your internet connection."
    exit 1
}

Write-Host "[*] Extracting extension to $InstallDir..." -ForegroundColor Gray
try {
    Expand-Archive -Path $ZipFile -DestinationPath $InstallDir -Force
} catch {
    Write-Error "[!] Error: Failed to extract extension."
    exit 1
}

# Clean up
if (Test-Path $ZipFile) {
    Write-Host "[*] Cleaning up temporary files..." -ForegroundColor Gray
    Remove-Item -Path $ZipFile -Force
}

Write-Host "[*] Launching Browser with Oryonix AI..." -ForegroundColor Gray
$BrowserPath = $null
$ProgId = (Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice' -ErrorAction SilentlyContinue).ProgId
if ($ProgId) {
    $Cmd = (Get-ItemProperty "HKCR:\$ProgId\shell\open\command" -ErrorAction SilentlyContinue).'(default)'
    if ($Cmd) {
        if ($Cmd -match '"(.*?)"') {
            $BrowserPath = $matches[1]
        } else {
            $BrowserPath = $Cmd.Split(' ')[0]
        }
    }
}

if (-not $BrowserPath) {
    $CommonPaths = @(
        "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
        "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
        "$env:LocalAppData\Google\Chrome\Application\chrome.exe",
        "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
    )
    foreach ($path in $CommonPaths) {
        if (Test-Path $path) {
            $BrowserPath = $path
            break
        }
    }
}

if (-not $BrowserPath) {
    $BrowserPath = "msedge.exe"
}

Write-Host "[+] Using browser: $BrowserPath" -ForegroundColor Green
Start-Process -FilePath $BrowserPath -ArgumentList "--load-extension=`"$InstallDir`"", "https://google.com"

Write-Host ""
Write-Host "======================================================================" -ForegroundColor Yellow
Write-Host "[!] Installation complete! Your browser should open automatically." -ForegroundColor Green
Write-Host "[!] The extension files are saved permanently in: $InstallDir" -ForegroundColor Green
Write-Host ""
Write-Host "[i] Want to load it in a different browser manually?" -ForegroundColor Gray
Write-Host "    Run one of these commands in Command Prompt:" -ForegroundColor Gray
Write-Host ""
Write-Host "    Edge:   start msedge.exe --load-extension=`"$InstallDir`" `"https://google.com`"" -ForegroundColor Gray
Write-Host "    Brave:  start brave.exe --load-extension=`"$InstallDir`" `"https://google.com`"" -ForegroundColor Gray
Write-Host "    Chrome: start chrome.exe --load-extension=`"$InstallDir`" `"https://google.com`"" -ForegroundColor Gray
Write-Host "======================================================================" -ForegroundColor Yellow
Write-Host ""
