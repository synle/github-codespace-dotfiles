# Runs once after install.sh during codespace creation.
# WARNING: Keep this lightweight — heavy installs belong in install.sh.
echo '>>> setup.sh - post-install hook (runs once during codespace creation, after install.sh)'
date >> /tmp/setup.txt
echo 'Running setup.sh - post-install hook' >> /tmp/setup.txt
