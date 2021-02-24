# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
GNOME2_EAUTORECONF="yes"

inherit gnome.org gnome2-utils meson multilib multilib-minimal virtualx

DESCRIPTION="GObject-based multi-platform GUI toolkit"
HOMEPAGE="https://www.gtk.org/"

LICENSE="LGPL-2+"
SLOT="4"
IUSE="aqua broadway cloudprint colord cups examples gtk-doc +introspection sysprof test vulkan vim-syntax wayland +X xinerama"
REQUIRED_USE="
	|| ( aqua wayland X )
	xinerama? ( X )
"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

# Upstream wants us to do their job:
# https://bugzilla.gnome.org/show_bug.cgi?id=768662#c1
RESTRICT="test"

# FIXME: introspection data is built against system installation of gtk+:3,
# bug #????
COMMON_DEPEND="
	>=dev-libs/atk-2.32.0[introspection?,${MULTILIB_USEDEP}]
	>=dev-libs/fribidi-0.19.7[${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.57.2:2[${MULTILIB_USEDEP}]
	media-libs/fontconfig[${MULTILIB_USEDEP}]
	>=media-libs/harfbuzz-0.9:=
	>=media-libs/libepoxy-1.4[X(+)?,${MULTILIB_USEDEP}]
	virtual/libintl[${MULTILIB_USEDEP}]
	>=x11-libs/cairo-1.14[aqua?,glib,svg,X?,${MULTILIB_USEDEP}]
	>=x11-libs/gdk-pixbuf-2.30:2[introspection?,${MULTILIB_USEDEP}]
	>=x11-libs/pango-1.41.0[introspection?,${MULTILIB_USEDEP}]
	x11-misc/shared-mime-info

	cloudprint? (
		>=dev-libs/json-glib-1.0[${MULTILIB_USEDEP}]
		>=net-libs/rest-0.7[${MULTILIB_USEDEP}]
	)
	colord? ( >=x11-misc/colord-0.1.9:0=[${MULTILIB_USEDEP}] )
	cups? ( >=net-print/cups-2.0[${MULTILIB_USEDEP}] )
	introspection? ( >=dev-libs/gobject-introspection-1.39:= )
	sysprof? (
		>=dev-util/sysprof-3.38:0/4[${MULTILIB_USEDEP}] 
		>=dev-util/sysprof-capture-3.38:4[${MULTILIB_USEDEP}]
	)

	vulkan? (
		media-libs/vulkan-loader
	)
	wayland? (
		>=dev-libs/wayland-1.14.91[${MULTILIB_USEDEP}]
		>=dev-libs/wayland-protocols-1.17
		media-libs/mesa[wayland,${MULTILIB_USEDEP}]
		>=x11-libs/libxkbcommon-0.2[${MULTILIB_USEDEP}]
	)
	X? (
		>=app-accessibility/at-spi2-atk-2.15.1[${MULTILIB_USEDEP}]
		media-libs/mesa[X(+),${MULTILIB_USEDEP}]
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXcomposite[${MULTILIB_USEDEP}]
		x11-libs/libXcursor[${MULTILIB_USEDEP}]
		x11-libs/libXdamage[${MULTILIB_USEDEP}]
		x11-libs/libXext[${MULTILIB_USEDEP}]
		x11-libs/libXfixes[${MULTILIB_USEDEP}]
		>=x11-libs/libXi-1.3[${MULTILIB_USEDEP}]
		>=x11-libs/libXrandr-1.5[${MULTILIB_USEDEP}]
		xinerama? ( x11-libs/libXinerama[${MULTILIB_USEDEP}] )
	)
"
DEPEND="${COMMON_DEPEND}
	test? (
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)
	X? ( x11-base/xorg-proto )
"
# gtk+-3.2.2 breaks Alt key handling in <=x11-libs/vte-0.30.1:2.90
# gtk+-3.3.18 breaks scrolling in <=x11-libs/vte-0.31.0:2.90
RDEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-update-icon-cache-3
	!<gnome-base/gail-1000
	!<x11-libs/vte-0.31.0:2.90
"
# librsvg for svg icons (PDEPEND to avoid circular dep), bug #547710
PDEPEND="
	gnome-base/librsvg[${MULTILIB_USEDEP}]
	>=x11-themes/adwaita-icon-theme-3.14
	vim-syntax? ( app-vim/gtk-syntax )
"
BDEPEND="
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/gobject-introspection-common
	dev-libs/libxslt
	>=dev-util/gdbus-codegen-2.48
	dev-util/glib-utils
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.19.7
	virtual/pkgconfig
	gtk-doc? (
		app-text/docbook-xml-dtd:4.3
		>=dev-util/gtk-doc-1.20
	)
	vulkan? (
		media-libs/vulkan-loader
	)
"

multilib_src_configure() {
	local emesonargs=(
		$(meson_use broadway broadway-backend)
		$(meson_feature cloudprint print-cloudprint)
		$(meson_feature colord)
		$(meson_feature cups print-cups)
		$(meson_use gtk-doc gtk_doc)
		$(meson_feature introspection)
		$(meson_feature sysprof)
		$(meson_use wayland wayland-backend)
		$(meson_feature vulkan)
		$(meson_use X x11-backend)
		$(meson_feature xinerama)
		$(meson_use test build-tests)
		# cloudprovider is not packaged in Gentoo yet
		-Dcloudproviders=disabled
		-Dman-pages=false
		# need libdir here to avoid a double slash in a path that libtool doesn't
		# grok so well during install (// between $EPREFIX and usr ...)
		# TODO: Is this still the case?
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		#CUPS_CONFIG="${EPREFIX}/usr/bin/${CHOST}-cups-config"
	)

	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_test() {
	"${EROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/gtk" || die
	GSETTINGS_SCHEMA_DIR="${S}/gtk" virtx emake check
}

multilib_src_install() {
	meson_src_install
}

multilib_src_install_all() {
	insinto /etc/gtk-4.0
	doins "${FILESDIR}"/settings.ini
	# Skip README.{in,commits,win32} that would get installed by default
	#DOCS=( AUTHORS ChangeLog NEWS README )
	#einstalldocs
}
