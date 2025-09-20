pkgname=nitchrevived
pkgver=0.1.7.2
pkgrel=3
pkgdesc="Incredibly fast system fetch written in nim! NiTch Revived is project supposed to continue the NiTch after it become not maintained."
arch=(x86_64)
url=https://git.teto.party/pkgs/nitchrevived
license=(MIT)
depends=(glibc)
makedepends=(nim openssl-1.1)
source=()
md5sums=()

build() {
	nimble build -d:release --opt:speed -y -o:"$pkgname"
}

package() {
    install -Dm755 -t "$pkgdir/usr/bin" "$pkgname"
    install -Dm644 -t "$pkgdir/usr/share/licenses/$pkgname" LICENSE
}
