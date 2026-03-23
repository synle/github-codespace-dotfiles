FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install system packages in one layer
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends bat git-delta jq \
    && ln -sf /usr/bin/batcat /usr/local/bin/bat \
    && rm -rf /var/lib/apt/lists/*

# Everything below runs as the default codespace user
USER vscode

# Install fnm + Node 24
ENV FNM_DIR="/home/vscode/.local/share/fnm"
RUN curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell \
    && export PATH="$FNM_DIR:$PATH" \
    && eval "$(fnm env)" \
    && fnm install 24 \
    && fnm default 24

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/vscode/.fzf \
    && /home/vscode/.fzf/install --all --no-bash --no-zsh --no-fish 2>/dev/null; true

# Pull in dotfiles (baked into image so no network hit at startup)
ARG BASE_URL="https://raw.githubusercontent.com/synle/bashrc/master"
RUN curl -fsSL "$BASE_URL/.build/gitconfig" > /home/vscode/.gitconfig \
    && curl -fsSL "$BASE_URL/.build/vimrc" > /home/vscode/.vimrc \
    && curl -fsSL "$BASE_URL/.build/inputrc" > /home/vscode/.inputrc \
    && curl -fsSL "$BASE_URL/software/bootstrap/profile-core.sh" > /home/vscode/.bash_syle \
    && curl -fsSL "$BASE_URL/software/bootstrap/profile-advanced.sh" > /home/vscode/.bash_syle_advanced \
    && mkdir -p /home/vscode/.vscode-server/data/Machine \
    && curl -fsSL "$BASE_URL/.build/vs-code-keys-combined" > /home/vscode/.vscode-server/data/Machine/keybindings.json \
    && curl -fsSL "$BASE_URL/.build/vs-code-config" > /home/vscode/.vscode-server/data/Machine/settings.json

# Codespace-specific profile (local to this repo, not from synle/bashrc)
COPY profile.sh /home/vscode/.codespace_profile
