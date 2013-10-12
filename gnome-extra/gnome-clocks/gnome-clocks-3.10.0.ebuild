# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-clocks/gnome-clocks-3.8.2.ebuild,v 1.2 2013/06/30 21:35:08 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.22"

inherit gnome2 vala

DESCRIPTION="Clocks application for GNOME"
HOMEPAGE="http://live.gnome.org/GnomeClocks"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.36:2
	>=x11-libs/gtk+-3.9.11:3
	>=media-libs/libcanberra-0.30
	>=dev-libs/libgweather-3.9.91:=
	>=gnome-base/gnome-desktop-3.7.90:=
	>=sci-geosciences/geocode-glib-0.99.3
	>=app-misc/geoclue-1.99.3
	>=x11-libs/libnotify-0.7:=
"
DEPEND="${RDEPEND}
	$(vala_depend)
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_prepare() {
	gnome2_src_prepare
	vala_src_prepare
}

src_configure() {
	gnome2_src_configure ITSTOOL=$(type -P true)
}
