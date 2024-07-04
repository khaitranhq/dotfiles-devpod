ARG SOURCE_IMAGE
FROM ${SOURCE_IMAGE}
RUN apt update && apt install build-essential exa python3-pip python3-venv -y

WORKDIR /tmp

# Install fish
COPY install_fish.sh .
RUN bash /tmp/install_fish.sh
RUN which fish > fish_directory.txt
RUN cat /tmp/fish_directory.txt | sudo tee -a /etc/shells
RUN chsh -s "$(cat /tmp/fish_directory.txt)"

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Create user
ARG USER
ENV USER=${USER}
ENV HOME=/home/${USER}
ENV XDG_CONFIG_HOME=${HOME}/.config

RUN useradd -ms /bin/fish "$USER"
RUN adduser "$USER" sudo

USER ${USER}

# Install HomeBrew and packages
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV BREW_DIRECTORY=/home/linuxbrew/.linuxbrew/bin/brew

RUN echo "fd ripgrep neovim lazygit jandedobbeleer/oh-my-posh/oh-my-posh fzf zoxide tmux luarocks git-delta " > packages.txt
RUN ${BREW_DIRECTORY} install $(cat packages.txt)

RUN if ! command -v node -v &> /dev/null; then \
      brew install node; \
    fi

# Setup TPM
ENV TMUX_PLUGIN_MANAGER_PATH=${HOME}/.tmux/plugins
RUN Ikdir -p $TMUX_PLUGIN_MANAGER_PATH
RUN git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_MANAGER_PATH"/tpm

# Copy confiles
COPY nvim ${XDG_CONFIG_HOME}/nvim
COPY .tmux.conf "$HOME"
COPY lazygit "$XDG_CONFIG_HOME"/lazygit
COPY fish "$XDG_CONFIG_HOME"
COPY ohmyposh "$XDG_CONFIG_HOME"/ohmyposh

# Install aicommit
RUN npm install -g @negoziator/ai-commit
RUN aicommit config set auto-confirm=true
RUN aicommit config set type=conventional
