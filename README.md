# AMD Ryzen 7000 iGPU Raphal Qemu Passthrough

## Steps

**Tested with Ryzen 7900X + MSI X670-P Wifi (MSI RTX 2060S Ventus as main display)**

* enable SVM and iGPU in BIOS
* enable SRV-IO (optional?) in UEFI BIOS
* copy files in `debian-amd-host` to your host
* run `update-grub`
* reboot
* import xml to virt-manager or virtsh, you need to create VM disk yourself
* enable qxl
* start vm, test and fix radeon reset bug in vm
* shutdown vm
* disable qxl
* start vm, redirect usb keyboard and mouse to vm
* switch to the physical display that the iGPU connected
* happy test.

## Tips

* use qxl as video device when testing
* use none as video to disable virtual gpu
* OVMF_CODE_4M_amdgpu.ms.fd is a VM bios with AmdGopDriver.ffs

## TODO

* share mouse with vm, auto capture mouse and don't release automatically, currently not work well

## Ref

* https://pve.proxmox.com/wiki/PCI_Passthrough
* https://bbs.archlinux.org/viewtopic.php?id=162768
* https://blabli.blog/post/2023/03/14/nixos-amd-raphael-igpu-screen-issues/
* https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Prerequisites
* https://wiki.gentoo.org/wiki/GPU_passthrough_with_libvirt_qemu_kvm
* https://libvirt.org/formatdomain.html#host-device-assignment
* https://wiki.gentoo.org/wiki/QEMU/Options#Hard_drive
* https://www.bilibili.com/read/cv25423474/
* https://www.bilibili.com/video/BV1Nm4y1x7ZM/
