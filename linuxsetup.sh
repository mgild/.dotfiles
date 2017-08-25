if ! which brew &> /dev/null; then
    # unbiquitous non-root package manager for linux distros
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
fi

if [[ ! -a "/home/${USER}/python-dev/include/python2.7/Python.h" ]]; then
    wget "https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz" -O ~/python-dev.tgz
    tar -zxvf ~/python-dev.tgz -C ~/
    cd ~/Python-2.7.13/
    ./configure --enable-shared --enable-unicode --prefix=/home/${USER}/python-dev
    make && make install
    rm ~/Python-2.7.13/
fi


