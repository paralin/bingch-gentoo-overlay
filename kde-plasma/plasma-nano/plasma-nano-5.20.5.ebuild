# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1
inherit ecm kde.org git-r3


DESCRIPTION="A minimal Plasma shell package"
HOMEPAGE="https://community.kde.org/kde/plasma-nano"
SRC_URI=""
EGIT_REPO_URI="https://invent.kde.org/kde/${PN}.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_REPO_BRANCH="tags/v${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="kde-plasma/plasma-workspace
"
RDEPEND="${DEPEND}"