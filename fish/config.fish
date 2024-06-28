if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias v="nvim"
alias apt='sudo nala'
alias fd='fdfind'
alias l='exa -lah --icons'
alias ssh='kitten ssh'
alias bat="batcat"
alias tf='terraform'
alias ld='lazydocker'
alias lg='lazygit'
alias randompass="cat /dev/random | tr -dc '[:alnum:]' | head -c 40 | xsel -b"
alias t='tmux'
alias y='yazi'
alias his='history | fzf'
alias dps='devpod ssh'
alias dpu='devpod up'

# Disable Fish Greeting
set -g fish_greeting

export KUBE_EDITOR="nvim"

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/nvim/mason/bin
fish_add_path $HOME/.krew/bin

oh-my-posh init fish --config "$HOME/.local/config/ohmyposh/jandedobbeleer.omp.json" | source
zoxide init fish | source

function fish_user_key_bindings
  # ctrl-del
  bind \e\[3\;5~ kill-word
end

function __check_nvm --on-variable PWD --description 'Do nvm stuff'
  if test -f .nvmrc
    set node_version_target (cat .nvmrc)
    set nvm_node_versions (nvm list)

    if string match -q "*$node_version_target*" $nvm_node_versions
      nvm use $node_version_target --silent
    else 
      nvm install $node_version_target --silent
    end
  end
end
__check_nvm
