# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3


DESCRIPTION="An implementation of the Double Ratchet cryptographic ratchet in C++"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm"
#SRC_URI="https://gitlab.matrix.org/matrix-org/${PN}/-/archive/${PV}/${P}.tar.bz2"
SRC_URI=""

EGIT_REPO_URI="https://gitlab.matrix.org/matrix-org/${PN}.git"


if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc
"
RDEPEND="${DEPEND}"

BDEPEND=""

RESTRICT+=" test" # bug 668872

#CMAKE_MAKEFILE_GENERATOR=emake
