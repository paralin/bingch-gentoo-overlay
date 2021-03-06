# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package to install Plasma Mobile"
HOMEPAGE="https://mobile.danctnix.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="media-fonts/noto
		net-libs/accounts-qml
		net-misc/ofonoctl
		kde-apps/kaccounts-integration
		kde-apps/konsole
		kde-plasma/plasma-phone-components
		kde-plasma/plasma-nano
		kde-plasma/plasma-mobile-settings
		kde-frameworks/kinit
		kde-plasma/kscreen
		kde-plasma/powerdevil
		kde-plasma/plasma-nm[modemmanager,openconnect]
		kde-plasma/plasma-pa
		kde-misc/kdeconnect
		media-libs/pulseaudio-qt
		kde-plasma/xdg-desktop-portal-kde
		kde-plasma/kwallet-pam
		kde-plasma/plasma-settings
		kde-plasma/plasma-phonebook
		dev-qt/qtfeedback
		x11-misc/maliit-keyboard
		kde-plasma/spacebar
		kde-plasma/discover
		kde-plasma/xembed-sni-proxy
		kde-plasma/kclock
		kde-plasma/plasma-dialer
		kde-plasma/bluedevil
		net-voip/telepathy-ofono
		net-libs/telepathy-glib

		x11-misc/appmenu-gtk-module
"
RDEPEND="${DEPEND}"
