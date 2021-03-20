# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit gnome.org meson git-r3

DESCRIPTION="A set of backgrounds packaged with the GNOME desktop"
HOMEPAGE="https://git.gnome.org/browse/gnome-backgrounds"

LICENSE="CC-BY-SA-2.0 CC-BY-SA-3.0 CC-BY-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_URI=""

EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
if [[ ${PV} != 9999 ]]; then
    #EGIT_COMMIT="tags/${PV}.rc"
    EGIT_BRANCH="gnome-40"
else
    KEYWORDS=""
fi

DEPEND=""
RDEPEND=""
BDEPEND=">=sys-devel/gettext-0.19.8"
