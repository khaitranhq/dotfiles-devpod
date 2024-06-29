if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -d /home/linuxbrew/.linuxbrew # Linux
	set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
else if test -d /opt/homebrew # MacOS
	set -gx HOMEBREW_PREFIX "/opt/homebrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
end
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin";
! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

alias exit='exit 0'
alias v="nvim"
alias fd='fdfind'
alias l='exa -lah --icons'
alias lg='lazygit'
alias randompass="cat /dev/random | tr -dc '[:alnum:]' | head -c 40 | xsel -b"
# alias t='tmux'
# alias y='yazi'
alias his='history | fzf'

# Disable Fish Greeting
set -g fish_greeting

oh-my-posh init fish --config "$HOME/.config/ohmyposh/jandedobbeleer.omp.json" | source
zoxide init fish | source
#
# function fish_user_key_bindings
#   # ctrl-del
#   bind \e\[3\;5~ kill-word
# end
#
# function __check_nvm --on-variable PWD --description 'Do nvm stuff'
#   if test -f .nvmrc
#     set node_version_target (cat .nvmrc)
#     set nvm_node_versions (nvm list)
#
#     if string match -q "*$node_version_target*" $nvm_node_versions
#       nvm use $node_version_target --silent
#     else 
#       nvm install $node_version_target --silent
#     end
#   end
# end
# __check_nvm
