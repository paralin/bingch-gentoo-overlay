# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3


DESCRIPTION="library for parsing, formatting, and validating international phone numbers"
HOMEPAGE="https://github.com/googlei18n/libphonenumber"
SRC_URI=""
EGIT_REPO_URI="https://github.com/googlei18n/${PN}.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_REPO_BRANCH="tags/v${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="dev-libs/icu
		dev-libs/protobuf
		dev-libs/boost
"
RDEPEND="${DEPEND}"

BDEPEND="dev-cpp/gtest
		virtual/jdk
"

RESTRICT+=" test" # bug 668872

CMAKE_USE_DIR=${S}/cpp

CMAKE_MAKEFILE_GENERATOR=emake
