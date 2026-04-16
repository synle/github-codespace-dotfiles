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

- All dotfile source files come from `https://raw.githubusercontent.com/synle/bashrc/HEAD/` — the `BASE_URL` variable (raw file content served directly, no `?raw=1` needed).
- VS Code config goes into the Machine-level path (`~/.vscode-server/data/Machine/`) so it applies in Codespaces.
- When adding new dotfiles or tools, update **both** the Dockerfile and `install.sh`.

## GitHub Raw File URLs

When fetching raw file content from GitHub repos, always use `raw.githubusercontent.com`:

https://raw.githubusercontent.com/{owner}/{repo}/HEAD/{path}

This format works for all use cases (browser fetch with CORS, curl/shell scripts, direct browser links).

Do NOT use:

- `https://github.com/{owner}/{repo}/blob/HEAD/{path}?raw=1` (no CORS headers, breaks browser fetch)
- `https://api.github.com/repos/{owner}/{repo}/contents/{path}` (returns JSON, not raw content)
