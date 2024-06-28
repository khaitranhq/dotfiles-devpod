#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/lazygit" "$XDG_CONFIG_HOME"/lazygit
cp -r "$PWD/fish" "$XDG_CONFIG_HOME"
cp -r "$PWD/ohmyposh" "$HOME"/.local/share

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

sudo apt update
sudo apt install build-essential -y

if ! command -v brew -v &> /dev/null
then
    echo "Install brew failed"
    exit 1
fi

packages=(
	fd
	ripgrep
	npm
	lazygit
	kubectl
  neovim
  zoxide
  fish
  # oh-my-posh
)

for package in "${packages[@]}"; do
	echo "Installing $package..."
	brew install "$package"
done

# Change default shell to fish
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "All packages from the setup script have been installed."
