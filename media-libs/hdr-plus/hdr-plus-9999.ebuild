# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3
DESCRIPTION="HDR+ Burst Processing Pipeline"
HOMEPAGE="https://github.com/timothybrooks/hdr-plus"
_commit="65c26cba6a3eca2d08a0bccf113ca28746012cc3"
#SRC_URI="https://github.com/halide/Halide/releases/download/v8.0.0/halide-arm64-linux-64-trunk-${_commit}.tgz"
EGIT_REPO_URI="https://github.com/timothybrooks/hdr-plus.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64 ~arm"
IUSE=""

DEPEND="media-libs/libjpeg-turbo
		media-libs/libraw
		media-libs/libpng
		dev-lang/halide
"
RDEPEND="${DEPEND}"
BDEPEND=""

#CMAKE_MAKEFILE_GENERATOR="emake"

src_unpack() {
	git-r3_src_unpack
	#unpack ${A}
}

src_prepare() {
	default
	eapply_user
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DHALIDE_DISTRIB_DIR=/usr
	)

	cmake_src_configure
}

src_install() {
	dobin ${BUILD_DIR}/hdrplus
	dobin ${BUILD_DIR}/stack_frames
	dolib.so ${S}/../halide/bin/libHalide.so
}

