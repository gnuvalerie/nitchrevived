#!/bin/sh
set -e

# Detect if running in Termux environment
if [ "$PREFIX" = "/data/data/com.termux/files/usr" ] || [ -d "/data/data/com.termux" ]; then
    IN_TERMUX=1
else
    IN_TERMUX=0
fi

root_check_ig() {
    if [ $IN_TERMUX -eq 1 ]; then
        # In Termux, no root access needed, no PRIV_CMD
        PRIV_CMD=""
    elif [ "$(id -u)" = "0" ]; then
        PRIV_CMD=""
    elif command -v doas >/dev/null 2>&1; then
        PRIV_CMD="doas"
    elif command -v sudo >/dev/null 2>&1; then
        PRIV_CMD="sudo"
    else
        PRIV_CMD=""
    fi
}

root_check_ig

install_packages() {
    pkgs="$*"
    if [ $IN_TERMUX -eq 1 ] && command -v pkg >/dev/null 2>&1; then
        pkg install -y $pkgs
    elif command -v pacman >/dev/null 2>&1; then
        $PRIV_CMD pacman -S --needed --noconfirm $pkgs
    elif command -v apt >/dev/null 2>&1; then
        $PRIV_CMD apt update
        $PRIV_CMD apt install -y $pkgs
    elif command -v dnf >/dev/null 2>&1; then
        $PRIV_CMD dnf install -y $pkgs
    elif command -v zypper >/dev/null 2>&1; then
        $PRIV_CMD zypper install -y $pkgs
    elif command -v pkg >/dev/null 2>&1; then
        # General pkg command (should be different from Termux's pkg)
        $PRIV_CMD pkg install -y $pkgs
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

if [ $IN_TERMUX -eq 0 ] && command -v pacman >/dev/null 2>&1; then
    if command -v yay >/dev/null 2>&1; then
        yay -S --needed --noconfirm nitchrevived
        exit 0
    elif command -v paru >/dev/null 2>&1; then
        paru -S --needed --noconfirm nitchrevived
        exit 0
    fi
fi

git clone https://git.teto.party/pkgs/nitchrevived
cd nitchrevived

if [ $IN_TERMUX -eq 1 ]; then
    # In Termux, build and install to $PREFIX/bin
    cd src
    nimble build -y
    install -Dm755 nitchrevived $PREFIX/bin/nitchrevived
    install -Dm644 LICENSE $PREFIX/share/licenses/nitchrevived/LICENSE
    cd ..
elif command -v pacman >/dev/null 2>&1; then
    echo "Please use AUR version."
    cd ..
    rm -rf nitchrevived
    exit
else
    cd src
    nimble build -y
    $PRIV_CMD install -Dm755 nitchrevived /usr/local/bin/nitchrevived
    $PRIV_CMD install -Dm644 LICENSE /usr/local/share/licenses/nitchrevived/LICENSE
    cd ..
fi

echo "nitchrevived installation complete."
cd ..
rm -rf nitchrevived
