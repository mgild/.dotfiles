per_min() {
    hash="$(echo "${PWD}:${@}" | sha256sum | awk '{print $1}')"
    mkdir -p /tmp/tmux_schedule/
    if [[ ! -f "/tmp/tmux_schedule/${hash}" ]]; then;
        eval "$*" > "/tmp/tmux_schedule/${hash}"
    fi
    cat "/tmp/tmux_schedule/${hash}"
}
per_min eval "$*"
