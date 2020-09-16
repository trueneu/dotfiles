export GOPATH=$HOME/git_tree/gopath
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
shopt -s histappend
shopt -s cmdhist
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$"\n"}history -a; history -c; history -r"
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups

[ -f ~/git_tree/dotfiles/fzf/completion.bash ] && source ~/git_tree/dotfiles/fzf/completion.bash

[ -f ~/git_tree/dotfiles/fzf/key-bindings.bash ] && source ~/git_tree/dotfiles/fzf/key-bindings.bash

tm() {
    tmux attach-session -t "$1" || tmux new-session -s "$1"
}

ssh() {
    proc=$(ps -p $(ps -p $$ -o ppid=) -o comm=)
    if [[ "$proc" =~ "tmux" ]]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}
