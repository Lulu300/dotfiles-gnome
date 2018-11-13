#!/bin/bash

function rm_apps {
    # ===> 1 - Remove unused apps
    echo ' '
    echo '===> 1 - Remove unused apps'
    sudo pacman -Rsn brasero empathy hexchat --noconfirm
    echo ' '
    echo 'Done.'
}

function update {
    # ===> 2 - Update apps, system and repository information
    echo ' '
    echo '===> 2 - Update apps, system and repository information'
    sudo pacman -Syyu --noconfirm
    sudo pacman -S yay --noconfirm --needed
    yay -Syu
    echo ' '
    echo 'Done.'
}

function ins_apps {
    # ===> 3 - Install apps
    echo ' '
    echo '===> 3 - Install apps'
    yay -S zsh gnome-tweak-tool chromium chromium-widevine vivaldi visual-studio-code-bin gimp htop tilix yaru-sound-theme yaru-gtk-theme yaru-gnome-shell-theme yaru-icon-theme --noconfirm --needed
    echo ' '
    echo 'Done.'
}

function ins_omz {
    # ===> 4 - Install oh-my-zsh
    echo ' '
    echo '===> 4 - Install oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo ' '
    echo 'Done.'
}

function set_keys {
    # ===> 5 - Set keyboard shortcut (ctrl + alt + T) to tilix
    echo ' '
    echo '===> 5 - Set keyboard shortcut (ctrl + alt + T) to tilix'
    sudo -u lulu dbus-launch gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
    sudo -u lulu dbus-launch gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Terminal"
    sudo -u lulu dbus-launch gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "tilix"
    sudo -u lulu dbus-launch gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Primary><Alt>t"
    echo ' '
    echo 'Done.'
}

function ins_gnome_ext {
    # ===> 6 - Install Gnome Extensions (Dash To Panel)
    echo ' '
    echo '===> 6 - Install Gnome Extensions (Dash To Panel)'
    git clone https://github.com/home-sweet-gnome/dash-to-panel.git
    cd dash-to-panel
    make install
    cd ..
    sudo rm -R dash-to-panel
    gnome-shell --replace
    echo ' '
    echo 'Done.'
}

echo ' '
echo 'Options:'
echo '1 - Remove unused apps'
echo '2 - Update apps, system and repository information'
echo '3 - Install apps'
echo '4 - Install oh-my-zsh'
echo '5 - Set keyboard shortcut (ctrl + alt + T) to tilix'
echo '6 - Install Gnome Extensions (Dash To Panel)'
echo '7 - Remove old dotfiles and copy new ones'
read -p "Write all the options you want. Write '1234567' to do everything. "
echo ' '

for (( i=0; i<${#REPLY}; i++ )); do
    case ${REPLY:$i:1} in
        [1] ) rm_apps;;
        [2] ) update;;
        [3] ) ins_apps;;
        [4] ) ins_omz;;
        [5] ) set_keys;;
        [6] ) ins_gnome_ext;;
        [7] ) cp_dotfiles;;
        [*] ) echo "Invalid option.";;
    esac
done
