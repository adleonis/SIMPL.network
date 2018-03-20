#!/usr/bin/env python3

import subprocess

##################
#CONFIG PARAMETERS
##################

chain_name = 'SIMPL'        #no wierd characters please
chain_type = 'bitcoin'      #all lowercase please (bitcoin or multichain)
chain_info_file = '~/chain_info.json'

#####
#CODE
#####

#Create the Chain
chain_create = subprocess.run(["multichain-util","create",chain_name],stdout=subprocess.PIPE).stdout.decode('utf-8')
print("Created Chain:",chain_name)
#print('****\n',chain_create,'\n****')

#Save a Backup of the Params.dar file
subprocess.Popen("cp ~/.multichain/{chain_name}/params.dat ~/.multichain/{chain_name}/params.dat.bk".format(chain_name=chain_name), shell=True)
print("Saved Original Parameters")

#Edit the params.dat file to replicate a Bitcoin-style chain
subprocess.Popen("sed -i '13s/multichain/{chain_type}/' ~/.multichain/{chain_name}/params.dat".format(chain_name=chain_name, chain_type=chain_type), shell=True)
print("Set Chain as:",chain_type)

#Start Chain
chain_start = subprocess.run(['multichaind',chain_name,'-daemon'],stdout=subprocess.PIPE).stdout.decode('utf-8')
#print(chain_start)
print("Started Chain:", chain_name)

#Get Chain info
chain_info = subprocess.run(['multichain-cli',chain_name,'getinfo'],stdout=subprocess.PIPE).stdout.decode('utf-8')

#Save info into Json format file
subprocess.Popen([chain_info,'>',chain_info_file],shell=True)

