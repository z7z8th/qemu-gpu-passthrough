#!/bin/bash

rm -rf /var/lib/libvirt/qemu/domain--1-ubuntu22.04/
mkdir -p /var/lib/libvirt/qemu/domain--1-ubuntu22.04/
mkdir -p /run/libvirt/qemu/channel/-1-ubuntu22.04/

LC_ALL=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
HOME=/var/lib/libvirt/qemu/domain--1-ubuntu22.04 \
XDG_DATA_HOME=/var/lib/libvirt/qemu/domain--1-ubuntu22.04/.local/share \
XDG_CACHE_HOME=/var/lib/libvirt/qemu/domain--1-ubuntu22.04/.cache \
XDG_CONFIG_HOME=/var/lib/libvirt/qemu/domain--1-ubuntu22.04/.config \
/usr/bin/qemu-system-x86_64 \
    -v \
    -name guest=ubuntu22.04,debug-threads=on \
    -S \
    -blockdev '{"driver":"file","filename":"/usr/share/OVMF/OVMF_CODE_4M.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}' \
    -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}' \
    -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/ubuntu22.04_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}' \
    -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}' \
    -machine pc-q35-5.2,usb=off,vmport=off,dump-guest-core=off,memory-backend=pc.ram,pflash0=libvirt-pflash0-format,pflash1=libvirt-pflash1-format,hpet=off,acpi=on \
    -accel kvm \
    -cpu EPYC-Milan,x2apic=on,tsc-deadline=on,hypervisor=on,tsc-adjust=on,avx512f=on,avx512dq=on,avx512ifma=on,avx512cd=on,avx512bw=on,avx512vl=on,avx512vbmi=on,avx512vbmi2=on,gfni=on,vaes=on,vpclmulqdq=on,avx512vnni=on,avx512bitalg=on,avx512-vpopcntdq=on,spec-ctrl=on,stibp=on,flush-l1d=on,arch-capabilities=on,ssbd=on,avx512-bf16=on,cmp-legacy=on,stibp-always-on=on,virt-ssbd=on,amd-psfd=on,lbrv=off,tsc-scale=off,vmcb-clean=off,pause-filter=off,pfthreshold=off,v-vmsave-vmload=off,vgif=off,vnmi=off,no-nested-data-bp=on,lfence-always-serializing=on,null-sel-clr-base=on,auto-ibrs=on,rdctl-no=on,skip-l1dfl-vmentry=on,mds-no=on,pschange-mc-no=on,pcid=off,svm=off,topoext=on,npt=off,nrip-save=off,svme-addr-chk=off \
    -m size=8388608k \
    -object '{"qom-type":"memory-backend-memfd","id":"pc.ram","share":true,"x-use-canonical-path-for-ramblock-id":false,"size":8589934592}' \
    -overcommit mem-lock=off \
    -smp 8,sockets=8,cores=1,threads=1 \
    -uuid f4d628b3-8791-4c72-8e07-fff10b1697f1 \
    -no-user-config \
    -nodefaults \
    -rtc base=utc,driftfix=slew \
    -global kvm-pit.lost_tick_policy=delay \
    -no-shutdown \
    -global ICH9-LPC.disable_s3=1 \
    -global ICH9-LPC.disable_s4=1 \
    -boot menu=on,strict=on \
    -device '{"driver":"pcie-root-port","port":16,"chassis":1,"id":"pci.1","bus":"pcie.0","multifunction":true,"addr":"0x2"}' \
    -device '{"driver":"pcie-root-port","port":17,"chassis":2,"id":"pci.2","bus":"pcie.0","addr":"0x2.0x1"}' \
    -device '{"driver":"pcie-root-port","port":18,"chassis":3,"id":"pci.3","bus":"pcie.0","addr":"0x2.0x2"}' \
    -device '{"driver":"pcie-root-port","port":19,"chassis":4,"id":"pci.4","bus":"pcie.0","addr":"0x2.0x3"}' \
    -device '{"driver":"pcie-root-port","port":20,"chassis":5,"id":"pci.5","bus":"pcie.0","addr":"0x2.0x4"}' \
    -device '{"driver":"pcie-root-port","port":21,"chassis":6,"id":"pci.6","bus":"pcie.0","addr":"0x2.0x5"}' \
    -device '{"driver":"pcie-root-port","port":22,"chassis":7,"id":"pci.7","bus":"pcie.0","addr":"0x2.0x6"}' \
    -device '{"driver":"pcie-root-port","port":23,"chassis":8,"id":"pci.8","bus":"pcie.0","addr":"0x2.0x7"}' \
    -device '{"driver":"pcie-root-port","port":24,"chassis":9,"id":"pci.9","bus":"pcie.0","addr":"0x3"}' \
    -device '{"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.7","addr":"0x0"}' \
    -device '{"driver":"virtio-scsi-pci","id":"scsi0","bus":"pci.8","addr":"0x0"}' \
    -device '{"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.2","addr":"0x0"}' \
    -device '{"driver":"ide-cd","bus":"ide.0","id":"sata0-0-0"}' \
    -blockdev '{"driver":"file","filename":"/opt/VM/ubuntu22.04.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
    -blockdev '{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}' \
    -device '{"driver":"virtio-blk-pci","bus":"pci.3","addr":"0x0","drive":"libvirt-1-format","id":"virtio-disk0","bootindex":1}' \
    -device '{"driver":"usb-tablet","id":"input0","bus":"usb.0","port":"1"}' \
    -audiodev '{"id":"audio1","driver":"spice"}' \
    -spice port=0,disable-ticketing=on,image-compression=off,seamless-migration=on \
    -device '{"driver":"ich9-intel-hda","id":"sound0","bus":"pcie.0","addr":"0x1b"}' \
    -device '{"driver":"hda-duplex","id":"sound0-codec0","bus":"sound0.0","cad":0,"audiodev":"audio1"}' \
    -global ICH9-LPC.noreboot=off \
    -watchdog-action reset \
    -device '{"driver":"vfio-pci","host":"0000:18:00.0","id":"hostdev0","bus":"pci.9","addr":"0x0","rombar":1,"romfile":"/usr/share/kvm/amdgpu-ryzen7000.rom"}' \
    -device '{"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.4","addr":"0x0"}' \
    -object '{"qom-type":"rng-random","id":"objrng0","filename":"/dev/urandom"}' \
    -device '{"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","bus":"pci.5","addr":"0x0"}' \
    -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny \
    -msg timestamp=on



