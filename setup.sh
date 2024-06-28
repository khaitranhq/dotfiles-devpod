#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/lazygit" "$XDG_CONFIG_HOME"/lazygit
cp -r "$PWD/fish" "$XDG_CONFIG_HOME"
cp -r "$PWD/ohmyposh" "$XDG_CONFIG_HOME"

# Install fish
/bin/bash "$PWD"/install_fish.sh

# # Install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc
#
# sudo apt update
# sudo apt install build-essential -y
#
# if ! command -v brew -v &> /dev/null
# then
#     echo "Install brew failed"
#     exit 1
# fi
#
# packages=(
# 	# fd
# 	# ripgrep
# 	# npm
# 	# lazygit
# 	# kubectl
#  #  neovim
#  #  zoxide
#   fish
#   # oh-my-posh
# )
#
# for package in "${packages[@]}"; do
# 	echo "Installing $package..."
# 	brew install "$package"
# done
#
# source "$HOME"/.bashrc
#
# # Change default shell to fish
# fish_directory=$(which fish)
# echo $fish_directory | sudo tee -a /etc/shells
# echo $fish_directory
# sudo chsh -s $fish_directory
#
# echo "All packages from the setup script have been installed."
