if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting
    alias ls=eza
    alias ll='eza -lg'
    alias lla='eza -lag'
    alias grep='grep --color'
    alias rg='rg --no-heading'
    # alias ldd='otool -L'
    # alias f="find . -name"
    alias f="fd -I"
    alias callgrind="valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes " #--dsymutil=yes
    if which podman >/dev/null
        alias dk=podman
        alias dkc=podman compose
    else
        alias dk=docker
        alias dkc=docker compose
    end
    # # alias time="time -p"
    if which xdg-open >/dev/null
        alias open='xdg-open'
    end
    if which kitten >/dev/null
        alias pbcopy='kitten clipboard'
        alias pbpaste='kitten clipboard --get-clipboard'
    else if which xclip >/dev/null
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    end
    alias tf=terraform
    alias kc=kubecolor
    # complete --command kc --wraps kubectl
    # alias tilt="tilt --context kind-clk-k8s"
    alias ipy=ipython3
    alias code=code-insiders
    alias ts=tree-sitter
    alias less=bat
    alias rb="~/src/xcp-ng/xcp-ng-build-env/run.py --rm --ulimit nofile=2048"
    alias kb=~/src/xcp-ng/xcp/scripts/koji/koji_build.py
    alias ssh="env TERM=xterm-256color ssh"
    alias activate="source .venv/bin/activate.fish"

    # xcp-ng-dev tool
    if [ -e /home/glehmann/src/xcp-ng/xcp-ng-build-env/.venv ]
        alias xd=/home/glehmann/src/xcp-ng/xcp-ng-build-env/.venv/bin/xcp-ng-dev
        register-python-argcomplete --shell fish /home/glehmann/src/xcp-ng/xcp-ng-build-env/.venv/bin/xcp-ng-dev | source
    end

    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x PATH $HOME/.cargo/bin $PATH
    set -x PATH $HOME/.local/bin $PATH
    set -x PATH $HOME/go/bin $PATH

    set -x N_PREFIX $HOME/n
    set -x PATH $N_PREFIX/bin $PATH

    set -x EDITOR hx
    set -x PAGER /usr/bin/less
    set -x LESS ' -RMX '
    set -x BAT_STYLE plain
    set -x BAT_THEME tokyonight_night

    # more compact nextest output
    export NEXTEST_STATUS_LEVEL=fail
    export NEXTEST_SHOW_PROGRESS=running
    export NEXTEST_FINAL_STATUS_LEVEL=none

    # to force output colors in tree
    set -x EZA_COLORS "ur=0:uw=0:ux=0:ue=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:uu=0:gu=0:da=90"
    set -x LS_COLORS "$(vivid generate tokyonight-moon)"

    # configuration for helix from src dir
    if test -d $HOME/src/helix
        set -x HELIX_RUNTIME $HOME/src/helix/runtime
        set -x PATH $HOME/src/helix/target/release $PATH
    end

    if test -f $HOME/.secrets.sh
        source $HOME/.secrets.sh
    end

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function set_zellij_tab_title --on-event fish_postexec
        if test -n "$ZELLIJ_SESSION_NAME"
            zellij action rename-tab (basename $PWD)
        end
    end
    set_zellij_tab_title

    carapace _carapace | grep -v "'jj'" | source
    starship init fish | source
    zoxide init --cmd cd fish | source
end
