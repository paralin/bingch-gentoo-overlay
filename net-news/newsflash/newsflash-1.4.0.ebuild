# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson gnome2-utils

DESCRIPTION="Follow your favorite blogs & news sites"
HOMEPAGE="https://gitlab.com/news-flash/news_flash_gtk"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND=">x11-libs/gtk+-3.0
	>=gui-libs/libhandy-1.0.3
	net-libs/webkit-gtk
	>dev-db/sqlite-3.0
	sys-devel/gettext"

DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://gitlab.com/news-flash/news_flash_gtk.git"
EGIT_BRANCH="master"
EGIT_COMMIT="${PV}"
