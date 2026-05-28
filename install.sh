#!/bin/bash

# ==============================================================================
# Configuration
# Change DOWNLOAD_URL to the actual URL where your zip file is hosted.
# NOTE: Ensure the zip contains the extension files directly, not inside a subfolder.
# ==============================================================================
DOWNLOAD_URL="https://oryonix-ai-downloads.s3.us-east-1.amazonaws.com/oryonix-ai-1.0.1-chrome.zip"
INSTALL_DIR="$HOME/Oryonix AI"
ZIP_FILE="/tmp/oryonix-ai-1.0.1-chrome.zip"

# Detect Operating System
OS_TYPE="$(uname -s)"

echo "=========================================="
if [ "$OS_TYPE" = "Darwin" ]; then
    echo "  Oryonix AI Beta Extension Installer (macOS)"
else
    echo "  Oryonix AI Beta Extension Installer (Linux)"
fi
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

if [ "$OS_TYPE" = "Darwin" ]; then
    # ================= macOS Launch Logic =================
    BUNDLE_ID=$(defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers 2>/dev/null | grep -B 1 'LSHandlerURLScheme = http;' | grep LSHandlerRoleAll | awk -F'"' '{print $2}')
    
    IS_CHROMIUM=false
    if [[ "$BUNDLE_ID" == *"chrome"* || "$BUNDLE_ID" == *"edge"* || "$BUNDLE_ID" == *"brave"* || "$BUNDLE_ID" == *"arc"* || "$BUNDLE_ID" == *"opera"* || "$BUNDLE_ID" == *"vivaldi"* ]]; then
        IS_CHROMIUM=true
    fi

    if [ -n "$BUNDLE_ID" ] && [ "$IS_CHROMIUM" = true ]; then
        echo "[+] Using default browser: $BUNDLE_ID"
        open -b "$BUNDLE_ID" --args --load-extension="$INSTALL_DIR" "https://google.com"
    else
        if [ -d "/Applications/Google Chrome.app" ] || [ -d "$HOME/Applications/Google Chrome.app" ]; then
            echo "[+] Using fallback browser: Google Chrome"
            open -a "Google Chrome" --args --load-extension="$INSTALL_DIR" "https://google.com"
        elif [ -d "/Applications/Microsoft Edge.app" ] || [ -d "$HOME/Applications/Microsoft Edge.app" ]; then
            echo "[+] Using fallback browser: Microsoft Edge"
            open -a "Microsoft Edge" --args --load-extension="$INSTALL_DIR" "https://google.com"
        elif [ -d "/Applications/Brave Browser.app" ] || [ -d "$HOME/Applications/Brave Browser.app" ]; then
            echo "[+] Using fallback browser: Brave Browser"
            open -a "Brave Browser" --args --load-extension="$INSTALL_DIR" "https://google.com"
        else
            echo "[!] No Chromium-based browser found automatically."
            echo "[!] Please open your browser and load the extension manually."
        fi
    fi
else
    # ================= Linux Launch Logic =================
    LAUNCHED=false
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
fi

echo ""
echo "======================================================================"
echo "[!] Installation complete! Your browser should open automatically."
echo "[!] The extension files are saved permanently in: $INSTALL_DIR"
echo ""
echo "[i] Want to load it in a different browser manually?"
if [ "$OS_TYPE" = "Darwin" ]; then
    echo "    Copy and paste one of these commands into your terminal:"
    echo ""
    echo "    Edge:   open -a \"Microsoft Edge\" --args --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
    echo "    Brave:  open -a \"Brave Browser\" --args --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
    echo "    Chrome: open -a \"Google Chrome\" --args --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
else
    echo "    Copy and paste one of these commands into your terminal:"
    echo ""
    echo "    Chrome:  google-chrome --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
    echo "    Brave:   brave-browser --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
    echo "    Edge:    microsoft-edge --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
fi
echo ""
echo "    Or, load it manually through the browser interface:"
echo "    1. Type chrome://extensions in your URL bar (or edge://extensions / brave://extensions)."
echo "    2. Toggle \"Developer mode\" in the top right to ON."
echo "    3. Click the \"Load unpacked\" button in the top left."
echo "    4. Select the installation folder: $INSTALL_DIR"
echo "======================================================================"
echo ""
echo "[!] You can now safely close this window."
