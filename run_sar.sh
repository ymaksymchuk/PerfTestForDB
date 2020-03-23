#!/usr/bin/env bash
#sudo apt-get install -y sysstat
echo "Please check all txt file into the Simulation#$1 folder TC#$2"
sar \-u 1 > ./Simulation\#$1/TC\#$2/cpu.txt &
CPU=$!;
        sar \-S 1 > ./Simulation\#$1/TC\#$2/swap.txt &
SWAP=$!;
        sar \-r 1 > ./Simulation\#$1/TC\#$2/ram.txt &
RAM=$!;
        sar \-d 1 > ./Simulation\#$1/TC\#$2/disk.txt &
DISK=$!;
        sar \-n IP 1 > ./Simulation\#$1/TC\#$2/net_ip.txt &
IP=$!;
        sar \-n EIP 1 > ./Simulation\#$1/TC\#$2/net_ip_error.txt &
EIP=$!;
        sar \-n TCP 1 > ./Simulation\#$1/TC\#$2/net_tcp.txt &
TCP=$!
wait $TCP $CPU $EIP $RAM $DISK $IP $EIP
