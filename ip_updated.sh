#!/usr/bin/env bash

IPLIST=$(cat ip_list.txt)
SSHCONFIGFILE=~/.ssh/config

HOSTNAME=$(hostname)


HOSTRULE=""\
"HOST [host_ip]\n"\
"\tStrictHostKeyChecking no\n"


setup_host_entry() {
    ip=$1

    echo -e "Checking StrictHostKeyChecking set to No for $ip.\n"

    if grep "$ip" "$SSHCONFIGFILE"
    then
        echo -e "Host entry for remote ip ($ip) exists in $SSHCONFIGFILE.\n"
    else
        # set StrictHostKeyChecking rule to No for host
        echo  -e "Writing Host entry to $SSHCONFIGFILE.\n"
        hostrule=$(sed "s/\[host_ip\]/$ip/g" <<< "$HOSTRULE")
        echo -e $hostrule  >> $SSHCONFIGFILE
    fi
}

remove_host_entry() {
    ip=$1

    echo "Removing Host entry from $SSHCONFIGFILE."

    hostrule=$(sed "s/\[host_ip\]/$ip/g" <<< "$HOSTRULE")

    # delete every host for ip up until the first blank line
    sed "/^HOST ${ip}/,/^S/d" $SSHCONFIGFILE >> .configout
    mv .configout $SSHCONFIGFILE

}

for ip in $IPLIST; do
    echo -e "WELCOME \n"

    setup_host_entry $ip

    # run this in local machine to connect to nodes on the remote servers.
    echo -e "Connecting to remote ip ($ip).\n"

    ssh root@$ip 'bash -s' < ./upstart.sh

    # remove Host entries in $SSHCONFIGFILE
    remove_host_entry $ip
done;
