#!/bin/bash

# Установочный скрипт Arch Linux GNOME
# Author: Richard Hendricks
# PiedPiper.com.ru
# Цель скрипта - быстрое развертывание системы.

loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста по Установке Arch Linux Gnome'

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo "Укажите размер системного раздела root в Гб"
read -p ":" root_size

echo "Укажите размер раздела swap в Гб"
read -p ":" swap_size


echo '2.4 создание разделов'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +512M;

  echo n;
  echo;
  echo;
  echo;
  echo '+'$root_size'G';

  echo n;
  echo;
  echo;
  echo;
  echo '+'$swap_size'G';

  echo n;
  echo p;
  echo;
  echo;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sda

echo 'Ваша разметка диска'
fdisk -l

echo '2.4.2 Форматирование дисков'
mkfs.ext2  /dev/sda1 -L boot
mkfs.ext4  /dev/sda2 -L root
mkswap /dev/sda3 -L swap
mkfs.ext4  /dev/sda4 -L home

echo '2.4.3 Монтирование дисков'
#Монтируем /
mount /dev/sda2 /mnt

#Создаем директорию boot в mnt 
mkdir /mnt/boot

#Монтируем boot
mount /dev/sda1 /mnt/boot

#Монтируем swap
swapon /dev/sda3

#Создаем директорию home в mnt 
mkdir /mnt/home

#Монтируем /home
mount /dev/sda4 /mnt/home

echo '3.1 Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL piedpiper.com.ru/arch/arch_1_1.sh)"

