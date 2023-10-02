
* vendor-reset (not necessary for kernel >= 6.5)

```sh
apt install dkms
git clone https://github.com/gnif/vendor-reset
cd vendor-reset
dkms install .
```

* vm guest tools

```sh
apt install spice-vdagent qemu-guest-agent
systemctl status spice-vdagent
systemctl restart spice-vdagent
reboot
```
