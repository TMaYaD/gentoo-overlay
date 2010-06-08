# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils bzr

EBZR_REPO_URI="lp:cairo-dock-plug-ins"

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="https://launchpad.net/cairo-dock-plug-ins"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa doncky exif gio gmenu gnome kde mail network scoobydo terminal
	webkit xklavier xfce xgamma xrandr"

RDEPEND="~x11-misc/cairo-dock-${PV}
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	mail? ( net-libs/libetpan )
	terminal? ( x11-libs/vte )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	xrandr? ( x11-libs/libXrandr )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	if use gio; then
		if ! use gmenu; then
			ewarn "gio requires gmenu, implicitly added"
		fi
	fi
}
src_prepare() {
	bzr_src_prepare
	epatch "${FILESDIR}/missing-libetpan.patch"
	epatch "${FILESDIR}/missing-uninstall-config.patch"
}
src_configure() {
	local mycmakeargs="${mycmakeargs}
        -DCMAKE_INSTALL_PREFIX:PATH=/usr
		$(cmake-utils_use alsa  enable_alsa_mixera)
		$(cmake-utils_use doncky enable-doncky)
		$(cmake-utils_use gio enable_gnome_integration)
		$(cmake-utils_use gnome enable_old_gnome_integration)
		$(cmake-utils_use kde enable_kde_integration)
		$(cmake-utils_use network enable-network-monitor)
		$(cmake-utils_use scoobydo enable-scooby-do)
		$(cmake-utils_use xfce enable_xfce_integration)
		"
	cmake-utils_src_configure
}
src_install() {
	cmake-utils_src_install
}
pkg_postinst() {
	ewarn "THIS IS A LIVE EBUILD, SO YOU KNOW THE RISKS !"
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	einfo "Please report all bugs to #gentoo-desktop-effects"
	einfo "Thank you on behalf of the Gentoo Desktop-Effects team"
}
