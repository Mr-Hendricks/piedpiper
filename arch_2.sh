#!/bin/bash
echo 'Установка AUR (aurman)'
sudo pacman -Syy
sudo pacman -S git --noconfirm

# Обновляем систему
sudo pacman -Syu

echo 'Установка программ'
sudo pacman -S chromium ufw gufw veracrypt freemind gimp pidgin screenfetch audacious vlc qt4 transmission-gtk f2fs-tools ntfs-3g p7zip unrar aspell-ru --noconfirm

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

echo 'Установка завершена!'
rm -rf ~/arch_2.sh
