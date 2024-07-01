#!/bin/bash

echo "Whoami: $USER"

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

sudo apt update
sudo apt install build-essential exa -y

sudo bash "$PWD"/install_fish.sh
fish_directory=$(which fish)
echo $fish_directory | sudo tee -a /etc/shells
sudo chsh -s $fish_directory
sudo sed -i "\$s/.*/$USER:x:1000:1000::\/home\/$USER:\/usr\/bin\/fish/" /etc/passwd

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

# # Install packages
# packages=(
# 	fd
# 	ripgrep
#   neovim
# 	lazygit
#   jandedobbeleer/oh-my-posh/oh-my-posh
#   fzf
#   zoxide
#   tmux
#   luarocks
#   git-delta
# )
#
# for package in "${packages[@]}"; do
# 	echo "Installing $package..."
# 	brew install "$package"
# done

# Install node if devcontianer not installed node
if ! command -v node -v &> /dev/null
then
  echo "Installing node & npm..."
  brew install node
fi

# TMUX_PLUGIN_MANAGER_PATH="$HOME"/.tmux/plugins
# mkdir -p $TMUX_PLUGIN_MANAGER_PATH
# git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_MANAGER_PATH"/tpm
#
# ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
# ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
# ln -sf "$PWD/lazygit" "$XDG_CONFIG_HOME"/lazygit
# cp -r "$PWD/fish" "$XDG_CONFIG_HOME"
# ln -r "$PWD/ohmyposh" "$XDG_CONFIG_HOME"
#
# # Install aicommit
# npm install -g @negoziator/ai-commit
# aicommit config set auto-confirm=true
# aicommit config set type=conventional
#
# echo "All packages from the setup script have been installed."
# echo "Next steps: Remote to container, setup OPENAI key and CODEIUM key"
# echo " - echo 'export OPENAI_API_KEY=\"sk-...\"' >>  ~/.config/fish/config.sh"
# echo " - echo '{\"api_key\": \"key.....\"}' >> ~/.cache/nvim/codeium/config.json"
# exit 0
