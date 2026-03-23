# Runs each time the codespace starts (after 30min idle timeout, manual stop, or rebuild).
# WARNING: Keep this lightweight — anything slow here delays every startup.
echo '>>> bootstrap.sh - startup hook (runs each time the codespace starts)'
date >> /tmp/setup.txt
echo 'Running bootstrap.sh - startup hook' >> /tmp/setup.txt
