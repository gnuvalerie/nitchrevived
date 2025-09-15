pkgname=nitchrevived
pkgver=0.1.7
_commit=8de7724a9e05cb0c3d2e03b3092b85f3df281f5d
pkgrel=3
pkgdesc="Incredibly fast system fetch written in nim! Revived"
arch=(x86_64)
url=https://git.teto.party/pkgs/nitchrevived
license=(MIT)
depends=(glibc)
makedepends=(nim git openssl-1.1)
source=("git+$url#commit=$_commit")
md5sums=(SKIP)

build() {
	cd "$pkgname"
	nimble build
}

package() {
	cd "$pkgname"
	install -Dm755 -t "$pkgdir/usr/bin" "$pkgname"
	install -Dm644 -t "$pkgdir/usr/share/licenses/$pkgname" LICENSE
}
