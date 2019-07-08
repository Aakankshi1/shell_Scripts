#!/bin/bash

RED='\033[0;31m'
GREEN='tput setaf 2'
NC='\033[0m'

ports_validation() {

echo -e "\n######################\nChecking If ports still exists...!!!\n##########################\n"

port=($(netstat -ntlp | cut -d: -f4 | awk -F'[^0-9]*' 'NF>1{print $1}' | sed '/^$/d'))
#echo ${port[2]}

for i in ${port[*]}
do
case $i in
     8080) echo "Port 80 Exists...!!"
           ;;
     8001) echo "Port 8081 is ready to be used..!!"
           ;;
     6443) echo "Port 6443 is ready to be used..!!"
           ;;
     *)
esac
done
}

##########################################################################
########################################################################
#####################################################################

cpu_validation(){

cpu_core=$(cat /proc/cpuinfo/| grep cores|awk '{print $4}')

if [ $cpu_core >= 1 ]; then
  printf "\n ${GREEN}Pre-Check passed for CPU${NC}\n"
lse
  printf "\n ${RED} CPU Cores are Insufficient. It should be atleast 3 ${NC}\n"
fi

RAM=$(cat /proc/meminfo  | grep -i memtotal | awk '{print $2/(1024^2)}')

if [ $RAM >= 16 ]; then
  printf "\n ${GREEN}CPU Cores are less than 4${NC}\n"
lse
  printf "\n ${RED} CPU Cores are Insufficient. It should be atleast 3 ${NC}\n"

fi

}

##########################################################################
########################################################################
#####################################################################

firewall_validation() { }

mem_validation() { }

disk_space_validation() { }


#Creating Dynamic pkg file to be installed

echo "pkg_list:" > /root/Client_Inter/main.yml

for i in `cat list.cfg`
do
 echo -e " - $i" >> /root/Client_Inter/main.yml
done



##########################################################################
########################################################################
#####################################################################

package_validation() {
echo -e "\n######################\nChecking If Packages are installed Successfully...!!!\n##########################\n"

ansible --version | head -n1 > /dev/null
if [ $(echo $?) == "0" ]; then
 echo " Ansible is Installed "
fi

git --version  >/dev/null
if [ $(echo $?) -eq 0 ]; then
 echo " GIT is Installed "
fi

dock=$(docker -v) 2>&1 >/dev/null
if [ $(echo $?) = 0 ]; then
 echo " Docker is Installed "
fi

#if[ -z $(echo $?) ]

}
