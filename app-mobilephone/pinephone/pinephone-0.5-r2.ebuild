# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd udev

DESCRIPTION="PinePhone device packages and tweak scripts stolen from Manjanro"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-manjaro-tweaks.git"
SRC_URI=""

LICENSE="GPL-3"
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
		sys-boot/osk-sdl
"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
	udev_dorules "${FILESDIR}/10-proximity.rules"
	udev_dorules "${FILESDIR}/20-pinephone-led.rules"
	udev_dorules "${FILESDIR}/90-usb-gadget-managed.rules"
	udev_dorules "${FILESDIR}/99-automount-sd.rules"

	insinto /etc/gtk-3.0/
	doins "${FILESDIR}/gtk3-settings.ini"

	insinto /etc/profile.d
	doins "${FILESDIR}/manjaro-tweaks.sh"

	insinto /usr/share/glib-2.0/schemas
	doins "${FILESDIR}/90_manjaro.gschema.override"

	insinto /usr/lib/firefox/
	doins "${FILESDIR}/manjaro.cfg"

	insinto /usr/lib/firefox/defaults/pref
	doins "${FILESDIR}/autoconfig.js"

	insinto /usr/share/feedbackd/themes
	doins "${FILESDIR}/manjaro.json"

	insinto /var/lib/polkit-1/localauthority/10-vendor.d
	doins "${FILESDIR}/org.freedesktop.ModemManager1.pkla"

	insinto /etc/systemd/logind.conf.d
	doins "${FILESDIR}/ignore-power-key.conf"

#	insinto /etc/dconf/profile/user
#	doins "${FILESDIR}/dconf-profile-manjaro"

	insinto /etc/dconf/db/manjaro.d
	doins "${FILESDIR}/01-phoc-scaling"

#	exeinto /usr/lib/systemd/system-sleep/
#	doexe "${FILESDIR}/pinephone-suspend-hook.sh"

	exeinto /etc/profile.d
	doexe "${FILESDIR}/manjaro-tweaks.sh"

	dobin "${FILESDIR}/pinephone-camera-setup.sh"
	newbin "${FILESDIR}/phosh_renice.sh" phosh_renice

	systemd_dounit ${FILESDIR}/pinephone-camera-setup.service
	systemd_dounit ${FILESDIR}/phosh-renice.service
}
