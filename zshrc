export ZSH="$HOME/.oh-my-zsh"

#Theme
ZSH_THEME="simple"

# Plugins
# plugins=(kubectl docker)
plugins=(python kubectl kube-ps1)

source $ZSH/oh-my-zsh.sh

### User configuration ###

### https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/python
PYTHON_AUTO_VRUN=true

## kube-ps1 plugin config
KUBE_PS1_SYMBOL_ENABLE=false
KUBE_PS1_HIDE_IF_NOCONTEXT=true
RPROMPT='$(kube_ps1)'

# History
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

# Disable tab menu
setopt noautomenu
setopt nomenucomplete

# Disable auto update to speed up init
DISABLE_AUTO_UPDATE=true

# KREW required
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Export usr bin
export PATH="$HOME/.local/bin:$PATH"

# Aliases
## Python Plugin ##
PYTHON_VENV_NAME=".venv"

## MISC ##
alias ssh='ssh -o StrictHostKeyChecking=no'

## OLLAMA ##
# export OLLAMA_HOST=0.0.0.0:11434

## K8S ##
alias kubectl="kubecolor"
source <(kubectl completion zsh)
compdef kubecolor=kubectl ## autocomplete kubecolors as kubectl
alias k='kubectl'
alias kube='kubectl'
alias kc='k config get-contexts'
alias kns='kubens'
alias kx='kubectx'

alias dev='kx k3d-dev'
alias prod='kx k3d-prod'

#. "$HOME/.local/bin/env"
export PATH="/opt/homebrew/bin:$PATH"