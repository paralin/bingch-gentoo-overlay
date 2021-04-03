# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Settings files for Plasma Mobile"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/plasma-mobile/plasma-mobile-settings"
EGIT_REPO_URI="https://gitlab.manjaro.org/manjaro-arm/packages/community/plasma-mobile/plasma-mobile-settings.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="sys-apps/accountsservice
		media-fonts/noto
		kde-plasma/breeze
		kde-plasma/breeze-gtk
"
RDEPEND="${DEPEND}"

src_install () {
	insinto /etc/xdg
	doins applications-blacklistrc
	doins kdeglobals
	doins kwinrc
	insinto /etc/NetworkManager/conf.d
	doins disable-random-mac.conf
	insinto /etc
	doins sddm.conf
	insinto /etc/profile.d
	doins packagekit-offline.sh
	exeinto /usr/lib/systemd/system-sleep
	doexe ofono-fast-dormancy.sh
	insinto /usr/share/glib-2.0/schemas
	doins 91_plasma-mobile.gschema.override
	insinto usr/share/maliit/keyboard2/devices
	doins plasmamobile.json
	insinto /etc/skel/.config/gtk-3.0
	doins settings.ini
	#insinto /usr/share/maliit/keyboard2/themes
	#doins Breeze.json
	#doins BreezeDark.json
}
