#!/bin/bash
echo "Укажите имя компьютера"
read -p ":" host_name

echo 'Прописываем имя компьютера'
echo $host_name > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo '3.4 Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Обновим текущую локаль системы'
locale-gen

echo 'Указываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

echo 'Вписываем KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo 'Создаем root пароль'
passwd

echo '3.5 Устанавливаем загрузчик'
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda

echo 'Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Ставим программу для Wi-fi'
pacman -S dialog wpa_supplicant --noconfirm 

echo "Укажите имя пользователя"
read -p ":" linuxoid

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash $linuxoid

echo 'Устанавливаем пароль пользователя'
passwd $linuxoid
echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo "Устанавливем Arch Linux на виртуальную машину?"
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit"
elif [[ $vm_setting == 1 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils"
fi

echo 'Ставим иксы и драйвера'
pacman -S $gui_install --noconfirm

echo 'Ставим GNOME и сеть'
pacman -S gnome gnome-extra gnome-tweak-tool networkmanager network-manager-applet ppp --noconfirm

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-dejavu --noconfirm 

echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable gdm NetworkManager

echo 'Ставим wget'
pacman -S wget --noconfirm 

echo 'Делаем exit и reboot. После перезагрузки заходим под пользователем'
echo 'Запустите Терминал'
echo 'Скачайте вторую часть скрипта командой: wget piedpiper.com.ru/arch/arch_2.sh'
echo 'Запустите скрипт командой: sh arch_2.sh'
exit
read -p "Пауза 5 ceк." -t 5
reboot
