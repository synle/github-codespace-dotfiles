# This is the HEAVY script — runs once during codespace creation.
# All tool installs, package downloads, and config setup go here.
echo '>>> install.sh - main installer (runs once during codespace creation)'
date >> /tmp/setup.txt
echo 'Running install.sh' >> /tmp/setup.txt

BASE_URL="https://raw.githubusercontent.com/synle/bashrc/master"

curl -s "$BASE_URL/.build/gitconfig" > "$HOME/.gitconfig"
curl -s "$BASE_URL/.build/vimrc"     > "$HOME/.vimrc"
curl -s "$BASE_URL/.build/inputrc"   > "$HOME/.inputrc"
curl -s "$BASE_URL/software/bootstrap/profile-core.sh" > "$HOME/.bash_syle"
curl -s "$BASE_URL/software/bootstrap/profile-advanced.sh" > "$HOME/.bash_syle_advanced"

# install vs code keybindings
mkdir -p "$HOME/.vscode-server/data/Machine"
curl -s "$BASE_URL/.build/vs-code-keys-combined" > "$HOME/.vscode-server/data/Machine/keybindings.json"
curl -s "$BASE_URL/.build/vs-code-config" > "$HOME/.vscode-server/data/Machine/settings.json"

# install fnm and node 24
if ! command -v fnm &> /dev/null; then
  curl -fsSL https://fnm.vercel.app/install | bash
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env)"
  fnm install 24
  fnm default 24
fi

# install bat, delta, jq
sudo apt-get update -qq
sudo apt-get install -y -qq bat git-delta jq
# bat is installed as batcat on debian/ubuntu, symlink it
[ -f /usr/bin/batcat ] && sudo ln -sf /usr/bin/batcat /usr/local/bin/bat

# install fzf
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all --no-bash --no-zsh --no-fish
fi

# install codespace-specific profile
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/profile.sh" "$HOME/.codespace_profile"

grep -qF '.bash_syle' "$HOME/.bashrc" 2>/dev/null || echo '[ -f "$HOME/.bash_syle" ] && source "$HOME/.bash_syle"
[ -f "$HOME/.bash_syle_advanced" ] && source "$HOME/.bash_syle_advanced"
[ -f "$HOME/.codespace_profile" ] && source "$HOME/.codespace_profile"' >> "$HOME/.bashrc"
