PATH="$PATH:/home/${USER}/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/bin"
if [[ ! -a "/home/${USER}/.linuxbrew/bin/brew" && \
      ! -a "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    # unbiquitous non-root package manager for linux distros
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
fi
