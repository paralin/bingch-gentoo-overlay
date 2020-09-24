# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd toolchain-funcs

DESCRIPTION="A quick hack to prioritise calls, NetworkManager, phoc, phosh, and squeekboard on the PinePhone."
MY_COMMIT="34f6ea2a88af604b43d236df050637d2f60358b2"
HOMEPAGE="https://github.com/KeironO/phosh-renice"
SRC_URI="https://github.com/KeironO/phosh-renice/archive/${MY_COMMIT}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND="gui-wm/phosh
		sys-apps/util-linux
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare() {
	eapply_user
	sed -i "s/\/usr\/local/\/usr/g" phosh-renice.service
}

src_install() {
	default
	dobin phosh_renice.sh 
	systemd_dounit phosh-renice.service
}
