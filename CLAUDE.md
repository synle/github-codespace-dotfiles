# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

GitHub Codespace dotfiles repo (github.com/synle/github-codespace-dotfiles). Configures development environments automatically when a Codespace is created.

## Architecture

Two setup paths exist — both must be kept in sync:

1. **Devcontainer (primary)**: `.devcontainer/Dockerfile` + `devcontainer.json` — bakes everything into a Docker image for fast startup.
2. **Dotfiles fallback**: `install.sh` — runs at Codespace creation when devcontainer is not used. `setup.sh` and `bootstrap.sh` are lifecycle hooks (currently just logging).

## What gets installed

- **Shell configs**: gitconfig, vimrc, inputrc from `synle/bashrc` repo
- **Shell profiles**: `profile-core.sh` → `~/.bash_syle`, `profile-advanced.sh` → `~/.bash_syle_advanced` (from `synle/bashrc`)
- **Codespace profile**: `profile.sh` → `~/.codespace_profile` — local to this repo, for Codespace-only aliases and functions
- **VS Code**: keybindings (`vs-code-keys-combined`) and settings (`vs-code-config`) into `.vscode-server/data/Machine/`
- **Tools**: fnm + Node 24, bat, git-delta, jq, fzf

## Key conventions

- All dotfile source files come from `https://github.com/synle/bashrc/blob/head/` — the `BASE_URL` variable (each file URL gets `?raw=1` appended).
- VS Code config goes into the Machine-level path (`~/.vscode-server/data/Machine/`) so it applies in Codespaces.
- When adding new dotfiles or tools, update **both** the Dockerfile and `install.sh`.

## GitHub Raw File URLs

When fetching raw file content from GitHub repos, always use the `?raw=1` blob URL format:

https://github.com/{owner}/{repo}/blob/head/{path}?raw=1

Do NOT use:

- `https://api.github.com/repos/{owner}/{repo}/contents/{path}` (GitHub Contents API)
- `https://raw.githubusercontent.com/{owner}/{repo}/{branch}/{path}`
