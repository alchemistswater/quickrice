#!/bin/sh

# Export the path to this directory for later use in the script
export LINKDOT=$PWD

# Install fonts and programs. Including two WMs, a terminal emulator
# App launcher, screenshot tool, pdf viewer, image viewer, and text editor.
sudo pacman -S go ttf-joypixels ttf-croscore noto-fonts-cjk noto-fonts \
    ttf-hack nextcloud-client ttf-linux-libertine rofi mpv \
    kitty kitty-terminfo neofetch dash vis scrot \
    feh firefox sxhkd dunst zathura-pdf-mupdf libnotify xclip \
    diff-so-fancy \
    xorg-server xorg-xinit xorg-xrdb xorg-xprop herbstluftwm \
    pulseaudio-alsa exa pavucontrol Profile-sync-daemon

read -p "-- For music, use mpd + ncmpcpp instead of cmus? [y/N] " yna
case $yna in
    [Yy]* ) sudo pacman -S mpd ncmpcpp
        patch home/.xinitrc < other/add-mpd.patch
        ;;
    * ) sudo pacman -S cmus;;
esac

# Optionally install some more programs. Including a file manager,
# find, cat, grep, and curl replacements. And a powerful image viewer.
read -p "-- Install extras? (ranger fd bat ripgrep httpie sxiv fzf) [Y/n] " ynb
case $ynb in
    ''|[Yy]* ) sudo pacman -S ranger fd bat ripgrep httpie sxiv fzf
        ;;
    * ) echo "-- Extras Skipped";;
esac

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
git clone https://git.privacytools.io/silentfoof/dotfiles ~/.aurpkgs/dotfiles


# Install them
cd ~/.aurpkgs/yay
makepkg -si

yay -S polybar compton rofi-pass pass-otp \
    ckb-next steam steam-native-runtime greg-git\
    redshift-qt sox imagemagick i3lock canto-curses

cd ~/.aurpkgs/dotfiles
sudo ln -sf ./scripts/glitchlock /usr/local/bin/
sudo ln -sf ./scripts/invidion /usr/local/bin/

# Link all dotfiles into their appropriate locations
cd ~
ln -sf $LINKDOT/home/.* .

cd ~/.config
ln -sf $LINKDOT/config/* .


echo "-- Installation Complete! Restart the computer."
