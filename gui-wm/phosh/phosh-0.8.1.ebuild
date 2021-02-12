# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pam vala meson git-r3 gnome2-utils systemd readme.gentoo-r1 xdg

KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~sparc ~x86"

EGIT_REPO_URI="https://source.puri.sm/Librem5/phosh.git"
if [[ ${PV} != 9999 ]]; then
	EGIT_COMMIT="tags/v${PV}"
else
	KEYWORDS=""
fi
EGIT_SUBMODULES=("subprojects/gvc")

DESCRIPTION="A pure Wayland shell prototype for GNOME on mobile devices"
HOMEPAGE="https://source.puri.sm/Librem5/phosh"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
		app-crypt/gcr
		dev-libs/feedbackd
		media-sound/pulseaudio
		>=gui-libs/libhandy-1.0.0
		net-misc/networkmanager
		gnome-base/gnome-desktop
		gnome-base/gnome-session
		x11-themes/gnome-backgrounds
		x11-wm/phoc
		sys-apps/systemd
		sys-power/upower
		"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/ctags
		dev-util/meson
"

PATCHES=(
	${FILESDIR}/0001-Revert-home-Bind-key-to-show-overview.patch
	${FILESDIR}/MR434.patch
)

src_prepare() {
	default
	eapply_user
}

src_install() {
	default
	meson_src_install
	newpamd "${FILESDIR}"/pam_phosh 'phosh'
	systemd_newunit "${FILESDIR}"/phosh.service 'phosh.service'
	insinto /usr/share/applications/
	doins "${FILESDIR}"/sm.puri.OSK0.desktop

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
