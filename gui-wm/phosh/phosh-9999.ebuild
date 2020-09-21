# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#EAPI=6
#GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

inherit vala meson git-r3

KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~sparc ~x86"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

KEYWORDS="~amd64 ~x86 ~arm ~arm64"
EGIT_REPO_URI="https://source.puri.sm/Librem5/phosh.git"
if [[ ${PV} != 9999 ]]; then
	EGIT_REPO_BRANCH="tags/v${PV}"
else
	KEYWORDS=""
fi
#EGIT_SUBMODULES=("https://gitlab.gnome.org/GNOME/libgnome-volume-control.git")

DESCRIPTION="A pure Wayland shell prototype for GNOME on mobile devices"
HOMEPAGE="https://source.puri.sm/Librem5/phosh"

LICENSE="GPL-3"
SLOT="0"
IUSE="+vala +introspection"

DEPEND="
		dev-libs/feedbackd
		>=gui-libs/libhandy-1.0.0
		vala? ( $(vala_depend) )
		>=net-misc/modemmanager-1.12.0
		net-misc/networkmanager
		gnome-base/gnome-session
		x11-themes/gnome-backgrounds
		x11-wm/phoc
		sys-apps/systemd[cryptsetup,homed]
		"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/ctags
		dev-util/meson
		dev-libs/gobject-introspection
"
src_prepare() {
	eapply_user
	use vala && vala_src_prepare
#   gnome2_src_prepare
}

