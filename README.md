# piedpiper
Arch Linux + GNOME
Перед Вами *Скрипт автоматической установки Arch Linux GNOME* 
ВНИМАНИЕ! Все данные на диске будут удалены. Скрипт подходит для чистой установки. 
Скрипт состоит из двух частей: 
arch_1.sh 
arch_2.sh 
 
Подготовка 
Скачиваем ArchLinux 
Перейдите на страницу Downloads на сайте дистрибутива. Скачайте ISO образ с дистрибутивом (размер файла около 400-500Мб). 
https://www.archlinux.org/download/ 
#Проверяем целостность образа 
1) Открываем папку со скаченных архивом 
2) Жмем, правую кнопку мышки выбираем “Открыть в терминале” 
3) Вбиваем в терминале команду md5sum (+название файла) 
 
Пример: md5sum archlinux-2018.06.01-x86_64.iso 
Контрольная сумма 613b48eb4dcb7e5d881b296db679511d должна совпадать 
 
Актуальную контрольную сумму смотрите на оффициальном сайте https://www.archlinux.org/download/  
 
#Запишем его на флешку 
sudo dd if=X of=/dev/sdY 
Где X - это название ICO файла, Y - буква диска 
 
Пример: sudo dd if=archlinux-2018.06.01-x86_64.iso of=/dev/sdb 
 
Посмотреть какие есть диски командой: 
sudo fdisk -l 
 
В Winfows лучше записывать программой Rufus http://rufus.akeo.ie 

Загрузка Live-системы 
Загрузитесь с созданного на прошлом шаге Live-носителя. Откроется загрузочное меню диска. Выберите пункт «Boot Arch Linux». 
Установка 
Вы попадете в Live-систему ArchLinux. Загрузится виртуальная консоль (терминал), в котором вы будете вводить команды. Во время установки, вы работаете от имени суперпользователя (root). 
Соединение с Интернетом 
#Подключаем проводной интернет 
dhcpcd 
#Или Wi-fi 
wifi-menu 
 
Запускаем первый скрипт: 
wget piedpiper.com.ru/arch/arch_1.sh 
sh arch_1.sh 
Скрипт разобьет диск sda на 4 части: 
boot - загрузочный раздел 
root - системный раздел 
swap - раздел подкачки 
home - домашний раздел 
 
размер root и swap Вас попросят ввести, home - оставшееся место 
Например: У вас диск на 100 Гб. root - указываем 40 Гб, swap - 4 Гб, тогда на home раздел остается примерно 56 Гб. 
 
Происходит установка основных пакетов 
 
Далее будет сообщение: 
Вы перешли в установленную систему. 
 
Установите:  
Имя Компьютера 
Пароль root 
Имя Пользователя и пароль 
 
На вопрос про виртуальную машину отвечаем 0(ноль - нет) 
 
Устанавливаются драйвера и графическая среда 
 
Перезагрузка компьютера 
Выйдите из окружения chroot, выполнив команду: 
exit 
Перезагрузите компьютер, выполнив: 
reboot 
Не забудьте извлечь Live-носитель, чтобы опять случайно не загрузиться в Live-систему. 
Второй этап: установка программ 
После перезагрузки компьютера, вы попадете в свою новую свежеустановленную систему. Перед вами появится рабочий стол GNOME 
 
Подключаем интернет (уже через графический интерфейс) 
Запускаем Терминал 
Скачайте вторую часть скрипта командой:  
wget piedpiper.com.ru/arch/arch_2.sh 
Запустите скрипт командой: sh arch_2.sh 
Этот скрипт установит основные и дополнительные (по желанию) программы  
 
Список программ из arch_2.sh: 
chromium ufw gufw veracrypt freemind gimp pidgin screenfetch audacious vlc qt4 transmission-gtk f2fs-tools ntfs-3g p7zip unrar aspell-ru 
 
Заключение 
ArchLinux это дистрибутив не для новичков. Если вы прошли все этапы и смогли запустить рабочий стол, то это уже большой шаг. Впереди еще много интересного, настройкой ArchLinux можно заниматься бесконечно. 
 
www.PiedPiper.com.ru 
