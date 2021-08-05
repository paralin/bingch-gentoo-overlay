# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1
inherit ecm kde.org git-r3


DESCRIPTION="Phonebook application for Mobile Devices running Plasma"
HOMEPAGE="https://community.kde.org/Plasma/Mobile"
SRC_URI=""
EGIT_REPO_URI="https://invent.kde.org/plasma-mobile/${PN}.git"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/v${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="kde-frameworks/kcontacts
		kde-frameworks/kirigami
		kde-frameworks/kpeople
		dev-libs/kpeoplevcard
		dev-qt/qtquickcontrols2
		dev-qt/qtsvg
"
RDEPEND="${DEPEND}"
