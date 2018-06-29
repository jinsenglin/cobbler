#!/bin/bash

set -e

MAC="08:00:27:C6:BB:00"
PROFILE="CentOS-7-x86_64"

sudo cobbler system add --name=vb --profile=$PROFILE --mac=$MAC --interface=eth0
