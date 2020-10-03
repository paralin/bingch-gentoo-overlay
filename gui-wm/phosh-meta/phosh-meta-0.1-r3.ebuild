# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package for Phosh"
HOMEPAGE="https://github.com/dreemurrs-embedded/Pine64-Arch"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND="gnome-base/gnome-core-libs
		x11-wm/phoc
		gui-wm/phosh
		app-admin/phosh-renice
		dev-libs/feedbackd
		net-voip/calls
		net-im/chatty
		x11-misc/squeekboard
		net-dns/dnsmasq
		app-editors/gedit
		gnome-base/gnome-control-center
		gnome-base/nautilus
		gnome-extra/gnome-contacts
		gnome-extra/iio-sensor-proxy
		gnome-extra/camera
		x11-terms/gnome-terminal
		x11-themes/sound-theme-librem5
		media-sound/wys
		mail-client/geary
		app-text/evince
		app-editors/gedit
		sys-power/gtherm
"

RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"
