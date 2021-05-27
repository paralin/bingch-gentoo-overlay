# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="ALSA ucm configuration files for PinePhone"
HOMEPAGE="https://gitlab.com/pine64-org/pine64-alsa-ucm"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~arm64"
IUSE=""

RDEPEND="media-libs/alsa-ucm-conf"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
	insinto /usr/share/alsa/ucm2/PinePhone
	doins -r ${FILESDIR}/*.conf
}
