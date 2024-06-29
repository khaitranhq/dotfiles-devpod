#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

sudo apt update
sudo apt install build-essential -y

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source "$HOME"/.bashrc

if ! command -v brew -v &> /dev/null
then
    echo "Install brew failed"
    exit 1
fi

# Install packages
packages=(
	fd
	ripgrep
  neovim
	npm
	lazygit
  fish
  exa
  fzf
  zoxide
)

for package in "${packages[@]}"; do
	echo "Installing $package..."
	brew install "$package"
done

fish_directory=$(which fish)
echo $fish_directory | sudo tee -a /etc/shells
sudo chsh -s $fish_directory
sudo sed -i '$s/.*/node:x:1000:1000::\/home\/node:\/usr\/bin\/fish/' /etc/passwd


ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/lazygit" "$XDG_CONFIG_HOME"/lazygit
cp -r "$PWD/fish" "$XDG_CONFIG_HOME"
cp -r "$PWD/ohmyposh" "$XDG_CONFIG_HOME"

exit 0
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
