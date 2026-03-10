echo '>>> install.sh'
date >> /tmp/setup.txt
echo 'Running install.sh' >> /tmp/setup.txt

BASE_URL="https://raw.githubusercontent.com/synle/bashrc/master"

curl -s "$BASE_URL/.build/gitconfig" > "$HOME/.gitconfig"
curl -s "$BASE_URL/.build/vimrc"     > "$HOME/.vimrc"
curl -s "$BASE_URL/.build/inputrc"   > "$HOME/.inputrc"
curl -s "$BASE_URL/software/bootstrap/profile-core.sh" > "$HOME/.bash_syle"

# install fzf
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all --no-bash --no-zsh --no-fish
fi

grep -qF '.bash_syle' "$HOME/.bashrc" 2>/dev/null || echo '[ -f "$HOME/.bash_syle" ] && source "$HOME/.bash_syle"' >> "$HOME/.bashrc"
