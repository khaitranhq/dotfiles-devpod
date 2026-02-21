#========================= BASE IMAGE =========================
FROM mcr.microsoft.com/devcontainers/base:2.1.3-debian13 AS base

#========================= FUNDAMENTAL IMAGE =========================
FROM base AS fundamental

# Install fish && common dependencies
RUN echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_Unstable/ /' \
      | sudo tee /etc/apt/sources.list.d/shells:fish:release:4.list && \
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:4/Debian_Unstable/Release.key \
      | gpg --dearmor \
      | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_4.gpg > /dev/null && \
    apt update && \
    apt install python3 file zip unzip yamllint fish -y && \
    sudo chsh -s $(which fish) vscode && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Install ripgrep
ENV RIPGREP_VERSION=15.1.0
RUN wget "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz" -O ./ripgrep.tar.gz && \
    tar -xvf ripgrep.tar.gz && \
    mv ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl/rg /usr/local/bin/rg

# Install neovim
ENV NEOVIM_VERSION=v0.11.6
RUN wget https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-x86_64.tar.gz -O ./nvim.tar.gz && \
    tar -xzf ./nvim.tar.gz && \
    mv nvim-linux-x86_64 /usr/local/share/nvim && \
    ln -sf /usr/local/share/nvim/bin/nvim /usr/local/bin/nvim

# Install lazygit
ENV LAZYGIT_VERSION=0.43.1
RUN wget https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz -O ./lazygit.tar.gz && \
    tar -xzf ./lazygit.tar.gz && \
    mv lazygit /usr/local/bin

# Install git delta
ENV GIT_DELTA_VERSION=0.18.2
RUN wget https://github.com/dandavison/delta/releases/download/${GIT_DELTA_VERSION}/delta-${GIT_DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz -O delta.tar.gz && \
    tar -xzf delta.tar.gz && \
    mv delta-${GIT_DELTA_VERSION}-x86_64-unknown-linux-gnu/delta /usr/local/bin/delta

# Install oh my posh
RUN curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /usr/local/bin

# Install fzf
ENV FZF_VERSION=0.54.3
RUN wget https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz -O ./fzf.tar.gz && \
    tar -xzf ./fzf.tar.gz && \
    mv fzf /usr/local/bin

# Install zoxide
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash -s -- --bin-dir /usr/local/bin

# Install zellij
ENV ZELLIJ_VERSION=v0.43.1
RUN wget https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VERSION}/zellij-no-web-x86_64-unknown-linux-musl.tar.gz -O ./zellij.tar.gz && \
    tar -xzf ./zellij.tar.gz && \
    mv zellij /usr/local/bin/zellij

# Install eza
ENV EZA_VERSION=v0.23.4
RUN wget https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.zip -O ./eza.zip && \
    unzip ./eza.zip && \
    mv eza /usr/local/bin/eza

# Install bat
ENV BAT_VERSION=v0.26.1
RUN wget https://github.com/sharkdp/bat/releases/download/${BAT_VERSION}/bat-${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz -O ./bat.tar.gz && \
    tar -xzf ./bat.tar.gz && \
    mv bat-${BAT_VERSION}-x86_64-unknown-linux-gnu/bat /usr/local/bin/bat

# Install shfmt
ENV SHFMT_VERSION=v3.12.0
RUN wget https://github.com/mvdan/sh/releases/download/${SHFMT_VERSION}/shfmt_${SHFMT_VERSION}_linux_amd64 -O /usr/local/bin/shfmt && \
    chmod +x /usr/local/bin/shfmt

# Install bun
ENV BUN_VERSION=v1.3.5
RUN wget https://github.com/oven-sh/bun/releases/download/bun-${BUN_VERSION}/bun-linux-x64.zip -O ./bun.zip && \
    unzip ./bun.zip && \
    mv bun-linux-x64/bun /usr/local/bin

# Install prettier
RUN bun install -g prettier

# Install yamlfmt
ENV YAMLFMT_VERSION=0.21.0
RUN wget https://github.com/google/yamlfmt/releases/download/v${YAMLFMT_VERSION}/yamlfmt_${YAMLFMT_VERSION}_Linux_x86_64.tar.gz -O ./yamlfmt.tar.gz && \
    tar -xzf ./yamlfmt.tar.gz && \
    mv yamlfmt /usr/local/bin

# Install opencode
ENV OPENCODE_VERSION=v1.2.10
RUN wget https://github.com/anomalyco/opencode/releases/download/${OPENCODE_VERSION}/opencode-linux-x64.tar.gz && \
    tar xvf opencode-linux-x64.tar.gz && \
    mv opencode /usr/local/bin

# Install lazygit
ENV LAZYGIT_VERSION=0.58.0
RUN wget https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_x86_64.tar.gz -O ./lazygit.tar.gz && \
    tar -xzf ./lazygit.tar.gz && \
    mv lazygit /usr/local/bin

# Clean up
RUN rm -rf /tmp/*

#========================= Go =========================
FROM fundamental AS go

# Install Go
ENV GO_VERSION=1.25.5
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O ./go.tar.gz && \
    tar -xzf ./go.tar.gz && \
    mv go /usr/local/go && \
    ln -sf /usr/local/go/bin/go /usr/local/bin/go && \
    ln -sf /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# Install go tools
RUN go install golang.org/x/tools/gopls@v0.21.1 && \
    go install github.com/golangci/golines@v0.15.0 && \
    go install mvdan.cc/gofumpt@v0.9.2 && \
    go install golang.org/x/tools/cmd/goimports@v0.42.0

# Install golangci-lint
ENV GOLANGCI_LINT_VERSION=2.10.1
RUN wget https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz -O ./golangci-lint.tar.gz && \
    tar -xzf ./golangci-lint.tar.gz && \
    mv golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64/golangci-lint /usr/local/bin/golangci-lint

# Clean up
RUN rm -rf /tmp/*
