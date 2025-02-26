#!/usr/bin/zsh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

fpath=($HOME/.zsh/completions $fpath)

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# history search on up/down keys
bindkey -e
bindkey '^[[5~' history-substring-search-up
bindkey '^[[6~' history-substring-search-down
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory
# setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' menu no
# export CARAPACE_BRIDGES='fish'
# zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

alias ls=eza
alias ll='eza -l'
alias lla='eza -la'
alias grep='grep --color'
# alias ldd='otool -L'
# alias f="find . -name"
alias f="fd -I"
alias callgrind="valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes " #--dsymutil=yes
alias dk=docker
alias dkc=docker compose
# alias time="time -p"
# alias pbcopy='xclip -selection clipboard'
# alias pbpaste='xclip -selection clipboard -o'
# alias open='xdg-open'
alias tf=terraform
alias kc=kubecolor
# complete --command kc --wraps kubectl
# alias tilt="tilt --context kind-clk-k8s"
alias ipy=ipython3
alias code=code-insiders
alias ts=tree-sitter
alias less=bat
alias rb="~/src/vates/xcp-ng-build-env/run.py --rm"

export XDG_CONFIG_HOME="$HOME/.config"
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

export EDITOR='hx'
export LESS=' -RMX '
export BAT_STYLE=plain
export BAT_THEME=TwoDark

# to force output colors in tree
export EZA_COLORS="ur=0:uw=0:ux=0:ue=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:uu=0:da=90"
export LS_COLORS="$(vivid generate tokyonight-moon)"

# configuration for helix from src dir
if [ -d $HOME/src/helix ]; then
   export HELIX_RUNTIME=$HOME/src/helix/runtime
   export PATH=$HOME/src/helix/target/release:$PATH
fi

if [ -f ~/.secrets.sh ]; then
   source ~/.secrets.sh
fi

# Shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
