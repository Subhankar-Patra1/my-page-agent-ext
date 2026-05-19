#!/bin/bash

# ==============================================================================
# Configuration
# Change DOWNLOAD_URL to the actual URL where your zip file is hosted.
# NOTE: Ensure the zip contains the extension files directly, not inside a subfolder.
# ==============================================================================
DOWNLOAD_URL="https://oryonix-ai-downloads.s3.amazonaws.com/oryonix-ai-1.0.0-chrome.zip"
INSTALL_DIR="$HOME/Oryonix-AI"
ZIP_FILE="/tmp/oryonix-ai-1.0.0-chrome.zip"

echo "=========================================="
echo "  Oryonix AI Beta Extension Installer"
echo "=========================================="
echo ""

# Create install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "[*] Creating installation directory at $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

echo "[*] Downloading extension from server..."
curl -s -L -o "$ZIP_FILE" "$DOWNLOAD_URL"

echo "[*] Extracting extension to $INSTALL_DIR..."
unzip -o "$ZIP_FILE" -d "$INSTALL_DIR" > /dev/null

echo "[*] Cleaning up temporary files..."
rm "$ZIP_FILE"

echo "[*] Launching Browser with Oryonix AI..."
# 1. Attempt to find the default HTTP handler on macOS.
BUNDLE_ID=$(defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers 2>/dev/null | grep -B 1 'LSHandlerURLScheme = http;' | grep LSHandlerRoleAll | awk -F'"' '{print $2}')

# Check if the default browser is a Chromium browser (Safari/Firefox don't support --load-extension)
IS_CHROMIUM=false
if [[ "$BUNDLE_ID" == *"chrome"* || "$BUNDLE_ID" == *"edge"* || "$BUNDLE_ID" == *"brave"* || "$BUNDLE_ID" == *"arc"* || "$BUNDLE_ID" == *"opera"* || "$BUNDLE_ID" == *"vivaldi"* ]]; then
    IS_CHROMIUM=true
fi

if [ -n "$BUNDLE_ID" ] && [ "$IS_CHROMIUM" = true ]; then
    echo "[+] Using default browser: $BUNDLE_ID"
    # We pass a URL to bypass the Chrome Profile Picker
    open -b "$BUNDLE_ID" --args --load-extension="$INSTALL_DIR" "https://google.com"
else
    # 2. Fallback to Chromium browsers if default is Safari/Firefox or unknown
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
        echo "[!] No Chromium-based browser found!"
        echo "[!] Please install Google Chrome, Edge, or Brave to use this extension."
    fi
fi

echo ""
echo "======================================================================"
echo "[!] Installation complete! Your browser should open automatically."
echo "[!] The extension files are saved permanently in: $INSTALL_DIR"
echo ""
echo "[i] Want to load it in a different browser manually?"
echo "    Copy and paste one of these commands into your terminal:"
echo ""
echo "    Edge:   open -a \"Microsoft Edge\" --args --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
echo "    Brave:  open -a \"Brave Browser\" --args --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
echo "    Chrome: open -a \"Google Chrome\" --args --load-extension=\"$INSTALL_DIR\" \"https://google.com\""
echo "======================================================================"
echo ""
echo "[!] You can now safely close this window."
