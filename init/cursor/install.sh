#!/usr/bin/env zsh

# Function to install Cursor configuration
function install_cursor_config() {
    # Get the directory where this script is located (dotfiles/init/cursor)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    # Get the dotfiles root directory (two levels up from script)
    DOTFILES_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
    
    echo "Installing Cursor configuration..."
    mkdir -p ~/Library/Application\ Support/Cursor/User/
    cp "$DOTFILES_DIR/init/cursor/settings.json" ~/Library/Application\ Support/Cursor/User/
    cp "$DOTFILES_DIR/init/cursor/keybindings.json" ~/Library/Application\ Support/Cursor/User/

    echo "Installing Cursor extensions..."
    if [ -f "$SCRIPT_DIR/extensions.txt" ]; then
        while read extension; do
            cursor --install-extension "$extension"
        done < "$DOTFILES_DIR/init/cursor/extensions.txt"
    else
        echo "No extensions.txt file found, skipping extensions installation"
    fi

    echo "Cursor configuration installed successfully!"
}

# Run the function
install_cursor_config
