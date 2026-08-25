# ==============================================================================
# 🌊 PROJECT: FISH SHELL SYSTEM ENVIRONMENT CONFIGURATION
# ⚙️ MACHINE: SKÝMOON @ BABY ARCH ENVIRONMENT
# ==============================================================================

# ------------------------------------------------------------------------------
# 🗺️ SECTION 1: SYSTEM PATHS & BINARY PATHWAYS
# ------------------------------------------------------------------------------
fish_add_path ~/.local/bin
set -gx PATH $HOME/.local/bin $PATH

# Pyenv Core Engine Setup
set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
if command -v pyenv &>/dev/null
    pyenv init - | source
end

# ------------------------------------------------------------------------------
# 🔗 SECTION 2: BASH CONFIGURATION BRIDGES & PLUGINS
# ------------------------------------------------------------------------------
# Safely sourcing shared configurations and modern CLI tools

if test -f ~/.typing
    bass source ~/.typing
end

if test -f ~/.aliases
    bass source ~/.aliases
end

# Initialize Zoxide (Smarter cd command)
if command -v zoxide &>/dev/null
    zoxide init fish | source
end

# ------------------------------------------------------------------------------
# 🔐 SECTION 3: DEPLOYMENT INFRASTRUCTURE & SECRETS
# ------------------------------------------------------------------------------
# Load secret local API keys securely (keeps them out of public Git tracking)

if test -f (status dirname)/secrets.fish
    source (status dirname)/secrets.fish
end

# Railway Cloud Deployment Engine Initialization
if test -f "$HOME/.railway/env.fish"
    source "$HOME/.railway/env.fish"
end

# ------------------------------------------------------------------------------
# 📊 SECTION 4: INTERACTIVE TERMINAL VISUALS
# ------------------------------------------------------------------------------
# Launch system hardware stats cleanly upon shell entry

if command -v fastfetch &>/dev/null
	# fastfetch
end

# ==============================================================================
# END OF CONFIGURATION - FILE DEPLOYED CLEANLY
# ==============================================================================


# Added by Antigravity CLI installer
set -gx PATH "/home/skymoon/.local/bin" $PATH

# Starship 
starship init fish | source
