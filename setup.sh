#!/bin/bash

mkdir -p ~/.config/fish
cp -r ./fish/* ~/.config/fish/

mkdir -p ~/.config/ohmyposh
cp -r ./ohmyposh/* ~/.config/ohmyposh/

mkdir -p ~/.config/nvim
cp -r ./nvim/* ~/.config/nvim/

nvim --headless "+Lazy! sync" +qa

mkdir -p ~/.config/zellij
cp -r ./zellij/* ~/.config/zellij/

mkdir -p ~/.config/yamlfmt
cp -r ./yamlfmt/.* ~/.config/yamlfmt/

mkdir -p ~/.config/yamllint
cp -r ./yamllint/* ~/.config/yamllint/

mkdir -p ~/.config/eza
cp -r ./eza/* ~/.config/eza/

cp git/.gitconfig ~/.gitconfig
mkdir -p ~/.config/git
cp -r ./git/hook ~/.config/git
cp -r ./git/ignore ~/.config/git

cp golangci-lint/.golangci.yaml ~/

mkdir -p ~/.config/lazygit/
cp -r ./lazygit/* ~/.config/lazygit/

mkdir -p ~/.config/opencode
cp -r ./opencode/* ~/.config/opencode/

mkdir -p ~/.config/ripgrep
cp -r ./ripgrep/* ~/.config/ripgrep/
