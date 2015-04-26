# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 readme.gentoo
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="https://wiki.gnome.org/Apps/Terminal/"

LICENSE="GPL-3+"
SLOT="0"
IUSE="debug +gnome-shell +nautilus"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux"
fi

# FIXME: automagic dependency on gtk+[X]
RDEPEND="
	>=dev-libs/glib-2.40:2[dbus]
	>=x11-libs/gtk+-3.10:3[X]
	>=x11-libs/vte-0.40:2.91
	>=gnome-base/dconf-0.14
	>=gnome-base/gsettings-desktop-schemas-0.1.0
	sys-apps/util-linux
	x11-libs/libSM
	x11-libs/libICE
	gnome-shell? ( gnome-base/gnome-shell )
	nautilus? ( >=gnome-base/nautilus-3 )
"
# gtk+:2 needed for gtk-builder-convert, bug 356239
DEPEND="${RDEPEND}
	app-text/yelp-tools
	dev-util/gdbus-codegen
	dev-util/gtk-builder-convert
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

DOC_CONTENTS="To get previous working directory inherited in new opened
	tab you will need to add the following line to your ~/.bashrc:\n
	. /etc/profile.d/vte.sh"

src_configure() {
	local myconf=""

	if [[ ${PV} != 9999 ]]; then
		myconf="${myconf}
			ITSTOOL=$(type -P true)
			XMLLINT=$(type -P true)
		"
	fi

	gnome2_src_configure \
		--disable-static \
		--enable-migration \
		$(use_enable debug) \
		$(use_enable gnome-shell search-provider) \
		$(use_with nautilus nautilus-extension) \
		${myconf}
}

src_install() {
	DOCS="AUTHORS ChangeLog HACKING NEWS"
	gnome2_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	gnome2_pkg_postinst
	readme.gentoo_print_elog
}
