# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit cmake qmake-utils git-r3 python-r1

DESCRIPTION="Framework for Maliit"
HOMEPAGE="https://github.com/maliit/framework"
SRC_URI=""
EGIT_REPO_URI="https://github.com/maliit/framework.git"

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

DEPEND="dev-qt/qtdeclarative
		kde-frameworks/kwayland
		dev-libs/wayland-protocols
"
RDEPEND="${DEPEND}"

BDEPEND="app-doc/doxygen
		media-gfx/graphviz
"
