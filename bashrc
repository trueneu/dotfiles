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
