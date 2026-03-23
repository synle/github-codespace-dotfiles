# GitHub Codespace Dotfiles

Personal dotfiles for GitHub Codespaces. Automatically sets up a consistent development environment with shell configs, CLI tools, and VS Code settings.

## What's included

### CLI Tools
- **fnm** + **Node 24** — fast Node version manager with Node 24 as default
- **bat** — `cat` with syntax highlighting
- **git-delta** — better git diffs
- **jq** — JSON processor
- **fzf** — fuzzy finder

### Shell Configuration
- Custom bash profile (`profile-core.sh` + `profile-advanced.sh`) from [synle/bashrc](https://github.com/synle/bashrc)
- gitconfig, vimrc, inputrc

### VS Code
- Custom keybindings (`vs-code-keys-combined`)
- Custom settings (`vs-code-config`)

## How it works

There are two setup paths:

### Devcontainer (recommended)
The `.devcontainer/Dockerfile` bakes everything into a Docker image. No install scripts run at startup — the Codespace is ready immediately.

To get the fastest startup, enable **Codespace prebuilds** in your repo settings:
**Settings > Codespaces > Set up prebuild**

### Dotfiles fallback
If a repo doesn't use the devcontainer, GitHub runs scripts from this dotfiles repo at runtime (slower, but works everywhere).

GitHub Codespaces looks for these scripts in order:

| Script | When it runs | Purpose |
|---|---|---|
| `install.sh` | First, during Codespace creation | Installs tools (fnm, bat, fzf, etc.), downloads dotfiles and VS Code configs |
| `setup.sh` | After install, during creation | Post-install hook (currently logging only) |
| `bootstrap.sh` | Each time the Codespace starts | Startup hook (currently logging only) |

## Setup

1. Go to [github.com/settings/codespaces](https://github.com/settings/codespaces)
2. Under **Dotfiles**, select this repo (`synle/github-codespace-dotfiles`)
3. New Codespaces will automatically use these dotfiles

## Config source

All dotfiles are pulled from [synle/bashrc](https://github.com/synle/bashrc) (`master` branch, `.build/` and `software/bootstrap/` directories).

## References

### My Repos
- [synle/github-codespace-dotfiles](https://github.com/synle/github-codespace-dotfiles) — codespace dotfiles
- [synle/bashrc](https://github.com/synle/bashrc) — source dotfiles and configs

### GitHub Docs
- [GitHub Codespaces overview](https://docs.github.com/en/codespaces/overview)
- [Personalizing Codespaces with dotfiles](https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles)
