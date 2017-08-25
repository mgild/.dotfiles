if ! which brew &> /dev/null; then
    # unbiquitous non-root package manager for linux distros
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
fi

if ! -d "~/python-dev"; then
    wget "https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz" -O ~/python-dev.tgz
    tar xvf ~/python-dev.tgz
    cd ~/Python-2.7.13/
    ./configure --enable-shared --enable-unicode --prefix=~/python-dev
    make && make install
fi


