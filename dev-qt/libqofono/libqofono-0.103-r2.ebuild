# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils git-r3

DESCRIPTION="A library for accessing the ofono daemon, and a declarative plugin for it"
HOMEPAGE="https://git.merproject.org/mer-core/libqofono"
SRC_URI=""
EGIT_REPO_URI="https://git.sailfishos.org/mer-core/libqofono.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="dev-qt/qtdeclarative
		dev-qt/qtxmlpatterns
"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/0001-add-support-for-reset-contexts.patch
		${FILESDIR}/context-preferred.patch
		${FILESDIR}/mtk_settings_binding.patch
"

src_prepare() {
	default
}

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT=${D}
}
