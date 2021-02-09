# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1

inherit ecm kde.org git-r3

DESCRIPTION="Add-ons for the Kirigami framework"
HOMEPAGE="https://invent.kde.org/libraries/kirigami-addons"
EGIT_REPO_URI="https://invent.kde.org/libraries/${PN}.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/v${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE="examples"

BDEPNED="
"
DEPEND="
	kde-frameworks/kirigami
	kde-frameworks/ki18n
"
RDEPEND="${DEPEND}
"

# requires package to already be installed
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
	)

	ecm_src_configure
}
