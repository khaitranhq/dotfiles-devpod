ARG SOURCE_IMAGE=mcr.microsoft.com/devcontainers/base:1-bookworm
FROM ${SOURCE_IMAGE}

# Install fd
ENV FD_VERSION=10.1.0
RUN wget https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd_${FD_VERSION}_amd64.deb -O ./fd.deb
RUN dpkg -i ./fd.deb

# Install ripgrep
ENV RIPGREP_VERSION=14.1.0
RUN wget https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}-1_amd64.deb -O ./ripgrep.deb
RUN dpkg -i ./ripgrep.deb

# Install neovim
ENV NEOVIM_VERSION=0.10.1
RUN wget https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim-linux64.tar.gz -O ./nvim.tar.gz
RUN tar -xzf ./nvim.tar.gz -C /usr/local/ 
RUN mv /usr/local/nvim-linux64 /usr/local/nvim
RUN ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim

# Install lazygit
ENV LAZYGIT_VERSION=0.43.1
RUN wget https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz -O ./lazygit.tar.gz
RUN tar -xzf ./lazygit.tar.gz
RUN mv lazygit /usr/local/bin

# Install oh my posh
RUN curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /usr/local/bin

# Install fzf
ENV FZF_VERSION=0.54.3
RUN wget https://github.com/junegunn/fzf/releases/download/v0.54.3/fzf-0.54.3-linux_amd64.tar.gz -O ./fzf.tar.gz
RUN tar -xzf ./fzf.tar.gz
RUN mv fzf /usr/local/bin

# Install zoxide
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash -s -- --bin-dir /usr/local/bin

# Install git delta
ENV GIT_DELTA_VERSION=0.17.0
RUN wget https://github.com/dandavison/delta/releases/download/${GIT_DELTA_VERSION}/git-delta_${GIT_DELTA_VERSION}_amd64.deb -O delta.deb
RUN dpkg -i delta.deb

ARG USER
ENV USER=${USER}
USER ${USER}

# Setup TPM
ENV TPM_COMMIT=
ENV HOME=/home/${USER}
ENV TMUX_PLUGIN_MANAGER_PATH=${HOME}/.tmux/plugins/tpm
RUN mkdir -p ${TMUX_PLUGIN_MANAGER_PATH}
WORKDIR ${TMUX_PLUGIN_MANAGER_PATH}
RUN wget https://github.com/tmux-plugins/tpm/archive/99469c4a9b1ccf77fade25842dc7bafbc8ce9946.zip -O tpm.zip
RUN unzip tpm.zip
RUN rm -rf tpm.zip

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

# Install tmux && others
RUN sudo apt update && sudo apt install tmux build-essential exa python3-pip python3-venv -y

# Install fish
WORKDIR /tmp/setup
COPY install_fish.sh .
RUN sudo bash /tmp/setup/install_fish.sh
RUN which fish > fish_directory.txt
RUN cat /tmp/setup/fish_directory.txt | sudo tee -a /etc/shells

# Change shell of user
RUN sudo sed -i "s/\/home\/${USER}:\/bin\/bash/\/home\/${USER}:\/bin\/fish/" /etc/passwd
