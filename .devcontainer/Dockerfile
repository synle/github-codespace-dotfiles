FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install system packages in one layer
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends bat git-delta jq fzf \
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


# Pull in dotfiles (baked into image so no network hit at startup)
ARG BASE_URL="https://raw.githubusercontent.com/synle/bashrc/master"
RUN curl -fsSL "$BASE_URL/.build/gitconfig" > /home/vscode/.gitconfig
RUN curl -fsSL "$BASE_URL/.build/vimrc" > /home/vscode/.vimrc
RUN curl -fsSL "$BASE_URL/.build/inputrc" > /home/vscode/.inputrc
RUN curl -fsSL "$BASE_URL/software/bootstrap/profile-core.sh" >> /home/vscode/.bashrc
RUN curl -fsSL "$BASE_URL/software/bootstrap/profile-advanced.sh" >> /home/vscode/.bashrc

# VS Code config
RUN mkdir -p /home/vscode/.vscode-server/data/Machine
RUN curl -fsSL "$BASE_URL/.build/vs-code-keys-combined" > /home/vscode/.vscode-server/data/Machine/keybindings.json
RUN curl -fsSL "$BASE_URL/.build/vs-code-config" > /home/vscode/.vscode-server/data/Machine/settings.json

# Codespace-specific profile (local to this repo, appended to bashrc)
COPY profile.sh /tmp/profile.sh
RUN cat /tmp/profile.sh >> /home/vscode/.bashrc && rm /tmp/profile.sh
