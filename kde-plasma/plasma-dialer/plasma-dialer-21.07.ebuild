# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1
inherit ecm kde.org git-r3


DESCRIPTION="Plasma Dialer"
HOMEPAGE="https://community.kde.org/Plasma/Mobile"
SRC_URI=""
EGIT_REPO_URI="https://invent.kde.org/kde/${PN}.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/v${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="kde-plasma/plasma-workspace
		net-misc/ofono
		kde-frameworks/kcontacts
		dev-qt/libqofono
		kde-frameworks/kpeople
		net-libs/telepathy-qt
		dev-libs/libphonenumber
		dev-qt/qtdeclarative[localstorage]
		kde-frameworks/kwayland
		kde-plasma/oxygen
		net-im/telepathy-mission-control
		>=media-libs/pulseaudio-qt-1.3
"
RDEPEND="${DEPEND}"
