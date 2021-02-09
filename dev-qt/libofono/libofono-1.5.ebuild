# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils git-r3

DESCRIPTION="A Qt-based library that providesbindings to oFono"
HOMEPAGE="https://github.com/Kaffeine/libofono-qt"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Kaffeine/libofono-qt.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/v${PV}"
        #EGIT_COMMIT="8132b5ff5035c468807c291b4fa30d7e0a54cba4"
else
        KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="app-doc/doxygen
		dev-qt/qtcore
"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/fix_lib64_path.patch"
src_prepare() {
	default
}

src_configure() {
	eqmake5
}

src_install() {
	INSTALL_ROOT=${D} emake install
}
