---
layout: post
title: "Restore boot entry for EndeavourOS with BTRFS"
date: 2025-01-06 09:00:00 +0100
categories: systemd-boot
tags: linux endeavouros efi systemd-boot #obs twitch streaming
image:
  path: /assets/img/headers/add-efi-entry-endeavouros.webp
  lqip: data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAICAAAAADc9oAxAAAAs0lEQVQIHQGoAFf/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAdNEuUA/gYE+wIGD+yy/QAAAQAAAAANEwj++//+AAX+9PL5AAAAAwAAAAD8CAT7+/oA/fv++fQAAAAAAwAAAAD//v3w+vz/9f779f4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAQEBAAEBAAAAAAAAfzoiqi0aHrcAAAAASUVORK5CYII=
---

## To restore Linux item to EFI boot list
- switch into root: `sudo su`
- list disks and partitions: `fdisk -l`
- find main list filesystem partition and efi partition

Example output:
```
Disk /dev/nvme0n1: 953,87 GiB, 1024209543168 bytes, 2000409264 sectors
Disk model: ADATA SX8200PNP                         
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 3D6F57AB-908C-49FB-B140-C796B514C295

Device           Start        End    Sectors   Size Type
/dev/nvme0n1p1    4096    2101247    2097152     1G EFI System
/dev/nvme0n1p2 2101248 2000397734 1998296487 952,9G Linux filesystem
```
If your partition is encrypted, then decrypt it and use this entry instead
```
Disk /dev/mapper/luks-53ef346b-aed3-4c80-b101-204a4110cc83: 952,85 GiB, 1023111024128 bytes, 1998263719 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```
- create mountpoint: `mkdir /mnt/arch`
- mount partition which is your Linux filesystem (use /dev/mapper/luks-XYZ for LUKS): `mount -t auto -o subvol=@ /dev/nvme0n1p2 /mnt/arch/`
  <!-- (source: https://forum.endeavouros.com/t/chroot-into-a-btrfs-uefi-system-from-live-media/15986/3) -->

- change root into mounted partition: `arch-chroot /mnt/arch`
- mount EFI partition (use the device with type EFI System): `mount -t auto /dev/nvme0n1p1 /efi/`
- update bootctl to restore 'Linux' item in EFI list: `bootctl update`
- reinstall kernels to add EndeavourOS to the Linux boot items: `reinstall-kernels`

## To manually add an EFI entry
- While chrooted and with the EFI partition mounted: `efibootmgr --create --disk /dev/nvme0n1p1 --loader /EFI/systemd/systemd-bootx64.efi --label 'EndeavourOS' --unicode`
- References:
  - [Arch Linux Forum Topic](https://bbs.archlinux.org/viewtopic.php?id=263608)
  - [Arch Wiki: Unified Extensible Firmware Interface](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface#efibootmgr)
  - [GitHub Gist: efibootmgr script](https://gist.github.com/andreibosco/b4f32090472f00c63c88149f11c2259a)
