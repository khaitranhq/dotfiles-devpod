#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim

ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt install build-essential -y
brew -h
# packages=(
# 	fd
# 	ripgrep
# 	npm
# 	lazygit
# 	kubectl
# )
#
# for package in "${packages[@]}"; do
# 	echo "Installing $package..."
# 	apt install "$package" -y
# done
#
# echo "All packages from the setup script have been installed."
