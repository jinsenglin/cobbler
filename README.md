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
