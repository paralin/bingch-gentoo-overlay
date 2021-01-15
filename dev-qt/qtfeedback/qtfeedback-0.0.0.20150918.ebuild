# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils git-r3

DESCRIPTION="Qt Tactile Feedback Add-on Module"
HOMEPAGE="https://github.com/qtproject/qtfeedback"
SRC_URI=""
EGIT_REPO_URI="https://github.com/qtproject/qtfeedback.git"

if [[ ${PV} != 9999 ]]; then
        #EGIT_REPO_BRANCH="tags/v${PV}"
        EGIT_COMMIT="28ca62414901502189ea28ef2efd551386187619"
else
        KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="dev-qt/qtdeclarative
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
}

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT=${D}
}
