# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="GUI display configurator for wlroots compositors"
HOMEPAGE="https://github.com/artizirk/wdisplays"

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/artizirk/wdisplays.git"
else
	SRC_URI="https://github.com/artizirk/wdisplays/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
RESTRICT="mirror test"

RDEPEND="
	dev-libs/glib
	dev-libs/wayland
	media-libs/libepoxy
	x11-libs/gtk+:3[wayland]
	x11-libs/cairo
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
"
