# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1
inherit ecm kde.org git-r3

DESCRIPTION="Video player built with Qt/QML on top of libmpv"
HOMEPAGE="https://invent.kde.org/multimedia/haruna/"
#SRC_URI="https://invent.kde.org/multimedia/${PN}/-/archive/v${PV}/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

SRC_URI=""
EGIT_REPO_URI="https://invent.kde.org/multimedia/${PN}.git"

if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/${PV}"
        #EGIT_COMMIT="f9648e8f634e12161caac00e7d7e63a16c7ccdc4"
else
        KEYWORDS=""
fi


DEPEND="kde-frameworks/kfilemetadata
		kde-frameworks/kio
		media-video/mpv
		dev-qt/qtquickcontrols2
		kde-frameworks/kirigami
		kde-frameworks/breeze-icons

"
RDEPEND="${DEPEND}"
BDEPEND="kde-frameworks/extra-cmake-modules"
