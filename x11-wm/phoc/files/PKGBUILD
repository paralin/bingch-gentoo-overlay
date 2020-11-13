# Maintainer: Dan Johansen <strit@manjaro.org>
# Contributor: Philip Goto <philip.goto@gmail.com>

pkgname=phoc
pkgver=0.4.4+4+ga5bdd63
pkgrel=3
_commit=a5bdd630bbb67a680aa5308a32c2e69aef0a08e5
pkgdesc="Wlroots based Phone compositor"
url="https://source.puri.sm/Librem5/phoc"
license=("GPL3")
arch=('i686' 'x86_64' 'armv6h' 'armv7h' 'aarch64')
depends=('gobject-introspection' 'gnome-desktop' 'libinput' 'mutter'
         'xcb-util-errors' 'xcb-util-wm')
makedepends=('meson')
provides=('wlroots')
conflicts=('wlroots')
source=("git+https://source.puri.sm/Librem5/${pkgname}.git#commit=${_commit}"
        0001-seat-Don-t-notify-on-key-release.patch
        0002-seat-inhibit-touch-events-when-in-power-save-mode-or.patch
        0003-output-make-sure-rotations-are-always-clockwise.patch)
sha256sums=('SKIP'
            'fbabb0c9f31c2520cf72a252e1cc4a4da7091b830ed5e439901f007205a59cd8'
            '9c4ff0cc5d189b69fe0b02b1e6419b2071dc8f8002dc533095ea1b378c671464'
            '43b1793a607d8643707f34103c771554a1a540a448bafd0ffad45e51d72194d9')

pkgver() {
  cd $pkgname
  git describe --tags | sed 's/^v//;s/-/+/g'
}

prepare() {
  cd $pkgname

  # update the submodules
  git submodule update --init --recursive

  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    [[ $src = *.patch ]] || continue
    echo "Applying patch $src..."
    patch -Np1 < "../$src"
  done
}

build() {
  rm -rf build
  arch-meson $pkgname build -Dtests=false
  ninja -C build
}

package() {
  DESTDIR="${pkgdir}" ninja -C build install
  install -Dm755 $pkgname/helpers/scale-to-fit ${pkgdir}/usr/bin
}
