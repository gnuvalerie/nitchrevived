#!/bin/sh
set -e

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ] || [ -d "/data/data/com.termux" ]; then
    echo "Installer doesn't support Termux. Exiting."
    exit 1
fi

install_packages() {
    pkgs="$*"
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --needed --noconfirm $pkgs
    elif command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y $pkgs
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y $pkgs
    elif command -v zypper >/dev/null 2>&1; then
        sudo zypper install -y $pkgs
    else
        echo "Unsupported package manager. Install $pkgs manually."
        exit 1
    fi
}

for cmd in git nim nimble; do
    if ! command -v $cmd >/dev/null 2>&1; then
        echo "$cmd not found, installing..."
        case $cmd in
            git) install_packages git ;;
            nim) install_packages nim ;;
            nimble) install_packages nimble ;;
        esac
    fi
done

git clone https://git.teto.party/pkgs/nitchrevived
cd nitchrevived

if command -v pacman >/dev/null 2>&1; then
    if [ -f PKGBUILD ]; then
        makepkg -si --noconfirm
    else
        cd src
        nimble build -y
        sudo install -Dm755 nitchrevived /usr/local/bin/nitchrevived
        sudo install -Dm644 LICENSE /usr/local/share/licenses/nitchrevived/LICENSE
        cd ..
    fi
else
    cd src
    nimble build -y
    sudo install -Dm755 nitchrevived /usr/local/bin/nitchrevived
    sudo install -Dm644 LICENSE /usr/local/share/licenses/nitchrevived/LICENSE
    cd ..
fi

echo "nitchrevived installation complete."

#cleanup
cd ..
rm -rf nitchrevived
