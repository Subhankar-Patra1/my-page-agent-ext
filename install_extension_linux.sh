#!/bin/bash

# ==============================================================================
# Configuration
# Change DOWNLOAD_URL to the actual URL where your zip file is hosted.
# NOTE: Ensure the zip contains the extension files directly, not inside a subfolder.
# ==============================================================================
DOWNLOAD_URL="https://oryonix-ai-downloads.s3.us-east-1.amazonaws.com/oryonix-ai-1.0.1-chrome.zip"
INSTALL_DIR="$HOME/Oryonix AI"
ZIP_FILE="/tmp/oryonix-ai-1.0.1-chrome.zip"

echo "=========================================="
echo "  Oryonix AI Beta Extension Installer (Linux)"
echo "=========================================="
echo ""

# Create install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "[*] Creating installation directory at $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

echo "[*] Downloading extension from server..."
if command -v curl >/dev/null 2>&1; then
    curl -s -L -o "$ZIP_FILE" "$DOWNLOAD_URL"
elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$ZIP_FILE" "$DOWNLOAD_URL"
else
    echo "[!] Error: curl or wget is required to download the extension."
    exit 1
fi

echo "[*] Extracting extension to $INSTALL_DIR..."
if command -v unzip >/dev/null 2>&1; then
    unzip -o "$ZIP_FILE" -d "$INSTALL_DIR" > /dev/null
elif command -v python3 >/dev/null 2>&1; then
    python3 -m zipfile -e "$ZIP_FILE" "$INSTALL_DIR"
else
    echo "[!] Error: unzip or python3 is required to extract the extension."
    exit 1
fi

# Clean up temporary files
rm -f "$ZIP_FILE"

echo "[*] Launching Browser with Oryonix AI..."
# Find available chromium-based browsers in Linux
LAUNCHED=false

# Try to launch standard chromium-based browsers
if command -v google-chrome >/dev/null 2>&1; then
    echo "[+] Using browser: Google Chrome"
    google-chrome --load-extension="$INSTALL_DIR" "https://google.com" &
    LAUNCHED=true
elif command -v google-chrome-stable >/dev/null 2>&1; then
    echo "[+] Using browser: Google Chrome Stable"
    google-chrome-stable --load-extension="$INSTALL_DIR" "https://google.com" &
    LAUNCHED=true
elif command -v brave-browser >/dev/null 2>&1; then
    echo "[+] Using browser: Brave Browser"
    brave-browser --load-extension="$INSTALL_DIR" "https://google.com" &
    LAUNCHED=true
elif command -v chromium-browser >/dev/null 2>&1; then
    echo "[+] Using browser: Chromium Browser"
    chromium-browser --load-extension="$INSTALL_DIR" "https://google.com" &
    LAUNCHED=true
elif command -v chromium >/dev/null 2>&1; then
    echo "[+] Using browser: Chromium"
    chromium --load-extension="$INSTALL_DIR" "https://google.com" &
    LAUNCHED=true
elif command -v microsoft-edge >/dev/null 2>&1; then
    echo "[+] Using browser: Microsoft Edge"
    microsoft-edge --load-extension="$INSTALL_DIR" "https://google.com" &
    LAUNCHED=true
elif command -v firefox >/dev/null 2>&1; then
    echo "[+] Using browser: Firefox (Directing to debugging page)"
    firefox "about:debugging#/runtime/this-firefox" &
    LAUNCHED=true
fi

if [ "$LAUNCHED" = false ]; then
    echo "[!] No default browser could be launched automatically."
    echo "[!] Please open your browser and load the extension manually."
fi

echo ""
echo "======================================================================"
echo "[!] Installation complete! Your browser should open automatically."
echo "[!] The extension files are saved permanently in: $INSTALL_DIR"
echo ""
echo "[i] Want to load it in a different browser manually?"
echo "    Copy and paste one of these commands into your terminal:"
echo ""
echo "    Chrome:  google-chrome --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
echo "    Brave:   brave-browser --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
echo "    Edge:    microsoft-edge --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
echo "    Firefox: firefox \"about:debugging#/runtime/this-firefox\""
echo ""
echo "    Or, load it manually through the browser interface:"
echo "    - Chrome / Brave / Edge:"
echo "      1. Type chrome://extensions in your URL bar (or edge://extensions / brave://extensions)."
echo "      2. Toggle \"Developer mode\" in the top right to ON."
echo "      3. Click the \"Load unpacked\" button in the top left."
echo "      4. Select the installation folder: $INSTALL_DIR"
echo ""
echo "    - Firefox:"
echo "      1. Type about:debugging in your URL bar and click \"This Firefox\" on the left."
echo "      2. Click the \"Load Temporary Add-on...\" button."
echo "      3. Select the manifest.json file inside: $INSTALL_DIR"
echo "======================================================================"
echo ""
echo "[!] You can now safely close this window."
