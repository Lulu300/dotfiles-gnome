#!/bin/bash

function rm_apps {
    # ===> 1 - Remove unused apps
    echo ' '
    echo '===> 1 - Remove unused apps'
    sudo pacman -Rsn brasero empathy evolution hexchat --noconfirm
    echo ' '
    echo 'Done.'
}

function update {
    # ===> 2 - Update apps, system and repository information
    echo ' '
    echo '===> 2 - Update apps, system and repository information'
    sudo pacman -Syyu --noconfirm
    echo ' '
    echo 'Done.'
}

function ins_apps {
    # ===> 3 - Install apps
    echo ' '
    echo '===> 3 - Install apps'
    sudo pacman -S yay --noconfirm
    yay -S zsh gnome-tweak-tool chromium chromium-widevine vivaldi vivaldi-widevine visual-studio-code-bin gimp htop tilix yaru-sound-theme yaru-gtk-theme yaru-gnome-shell-theme yaru-icon-theme --noconfirm
    echo ' '
    echo 'Done.'
}

echo ' '
echo 'Options:'
echo '1 - Remove unused apps'
echo '2 - Update apps, system and repository information'
echo '3 - Install apps'
echo '4 - Install oh-my-zsh'
echo '5 - Remove old dotfiles and copy new ones'
echo '6 - Set keyboard shortcut (ctrl + alt + T) to gnome-terminal'
read -p "Write all the options you want. Write '123456' to do everything. "
echo ' '

for (( i=0; i<${#REPLY}; i++ )); do
    case ${REPLY:$i:1} in
        [1] ) rm_apps;;
        [2] ) update;;
        [3] ) ins_apps;;
        [4] ) ins_omz;;
        [5] ) cp_dotfiles;;
        [6] ) set_keys;;
        [*] ) echo "Invalid option.";;
    esac
done