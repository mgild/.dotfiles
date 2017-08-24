if ! which brew &> /dev/null; then
    # unbiquitous non-root package manager for linux distros
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
fi
