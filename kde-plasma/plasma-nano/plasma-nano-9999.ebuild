# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.83.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.2
inherit ecm kde.org


DESCRIPTION="A minimal Plasma shell package"
HOMEPAGE="https://invent.kde.org/kde/plasma-nano"

KEYWORDS="~amd64 ~arm64"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://invent.kde.org/plasma/${PN}.git"
fi

LICENSE="GPL-3"
SLOT="5"
IUSE=""

DEPEND=" =kde-plasma/plasma-workspace-${PV}
"
RDEPEND="${DEPEND}"
