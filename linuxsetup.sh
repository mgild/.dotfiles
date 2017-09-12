PATH="$PATH:/home/${USER}/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/bin"
if [[ ! -a "/home/${USER}/.linuxbrew/bin/brew" && \
      ! -a "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    # unbiquitous non-root package manager for linux distros
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
fi

if [[ ! -a "/home/${USER}/python-dev/include/python2.7/Python.h" ]]; then
    curl -fsSL "https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz" > /tmp/python-dev.tgz
    tar -zxvf /tmp/python-dev.tgz -C /tmp/
    cd /tmp/Python-2.7.13
    ./configure --enable-shared --enable-unicode --prefix=/home/${USER}/python-dev
    make && make install
    cd "$CWD"
    rm -rf /tmp/Python-2.7.13
fi
