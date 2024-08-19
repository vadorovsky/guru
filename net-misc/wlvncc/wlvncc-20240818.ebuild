# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT="174ad8aef7978c242861a66c481a7ca25dc04e37"

inherit meson

SRC_URI="https://github.com/any1/${PN}/archive/${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

DESCRIPTION="A Wayland Native VNC Client"
HOMEPAGE="https://github.com/any1/wlvncc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="
    dev-libs/wayland-protocols
"
RDEPEND="
    dev-libs/aml
    x11-libs/libxkbcommon
    x11-libs/pixman
    dev-libs/wayland
"