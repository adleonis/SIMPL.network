#!/usr/bin/env bash

sh -c 'echo "set const" >> .nanorc'

sh -c 'echo "set tabsize 4" >> .nanorc'

sh -c 'echo "set tabstospaces" >> .nanorc'

adduser --disabled-password --gecos "" chain_admin

usermod -aG sudo chain_admin

cp .nanorc /home/chain_admin/

mkdir -p /etc/ssh/chain_admin