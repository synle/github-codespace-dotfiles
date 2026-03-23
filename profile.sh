# Codespace-specific shell profile
# Add custom aliases and functions here that are only needed in Codespaces
# (as opposed to the shared configs from synle/bashrc)

alias apply='vim a.patch; git apply a.patch; rm a.patch; git add -u; git commit'
