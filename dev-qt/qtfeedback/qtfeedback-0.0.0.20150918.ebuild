# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt5-build git-r3

DESCRIPTION="Qt Tactile Feedback Add-on Module"
HOMEPAGE="https://github.com/qtproject/qtfeedback"
SRC_URI=""
EGIT_REPO_URI="https://github.com/qtproject/qtfeedback.git"

#QT5_BUILD_TYPE=release

if [[ ${QT5_BUILD_TYPE} == release ]]; then
    KEYWORDS="~amd64 ~arm64"
fi

if [[ ${PV} != 9999 ]]; then
        #EGIT_COMMIT="tags/v${PV}"
        EGIT_COMMIT="28ca62414901502189ea28ef2efd551386187619"
else
        KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-qt/qtdeclarative
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_prepare() {
	default
	qt5-build_src_prepare
}

src_install() {
	qt5-build_src_install
	# rm Qt5Feedback_.cmake since it causes maliit-keyboard configuration fails
	find ${D} -name Qt5Feedback_.cmake -exec rm {} \;
}
