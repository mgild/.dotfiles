if ! which brew &> /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew_install_if_needed() {
    brew ls --versions $1 &> /dev/null || brew install $1;
}

brew_install_if_needed reattach-to-user-namespace
