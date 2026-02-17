function upd --description "Full system update + cleanup (pacman, AUR, flatpak)"

    echo "update official paquets"
    sudo pacman -Syu --noconfirm

    if type -q yay
        echo "updating AUR with yay"
        yay -Sua --noconfirm
        yay -Yc --noconfirm
    else if type -q paru
        echo "updating AUR with paru"
        paru -Sua --noconfirm
        paru -Sc --noconfirm
    end

    echo "Flatpak update"
    if type -q flatpak
        flatpak update -y
        flatpak uninstall --unused -y
    end

    echo "Removing orphans"
    set orphans (pacman -Qtdq)
    if test -n "$orphans"
        sudo pacman -Rns $orphans --noconfirm
    end

    echo "Pacman cache cleanup"
    if type -q yay
        yay -Scc --noconfirm
    else if type -q paru
        paru -Scc --noconfirm
    end

    echo "System has been update and cleanup"
end
