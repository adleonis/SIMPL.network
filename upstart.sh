#!/usr/bin/env bash

# delegate to upstart.sh
echo -e "Checking if multichain is installed.\n"
if which multichaind
then
    echo -e "Muitichain already installed. Nothing to see here.\n"
else
    echo -e "Installing multichain....\n"
    #once ssh into the remote server, you can install multichain.

    wget https://www.multichain.com/download/multichain-1.0.4.tar.gz -O /tmp/multichain-1.0.4.tar.gz

    cd /tmp

    tar -xvzf multichain-1.0.4.tar.gz

    cd multichain-1.0.4/

    mv multichaind multichain-cli multichain-util /usr/local/bin

    echo -e "Multichain installed successfully\n"
fi

exit

