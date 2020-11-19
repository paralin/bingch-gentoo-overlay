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
		gnome-extra/iio-sensor-proxy
		!media-sound/wys
		media-sound/callaudiod
		x11-themes/sound-theme-librem5
		sys-firmware/anx7688-firmware
		sys-firmware/rtl8723bt-firmware
		sys-firmware/ov5640-firmware
		media-tv/v4l-utils
		app-mobilephone/usb-tethering
		app-mobilephone/pinephone-modem-scripts
		app-mobilephone/pinephone-softsleep
"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
	udev_dorules "${FILESDIR}/10-proximity.rules"
	udev_dorules "${FILESDIR}/20-pinephone-led.rules"

	dobin ${FILESDIR}/pinephone-camera-setup.sh
	systemd_dounit ${FILESDIR}/pinephone-camera-setup.service
}
