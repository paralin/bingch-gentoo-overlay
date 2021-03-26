# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 systemd
DESCRIPTION="Call audio routing daemon"
HOMEPAGE="https://gitlab.com/mobian1/callaudiod"
EGIT_REPO_URI="https://gitlab.com/mobian1/${PN}.git"

KEYWORDS="~amd64 ~x86 ~arm ~arm64"
if [[ ${PV} != 9999 ]]; then
        EGIT_COMMIT="tags/${PV}"
else
        KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	media-libs/alsa-lib
	dev-libs/glib
	|| (
		media-sound/pulseaudio
		>=media-sound/apulse-0.1.12-r4[sdk]
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

BUILD_DIR=${S}/build
