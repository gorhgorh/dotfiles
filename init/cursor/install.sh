#!/usr/bin/env zsh

# Function to install Cursor configuration
function install_cursor_config() {
    echo "Installing Cursor configuration..."
    mkdir -p ~/Library/Application\ Support/Cursor/User/
    cp ~/init/cursor/settings.json ~/Library/Application\ Support/Cursor/User/
    cp ~/init/cursor/keybindings.json ~/Library/Application\ Support/Cursor/User/

    echo "Installing Cursor extensions..."
    while read extension; do
        code --install-extension "$extension"
    done < ~/init/cursor/extensions.txt

    echo "Cursor configuration installed successfully!"
}

# Run the function
install_cursor_config
