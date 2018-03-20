#!/usr/bin/env python3

import subprocess

##################
#CONFIG PARAMETERS
##################

chain_name = 'SIMPL'        #no wierd characters please
chain_type = 'bitcoin'      #all lowercase please


#####
#CODE
#####

#Create the Chain
subprocess.Popen("multichain-util create {} > log1.txt".format(chain_name))

#Edit the params.dat file to replictae a Bitcoin-style chain
subprocess.Popen("cat ~/.multichain/{chain_name}/params.dat | sed -e '13s/multichain/{chain_type}/' > ~/.multichain/{chain_name}/params.dat".format(chain_name=chain_name, chain_type=chain_type))
