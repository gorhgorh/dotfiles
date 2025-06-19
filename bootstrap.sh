#!/usr/bin/env zsh

cd "$(dirname "${(%):-%x}")";

git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;

	# Check if running on macOS
	if [[ "$OSTYPE" == "darwin"* ]]; then
		echo "Running on macOS, installing Homebrew packages..."
		brew bundle
	fi

	#install nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

	#install node
	nvm install 20
	nvm alias default 20

	#install zplug
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

	# Install Cursor configuration
	echo "Installing Cursor configuration..."
	mkdir -p ~/Library/Application\ Support/Cursor/User/
	cp init/cursor/settings.json ~/Library/Application\ Support/Cursor/User/
	cp init/cursor/keybindings.json ~/Library/Application\ Support/Cursor/User/

	# Install Cursor extensions
	echo "Installing Cursor extensions..."
	while read extension; do
		code --install-extension "$extension"
	done < init/cursor/extensions.txt

	source ~/.zshrc;

	# Run .macos script if on macOS
	if [[ "$OSTYPE" == "darwin"* ]]; then
		echo "Would you like to run the macOS configuration script? This will close some applications and may require a restart. (y/n)"
		read -q && ./.macos
	fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
