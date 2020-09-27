# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd udev

DESCRIPTION="PinePhone device package"
HOMEPAGE="https://github.com/dreemurrs-embedded/Pine64-Arch"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND="media-libs/alsa-ucm-pinephone
		net-dialup/eg25
		gnome-extra/iio-sensor-proxy
		media-sound/wys
		sys-firmware/anx7688-firmware
		x11-misc/squeekboard
		app-mobilephone/usb-tethering
"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
	udev_dorules "${FILESDIR}/10-proximity.rules"
	udev_dorules "${FILESDIR}/20-pinephone-led.rules"

	exeinto  "$(systemd_get_utildir)/system-sleep"
	doexe "${FILESDIR}/pinephone-suspend-hook.sh"

	dobin ${FILESDIR}/pinephone-camera-setup.sh

	systemd_dounit ${FILESDIR}/pinephone-camera-setup.service
}
