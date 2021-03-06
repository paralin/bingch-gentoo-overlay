# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg git-r3

DESCRIPTION="Messaging client"
HOMEPAGE="https://source.puri.sm/Librem5/chatty"
EGIT_REPO_URI="https://source.puri.sm/Librem5/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~arm64 ~arm ~x86"

if [[ ${PV} != 9999 ]]; then
        #EGIT_COMMIT="tags/v${PV}"
        EGIT_COMMIT="76e2813c6fe6d3e7d918bae71cd4b270802af18f"
else
        KEYWORDS=""
fi


#DEPEND="gnome-extra/evolution-data-server[phonenumber]
DEPEND="gnome-extra/evolution-data-server
		dev-libs/libphonenumber
		dev-libs/feedbackd
		gui-libs/libhandy
		x11-plugins/purple-mm-sms
		dev-libs/olm
		x11-libs/gtk+:3
		net-im/jabber-base
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
