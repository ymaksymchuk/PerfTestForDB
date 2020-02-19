#!/usr/bin/env bash

set -x

echo "Starting Jmeter Agent"
echo "jdk8u242jre/bin/java -jar ServerAgent/CMDRunner.jar --tool PerfMonAgent"

./jdk8u242jre/bin/java -jar ServerAgent/CMDRunner.jar --tool PerfMonAgent