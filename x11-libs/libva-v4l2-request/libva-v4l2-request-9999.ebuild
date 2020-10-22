# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

EGIT_REPO_URI="https://github.com/bootlin/libva-v4l2-request"

DESCRIPTION="https://github.com/bootlin/libva-v4l2-request"
HOMEPAGE="https://github.com/bootlin/libva-v4l2-request"

LICENSE="LGPL-2 MIT"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/libva-2.8.0
	>=x11-libs/libpciaccess-0.13.1-r1:=
"
RDEPEND="${DEPEND}"
