#!/bin/bash

set -e

function enp0s8 {
    sudo ip addr add 192.168.1.1/24 dev enp0s8

    # Warning NOT PERMANENTLY !
}

function firewalld {
    sudo systemctl stop firewalld.service
    sudo systemctl disable firewalld.service
}

function selinux {
    sudo setenforce 0
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
    sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/' /etc/sysconfig/selinux
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config

    # Recommand manually modify and check selinux settings and status
    #
    # modify files '/etc/selinux/config' and '/etc/sysconfig/selinux' -> must be 'SELINUX=disabled', then reboot to take effect
    #
    # check by `getenforce` -> must be 'Disabled'
}

function cobbler {
    sudo yum install -y epel-release
    sudo yum install -y cobbler cobbler-web dhcp xinetd tftp-server python-ctypes pykickstart fence-agents
}

function check_1 {
    sudo systemctl enable cobblerd.service
    sudo systemctl start cobblerd.service

    sudo systemctl enable httpd.service
    sudo systemctl start httpd.service

    sudo cobbler get-loaders
    sudo cobbler check
}

function setup {
    # 1, 2
    sudo sed -i 's/^manage_dhcp: 0/manage_dhcp: 1/' /etc/cobbler/settings
    sudo sed -i 's/^pxe_just_once: 0/pxe_just_once: 1/' /etc/cobbler/settings
    sudo sed -i 's/^next_server: 127.0.0.1/next_server: 192.168.1.1/' /etc/cobbler/settings
    sudo sed -i 's/^server: 127.0.0.1/server: 192.168.1.1/' /etc/cobbler/settings

    # 3
    sudo sed -i 's/disable                 = yes/disable                 = no/' /etc/xinetd.d/tftp
    sudo systemctl enable xinetd.service
    sudo systemctl start xinetd.service

    # 4
    sudo systemctl enable rsyncd.service
    sudo systemctl start rsyncd.service

    # 5
    sudo yum install -y debmirror
    sudo sed -i 's/@dists="sid";/#@dists="sid";/g' /etc/debmirror.conf
    sudo sed -i 's/@arches="i386";/#@arches="i386";/g' /etc/debmirror.conf

    # 6
    OldPWD=$(sudo grep default_password_crypted /etc/cobbler/settings | awk '{ print$2 }')
    NewPWD=$(openssl passwd -1 -salt 'salt' 'cobbler')
    sudo sed -i "s|$OldPWD|$NewPWD|g" /etc/cobbler/settings

    sudo systemctl restart cobblerd.service

    sleep 1 # wait for cobblerd up
    sudo ip addr add 192.168.1.1/24 dev enp0s8 # workaround
    sudo cobbler sync
}

function check_2 {
    sudo cobbler check
}

function dhcpd {
#    sudo systemctl enable dhcpd.service
#    sudo systemctl start dhcpd.service
    sudo systemctl status dhcpd.service
}

function init6 {
    echo "Now please manually reboot to complete installation."
}

if [ -z $1 ]; then
    enp0s8
    firewalld
    selinux
    cobbler
    check_1
    setup
    check_2
    dhcpd
    init6
else
    $1
fi
