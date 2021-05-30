# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A libpurple plugin for sending and receiving SMS via Modemmanager"
HOMEPAGE="https://source.puri.sm/kop316/purple-mm-sms"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="net-misc/modemmanager
	net-im/pidgin"
DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://source.puri.sm/kop316/purple-mm-sms"
EGIT_COMMIT="d1bd6c61"
