# DON'T FORGET THIS

```
sudo ip addr add 192.168.1.1/24 dev enp0s8
```

# DEFAULT ROOT PASS

cobbler

# ABOUT out DIR

Containing .ks and .log files which are collected from the pxe client machine.

# AFTER REBOOT

```
sudo ip addr add 192.168.1.1/24 dev enp0s8
sudo mount -o loop CentOS-7-x86_64-Minimal-1511.iso  /mnt/iso-c7
sudo mount -o loop ubuntu-16.04.4-server-amd64.iso  /mnt/iso-u16

sudo systemctl restart xinetd
sudo systemctl restart rsyncd
sudo systemctl restart httpd
sudo systemctl restart cobblerd

ip a

sudo cobbler sync
sudo cobbler check
sudo systemctl status dhcpd
```

# ISO LIST

* http://archive.kernel.org/centos-vault/7.2.1511/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
* http://archive.kernel.org/centos-vault/7.3.1611/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso
* http://archive.kernel.org/centos-vault/7.4.1708/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso
* http://ftp.isu.edu.tw/pub/Linux/CentOS/7/isos/x86_64/CentOS-7-x86_64-Minimal-1804.iso (7.5)
* http://releases.ubuntu.com/trusty/ubuntu-14.04.5-server-amd64.iso
* http://releases.ubuntu.com/16.04/ubuntu-16.04.4-server-amd64.iso
* http://releases.ubuntu.com/bionic/ubuntu-18.04-live-server-amd64.iso
