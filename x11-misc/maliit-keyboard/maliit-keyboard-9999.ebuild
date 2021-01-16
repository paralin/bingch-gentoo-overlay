# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3 gnome2-utils xdg

DESCRIPTION="Maliit keyboard"
HOMEPAGE="https://github.com/maliit/keyboard"
SRC_URI=""
EGIT_REPO_URI="https://github.com/maliit/keyboard.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_REPO_BRANCH="tags/v${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE="test"

		#dev-qt/qtfeedback
DEPEND="x11-misc/maliit-framework
		media-fonts/noto-emoji
		dev-qt/qtmultimedia
		app-text/hunspell
		app-text/presage[sqlite]
		app-i18n/libchewing
		app-i18n/libpinyin
		app-i18n/anthy
		dev-db/sqlite
"
RDEPEND="${DEPEND}"

BDEPEND="app-doc/doxygen
		media-gfx/graphviz
"

#PATCHES="${FILESDIR}/0001-Add-0001-Bring-back-LanguagePluginInterface.patch"

src_prepare() {
	cmake-utils_src_prepare
}
src_configure() {
	local mycmakeargs=(
		-Denable-tests=$(usex test ON OFF)
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
