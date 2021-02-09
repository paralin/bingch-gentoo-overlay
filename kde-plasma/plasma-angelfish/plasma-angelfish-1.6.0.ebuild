# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1
inherit ecm kde.org git-r3


DESCRIPTION="Plasma Demo Webbrowser for Mobile Devices"
HOMEPAGE="https://community.kde.org/Plasma/Mobile"
SRC_URI=""
EGIT_REPO_URI="https://invent.kde.org/kde/${PN}.git"

if [[ ${PV} != 9999 ]]; then
        #EGIT_COMMIT="tags/v${PV}"
        EGIT_COMMIT="6d493cf1a3d77459896f7ee31b0eb751b0449448"
else
        KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="kde-frameworks/plasma
		kde-frameworks/purpose
		dev-qt/qtwebengine
"
RDEPEND="${DEPEND}"

RESTRICT+=" test" # bug 668872
