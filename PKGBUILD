pkgname=nitchrevived
pkgver=0.1.7
pkgrel=3
pkgdesc="Incredibly fast system fetch written in nim! Revived"
arch=(x86_64)
url=https://git.teto.party/pkgs/nitchrevived
license=(MIT)
depends=(glibc)
makedepends=(nim openssl-1.1)
source=()
md5sums=()

build() {
    nimble build -y
}

package() {
    install -Dm755 -t "$pkgdir/usr/bin" "$pkgname"
    install -Dm644 -t "$pkgdir/usr/share/licenses/$pkgname" LICENSE
}
