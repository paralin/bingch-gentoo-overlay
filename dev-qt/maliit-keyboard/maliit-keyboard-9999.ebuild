# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

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
IUSE=""

		#dev-qt/qtfeedback
DEPEND="dev-qt/maliit-framework
		media-fonts/noto-emoji
		dev-qt/qtmultimedia
		app-text/hunspell
		app-text/presage
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

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
		-DCMAKE_BUILD_TYPE=Release
	)

	cmake_src_configure
}
