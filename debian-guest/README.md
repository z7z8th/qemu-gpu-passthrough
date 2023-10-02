# debian fix

* old kernel version like 5.15 does not recognize Raphael GPU, you need to upgrade to new kernel, or add pci id into old kernel and rebuild
* copy files in `debian-guest/` to your guest
* to fix gpu connected display flickring, add `amdgpu.sg_display=0` to kernel commandline
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
