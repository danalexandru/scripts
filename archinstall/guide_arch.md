# Guide for installing Arch linux

> **NOTE**: I am writting this guide since the instalation guide for Arch Linux does not seem to be detailed enough. I would like to have all the commands required listed and specified.

## Make sure the time and timezone is set correctly
You can check your timezone with the command:
```sh
timedatectl status
```

If the timezone is not set correctly, you can use the following command to list all timezones (and search for yours)
```sh
timedatectl list-timezones
```

```sh
timedatectl set-timezone <zone>/<subzone>
```

in my case
```sh
timedatectl set-timezone Europe/Bucharest
```

After that, run the following command in order to enable network time sync:
```sh
timedatectl set-ntp true
```

## Set an internet connection (using wifi)
I do not have an ethernet cable. All my internet is done through wifi, therefore the commands regarding `iwd` are esential.

First, type `iwctl`. After that, type the following command in order to find out the name of your wireless device:
```sh
device list
```

After you have found out the device name, use the following command to scan your local area:
```sh
station <device> scan
```

Next, in order to list the wifi network found:
```sh
station <device> get-networks
```

Lastly:
```sh
station <device> connect "<wifi-name>"
```
> **NOTE**: if your wifi is hidden, run the following command instead:
> ```sh
> station <device> connect-hidden "<wifi-name>"
> ```

## Setting up the disk (non-UEFI)
> **NOTE**: I do not have a laptop that supports UEFI, so I will only detail the commands for legacy bios. Also, despite the wiki recommending `fdisk`, I have found `cfdisk` to be easier to use.

Before you partition the disk, use `lsblk` in order to see all your drives and partitions. 

> **NOTE**: I do not a layout that is "typical": I have 2 drives, the first one is and hdd, the second one an ssd. Therefore, for the rest of this guide I will continue with the assumption that the ssh will be used as the `root` (and the one that needs to be bootable), while the hdd will be the `/home`.

Run `cfdisk` and select the **dos** label type. The process should be rather intuitive. Make sure to select the partition that will be `root` as **Bootable**. At the end type the work **yes** in order to write the partition table to the disk.
![cfdisk - label type](./pics/cfdisk-label-type.png)
![cfdisk - partition 1](./pics/cfdisk-partition-1.png)
![cfdisk - partition 2a](./pics/cfdisk-partition-2a.png)
![cfdisk - partition 2b](./pics/cfdisk-partition-2b.png)
![cfdisk - partition 2c](./pics/cfdisk-partition-2c.png)

Once the partition table was written to the disk, format it:
- for `root` (I still prefer **ext4**):
  ```sh
  mkfs.ext4 /dev/sdb1
  ```

- for `swap` (in case you want a swap partition):
  ```sh
  mkswap /dev/sdb2
  swapon /dev/sdb2
  ```
## Mounting the 2 disks
- for `root`:

  ```sh
  mount /dev/sdb1 /mnt
  ```

- for `home`:

  ```sh
  mount /dev/sda1 /home
  ```

After you're done, you will be able to see these changes at the following location:
```sh
/etc/fstab
```

## Instalation
Before installing the operating system, update your mirror list. The location of the `mirrorlist` file is:
```sh
/etc/pacman.d/mirrorlist
```

After that run the following command to install the base install + important packages:
```sh
pacstrap -K /mnt base base-devel linux linux-headers linux-lts linux-lst-headers linux-firmware iwd vim NetworkManager nwtui
```

<!-- > **NOTE**: if you install Artix linux instead of Arch linux, use the following command instead: -->
<!-- > ```sh -->
<!-- >  basestrap /mnt base base-devel runit elogind-runit linux linux-headers linux-lts linux-lst-headers linux-firmware iwd vim --> 
<!-- > ``` -->

After the instalation, you can enter your system as `root` with the following command:
```sh
arch-chroot /mnt
```

## Post instalation
Now, make sure again you have an internet connection. If you do not, try using the `nmtui` package. If this does not work, redo the steps for `iwd`.

After you have internet connection, you can install packages you deem useful. I have a list of them at the following location:
```sh
/home/aldan/.config/scripts/archinstall/package_list.txt
```

You can install these packages with the command:
```sh
pacman -S --noconfirm - < package_list.txt
```

also, the list of all the aur packages I require are at:
```sh
/home/aldan/.config/scripts/archinstall/package_aur_list.txt
```

Another important step is updating your locale: `/etc/locale.gen`. Uncomment all the lines required, and then run the following command:
```sh
locale-gen
```
## Setting a root password

```sh
passwd
```

## Creating a new user
```sh
# useradd -m -g users -G wheel aldan
useradd -m aldan
passwd aldan

usermod -aG wheel,audio,video,optical,storage aldan
```

```sh
EDITOR=vim visudo
```

uncomment the line
```sh
WHEEL ALL=(ALL) ALL
```

## Setting up grub
Grub was one of the packages installed previous, so you do not need to install anything else. What you need to do now is run the following command:
```sh
grub-install --target=i386-pc --recheck /dev/sdb
```

> **NOTE**: Make sure that the `/boot/grub/locale` exists. If not, create it.

> **NOTE**: You may be able to skip this step:
> ```sh
> cp /usr/share/locale/en\@1uot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
> ```

Generating the grub configuration file:
```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

After you have installed and configured grub, you should be able to reboot into arch linux without the bootable usb.Therefore:
```sh
# Exit arch-chroot
exit

# Unmount all devices

umount -a
```

## Post Install tweaks

### Swap file
Become root, then go to the `/root` folder.
```sh
dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress

chmod 600 /swapfile
mkswap /swapfile

# Add the following line to /etc/fstab
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

# Mount swap
mount -a

# Start swap
swapon -a
```

> **NOTE**: make sure that timedatectl is still set correctly

### Set hostname
```sh
hostnamectl set-hostname arch-gl552vw

# edit the hostfile
vim /etc/hosts
```

And write
```sh
# Standard host addresses
127.0.0.1  localhost
::1        localhost ip6-localhost ip6-loopback
ff02::1    ip6-allnodes
ff02::2    ip6-allrouters
# This host address
127.0.1.1  arch-gl552vw
```

### Install the microcode for your cpu
```sh
pacman -S intel-ucode
```

## Relevant links

### Wikis
| Wiki | Link |
|---|---|
| Arch Wiki | https://wiki.archlinux.org/title/installation_guide |
<!-- | Artix Wiki | https://wiki.artixlinux.org/Main/Installation | -->

### Youtubers
| Youtuber | Youtube Link |
|---|---|
| Learn Linux TV | [Arch Linux: Full Installation Guide - A complete tutorial/walkthrough in one video!](https://www.youtube.com/watch?v=DPLnBPM4DhI&t=870s) |
| Distrotube | [Arch Linux Installation Guide (2019)](https://www.youtube.com/watch?v=HpskN_jKyhc&t=2489s) |

