ARG SOURCE_IMAGE
FROM ${SOURCE_IMAGE}
RUN apt update && apt install build-essential exa python3-pip python3-venv acl -y

# Install fish
WORKDIR /tmp
COPY install_fish.sh .
RUN bash /tmp/install_fish.sh
RUN which fish > fish_directory.txt
RUN cat /tmp/fish_directory.txt | sudo tee -a /etc/shells
RUN chsh -s "$(cat /tmp/fish_directory.txt)"

RUN sed -i 's/sudo	ALL=(ALL:ALL) ALL/sudo ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
RUN cat /etc/sudoers

# Create user
ARG USER
ENV USER=${USER}

RUN useradd -ms /bin/fish "$USER"
RUN usermod -aG sudo "$USER"

RUN if [ -x "$(command -v node)" ]; then \
      setfacl -R -m u:${USER}:rwx /usr/local/share/npm-global; \
      npm install -g @negoziator/ai-commit; \
    fi

USER ${USER}

# Install HomeBrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV BREW_BIN_DIRECTORY=/home/linuxbrew/.linuxbrew/bin

# Install node
RUN if ! [ -x "$(command -v node)" ]; then \
      eval "$(${BREW_BIN_DIRECTORY}/brew shellenv)"; \
      brew install node; \
      npm install -g @negoziator/ai-commit; \
    fi

# Install other packages
RUN echo "fd ripgrep neovim lazygit jandedobbeleer/oh-my-posh/oh-my-posh fzf zoxide tmux luarocks git-delta " > packages.txt
RUN ${BREW_BIN_DIRECTORY}/brew install $(cat packages.txt)

# Setup TPM
ENV HOME=/home/${USER}
ENV TMUX_PLUGIN_MANAGER_PATH=${HOME}/.tmux/plugins
RUN mkdir -p ${TMUX_PLUGIN_MANAGER_PATH}
RUN git clone https://github.com/tmux-plugins/tpm ${TMUX_PLUGIN_MANAGER_PATH}/tpm

# Copy configuration
WORKDIR ${HOME}
COPY .tmux.conf .aicommit ./

ENV XDG_CONFIG_HOME=${HOME}/.config
WORKDIR ${XDG_CONFIG_HOME}
COPY nvim nvim
COPY lazygit lazygit
COPY fish fish
COPY ohmyposh ohmyposh

RUN sudo chown -R ${USER}: ${HOME}
RUN mkdir -p ${HOME}/.local/share
