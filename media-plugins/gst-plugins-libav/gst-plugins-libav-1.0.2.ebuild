# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils flag-o-matic gst-plugins10

MY_PN="gst-libav"
DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-libav.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_PN}-${PV}.tar.${GST_TARBALL_SUFFIX}"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="+orc"

RDEPEND="
	media-libs/gst-plugins-base:1.0
	>=virtual/ffmpeg-0.10.3
	|| (
		media-video/ffmpeg
		>=media-video/libav-0.8.4 )
	orc? ( >=dev-lang/orc-0.4.16 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	sed -e 's/sleep 15//' -i configure.ac configure || die
}

src_configure() {
	GST_PLUGINS_BUILD=""
	# always use system ffmpeg/libav if possible
	gst-plugins10_src_configure \
		--with-system-libav \
		$(use_enable orc)
}

src_compile() {
	default
}

src_install() {
	default
}

pkg_postinst() {
	if has_version "media-video/ffmpeg"; then
		elog "Please note that upstream uses media-video/libav"
		elog "rather than media-video/ffmpeg. If you encounter any"
		elog "issues try to move from ffmpeg to libav."
	fi
}
