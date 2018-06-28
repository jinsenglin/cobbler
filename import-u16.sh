#!/bin/bash

set -e

function distro {
    wget http://releases.ubuntu.com/16.04/ubuntu-16.04.4-server-amd64.iso

    sudo mkdir /mnt/iso-u16

    sudo mount -o loop ubuntu-16.04.4-server-amd64.iso  /mnt/iso-u16 # Warning NOT PERMANENTLY !

    sudo cobbler import --arch=x86_64 --path=/mnt/iso-u16 --name=Ubuntu-16
}

function check {
    sudo cobbler distro list
    sudo cobbler distro report --name=Ubuntu-16-x86_64
}

if [ -z $1 ]; then
    distro
    check
else
    $1
fi
