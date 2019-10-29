#!/bin/sh

# Export the path to this directory for later use in the script
export LINKDOT=$PWD

# Install fonts and programs. Including HerbstluftWM, a terminal emulator
# App launcher, screenshot tool, pdf viewer, image viewer, and text editor.
sudo pacman -S go ttf-joypixels ttf-croscore noto-fonts-cjk noto-fonts \
    ttf-hack nextcloud-client ttf-linux-libertine rofi mpv \
    kitty kitty-terminfo neofetch dash vis scrot \
    feh firefox sxhkd dunst zathura-pdf-mupdf libnotify xclip \
    diff-so-fancy telegram-desktop aerc calcurse \
    xorg-server xorg-xinit xorg-xrdb xorg-xprop herbstluftwm \
    pulseaudio-alsa exa pavucontrol Profile-sync-daemon

sudo pacman -S mpd ncmpcpp
sudo pacman -S ranger fd bat ripgrep httpie sxiv fzf

# Link dash to /bin/sh for performance boost.
# Then link several font config files for better font display.
sudo ln -sfT dash /usr/bin/sh
sudo ln -sf /etc/fonts/conf.avail/75-joypixels.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/

# Misc but important. The last disables mouse acceleration and can be removed.
sudo install -Dm 644 other/freetype2.sh /etc/profile.d/
sudo install -Dm 644 other/local.conf /etc/fonts/
sudo install -Dm 644 other/dashbinsh.hook /usr/share/libalpm/hooks/
sudo install -Dm 644 other/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

# Make some folders. Screenshots will go in the captures folder.
mkdir -p ~/.config ~/.aurpkgs ~/Images/Captures ~/Images/Wallpapers \
    $LINKDOT/config/mpd/playlists ~/Music

# Move provided wallpapers to the wallpapers folder
cp wallpapers/* ~/Images/Wallpapers

# Clone some yay goodness
git clone https://aur.archlinux.org/yay.git ~/.aurpkgs/yay

# Install them
cd ~/.aurpkgs/yay
makepkg -si

yay -S polybar compton rofi-pass pass-otp \
    ckb-next steam steam-native-runtime greg-git\
    redshift-qt sox imagemagick i3lock canto-curses


# Link all dotfiles into their appropriate locations
cd ~
ln -sf $LINKDOT/home/.* /home/$USER/

cd ~/.config
ln -sf $LINKDOT/config/* /home/$USER/.config/

cd /usr/bin
sudo ln -sf $LINKDOT/scripts/* /usr/bin/

sudo systemctl enable ckb-next-daemon
systemctl --user enable psd


echo "-- Installation Complete! Restart the computer."
