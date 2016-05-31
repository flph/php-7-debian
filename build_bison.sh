
#!/bin/bash

sudo apt-get remove bison
pkg="bison-3.0.4.tar.gz"

mkdir bison
cd bison

# Get archive
wget --progress=dot --output-document=./${pkg} http://ftp.gnu.org/gnu/bison/${pkg}
bash: q: comando não encontrado
tar -xf ${pkg}

echo "Configuring Bison."
cd bison-3.0.4
./configure

echo "Compiling Bison."
make install

