# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd udev

DESCRIPTION="Everything you need for your EG25 modem"
HOMEPAGE="https://github.com/dreemurrs-embedded/Pine64-Arch/tree/master/PKGBUILDS/pine64/danctnix-eg25-misc"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND="net-dialup/atinout"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
	udev_dorules "${FILESDIR}/90-modem-eg25.rules"

	exeinto /usr/lib/danctnix/eg25
	doexe "${FILESDIR}/eg25_power.sh"
	doexe "${FILESDIR}/eg25_audio_routing.sh"

	systemd_dounit ${FILESDIR}/eg25_power.service
	systemd_dounit ${FILESDIR}/eg25_audio_routing.service
}
