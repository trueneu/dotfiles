export GOPATH=$HOME/gopath
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/.local/bin"
shopt -s histappend
shopt -s cmdhist
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000
export HISTSIZE=3000
export EDITOR=/usr/bin/emacs

[ -f ~/git_tree/dotfiles/fzf/completion.bash ] && source ~/git_tree/dotfiles/fzf/completion.bash

[ -f ~/git_tree/dotfiles/fzf/key-bindings.bash ] && source ~/git_tree/dotfiles/fzf/key-bindings.bash

tm() {
    tmux attach-session -t "$1" || tmux new-session -s "$1"
}

ssh() {
    proc=$(ps -p $(ps -p $$ -o ppid=) -o comm=)
    if [[ "$proc" =~ "tmux" ]]; then
        tmux rename-window "$(echo ${*##* } | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\e[91m\]`parse_git_branch`\[\e[00m\]\$ '
