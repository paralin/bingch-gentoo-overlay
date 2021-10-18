# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1
inherit ecm kde.org

DESCRIPTION="Plasma Active"
HOMEPAGE="https://community.kde.org/Plasma/Mobile"
EGIT_REPO_URI="https://invent.kde.org/kde/${PN}.git"

KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

if [[ ${PV} = 9999 ]]; then
	inherit += git-r3
    KEYWORDS=""
	SRC_URI=""
fi

LICENSE="GPL-3"
SLOT="5"
IUSE=""

DEPEND="kde-plasma/plasma-workspace[appstream,telemetry]
		net-misc/ofono
		dev-qt/libqofono
		kde-frameworks/kpeople
		net-libs/telepathy-qt
		dev-libs/libphonenumber
		kde-frameworks/kwayland
"
RDEPEND="${DEPEND}"
BDEPEND="kde-frameworks/baloo
		kde-frameworks/kdoctools
"

RESTRICT+=" test" # bug 668872
