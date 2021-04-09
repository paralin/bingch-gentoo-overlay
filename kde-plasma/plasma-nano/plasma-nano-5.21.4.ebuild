# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.74.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.15.1
inherit ecm kde.org git-r3


DESCRIPTION="A minimal Plasma shell package"
HOMEPAGE="https://invent.kde.org/kde/plasma-nano"
EGIT_REPO_URI="https://invent.kde.org/plasma/${PN}.git"

KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

if [[ ${PV} = 9999 ]]; then
        KEYWORDS=""
		SRC_URI=""
fi

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND=" =kde-plasma/plasma-workspace-${PV}
"
RDEPEND="${DEPEND}"
