# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Telepathy oFono connection manager"
HOMEPAGE="https://github.com/TelepathyIM/telepathy-ofono"
EGIT_REPO_URI="https://github.com/TelepathyIM/telepathy-ofono.git"
EGIT_COMMIT="8be54bb82c33cd1a5bcea4200f9c8fdb92bb2adc"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86_64 ~arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	net-misc/ofono
	dev-qt/libofono
	dev-qt/qtfeedback
"
BDEPEND="${RDEPEND}
	dev-libs/libphonenumber
	net-libs/telepathy-qt
	dev-db/sqlite
	net-im/telepathy-mission-control
"

PATCHES=(
)
