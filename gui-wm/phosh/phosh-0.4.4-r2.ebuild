# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#EAPI=6
#GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

inherit pam vala meson git-r3 gnome2-utils systemd readme.gentoo-r1 xdg

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

PATCHES=(
	"${FILESDIR}/auto-rotate.patch"
)

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
}

src_install() {
	default
	meson_src_install
	dopamd "${FILESDIR}"/pamd-include/phosh
	systemd_newunit "${S}"/debian/phosh.service 'phosh.service'

	DOC_CONTENTS="To amend the existing password policy please see the man 5 passwdqc.conf
				page and then edit the /etc/security/passwdqc.conf file to change enforce=none
				to allow use digit only password as phosh only support passcode for now"
	readme.gentoo_create_doc
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	readme.gentoo_print_elog
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
