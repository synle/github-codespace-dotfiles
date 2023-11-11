echo '>>> install.sh'
date >> /tmp/setup.txt
echo 'Running install.sh' >> /tmp/setup.txt

curl -s https://raw.githubusercontent.com/synle/bashrc/master/.build/gitconfig > "$HOME/.gitconfig"
curl -s https://raw.githubusercontent.com/synle/bashrc/master/.build/vimrc > "$HOME/.vimrc"
