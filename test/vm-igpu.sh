#!/bin/bash

exec qemu-system-x86_64 \
    -nodefaults \
    -enable-kvm \
    -M q35 \
    -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M_amdgpu.ms.fd \
    -drive if=pflash,format=raw,file=win11_VARS.fd \
    -cpu host,kvm=off,hv_vendor_id=1234567890ab \
    -smp 8,sockets=8,cores=1,threads=1 \
    -m 8G \
    -name "Ubuntu VM" \
    -boot order=d \
    -drive id=disk,file=/opt/VM/win11.qcow2,if=none -device ahci,id=ahci -device ide-hd,drive=disk,bus=ahci.0 \
    -serial stdio \
    -device e1000,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::50000-:22,hostfwd=tcp::50001-:5900,hostname=ubuntu_qemu \
    -display gtk -vga qxl \
    -device vfio-pci,host=18:00.0,x-vga=on,multifunction=on,romfile=/usr/share/kvm/amdgpu-ryzen7000.rom \
    -device vfio-pci,host=18:00.1 \
    -usb \
    -device usb-host,vendorid=0x1532,productid=0x0101,id=mouse \
    -device usb-host,vendorid=0x04f2,productid=0x0833,id=keyboard \
    "$@"

# -nographic -vga none \
# -vga qxl -display gtk \
