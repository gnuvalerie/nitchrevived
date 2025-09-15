pkgname=nitchrevived
pkgver=0.1.7
_commit=11a6cf559f90e631b08957892e9300253d6a2846
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
