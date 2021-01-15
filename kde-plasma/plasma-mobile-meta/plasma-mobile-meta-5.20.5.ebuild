# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package to install Plasma Mobile"
HOMEPAGE="https://mobile.danctnix.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="media-fonts/noto
		kde-plasma/plasma-phone-components
		kde-plasma/plasma-nano
		kde-plasma/plasma-mobile-settings
		kde-frameworks/kinit
		kde-plasma/kscreen
		kde-plasma/powerdevil
		kde-plasma/plasma-nm[modemmanager,mobile,openconnect]
		kde-plasma/plasma-pa
		kde-plasma/xdg-desktop-portal-kde
		dev-qt/maliit-keyboard
"
