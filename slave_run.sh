#!/usr/bin/env bash
SLAVE_IP=$1
echo "./jmeter/bin/jmeter-server -Djava.rmi.server.hostname=$SLAVE_IP --loglevel=DEBUG"
./jmeter/bin/jmeter-server -Djava.rmi.server.hostname=$SLAVE_IP --loglevel=DEBUG