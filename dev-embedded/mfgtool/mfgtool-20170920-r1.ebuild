# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit git-r3 cmake-utils toolchain-funcs

DESCRIPTION="NXP i.MX Chip image deploy tools"
HOMEPAGE="https://github.com/NXPmicro/mfgtools"
EGIT_REPO_URI="https://github.com/NXPmicro/mfgtools"

LICENSE="BSD CPOL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libzip"
RDEPEND="${DEPEND}
	virtual/libusb:1"
