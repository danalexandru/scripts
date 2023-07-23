#!/bin/bash

USER=aldan
GRUB_PARTITION=/dev/sdb

install_regular_packages() {
    echo "Install regular arch packages from package_list.txt"
    pacman -S --noconfirm - < package_list.txt
}


install_aur_packages() {
    echo "Install aur packages from package_aur_list.txt"
    paru -S - < package_aur_list.txt
}

setup_user() {
    echo "Setup user"
    # useradd -m -g users -G wheel ${USER}
    useradd -m ${USER}
    passwd ${USER}

    usermod -aG wheel,audio,video,optical,storage ${USER}
}

systemd_enable () {
    echo "Enable all systemd daemons after installing required packages"

    systemctl enable NetworkManager
    systemctl enable bluetooth
    systemctl enable cups.service
    systemctl enable sshd
    systemctl enable cronie
    systemctl enable cronie.service
    systemctl enable systemd-timesyncd
}

configure_grub () {
    echo "Configure grub"
    grub-install --target=i386-pc --recheck ${GRUB_PARTITION}
    grub-mkconfig -o /boot/grub/grub.cfg
}

copy_themes_and_icons() {
    echo "Copy the \"themes\" and \"icons\" folders to /usr/share/"
    cp -r $(pwd)/themes/* /usr/share/themes/.
    cp -r $(pwd)/icons/* /usr/share/icons/.
}

change_shell_to_zsh() {
    echo "Change the default shell from \"bash\" to \"zsh\""
    chsh -s /bin/zsh
    # Also, for reference: https://www.linuxuprising.com/2021/01/how-to-change-default-shell-in-linux.html
}

# Iterate through all flags
for flag in "$@"; do
    case $flag in
        --install-regular-packages)
            install_regular_packages
            ;;
        --install-aur-packages)
            install_aur_packages
            ;;
        --setup-user)
            setup_user
            ;;
        --systemd-enable)
            systemd_enable
            ;;
        --configure-grub)
            configure_grub
            ;;
        --copy-themes-and-icons)
            copy_themes_and_icons
            ;;
        --change-shell)
            change_shell_to_zsh
            ;;
        *)
            echo "Unrecognized flag \"$flag\"."
            return
            ;;
    esac
done

