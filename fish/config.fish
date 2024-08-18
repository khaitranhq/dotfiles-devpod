if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias qq='exit 0'
alias v="nvim"
alias fd='fdfind'
alias l='exa -lah --icons'
alias lg='lazygit'
alias randompass="cat /dev/random | tr -dc '[:alnum:]' | head -c 40 | xsel -b"
alias t='tmux'
alias his='history | fzf'

# Disable Fish Greeting
set -g fish_greeting

oh-my-posh init fish --config "$HOME/.config/ohmyposh/jandedobbeleer.omp.json" | source
zoxide init fish | source

function fish_user_key_bindings
  # ctrl-del
  bind \e\[3\;5~ kill-word
end

fzf --fish | source
