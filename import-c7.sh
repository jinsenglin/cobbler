#!/bin/bash

set -e

function distro {
    wget http://archive.kernel.org/centos-vault/7.2.1511/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso

    sudo mkdir /mnt/iso-c7

    sudo mount -o loop CentOS-7-x86_64-Minimal-1511.iso  /mnt/iso-c7 # Warning NOT PERMANENTLY !

    sudo cobbler import --arch=x86_64 --path=/mnt/iso-c7 --name=CentOS-7
}

function check {
    sudo cobbler distro list
    sudo cobbler distro report --name=CentOS-7-x86_64
}

function ks {
    wget https://raw.githubusercontent.com/jinsenglin/distro/master/anaconda-ks.cfg

    sudo mv anaconda-ks.cfg /var/lib/cobbler/kickstarts/CentOS-7.ks

    sudo cobbler profile edit --name=CentOS-7-x86_64 --kickstart=/var/lib/cobbler/kickstarts/CentOS-7.ks
    sudo cobbler sync
}

if [ -z $1 ]; then
    distro
    check
    ks
else
    $1
fi
