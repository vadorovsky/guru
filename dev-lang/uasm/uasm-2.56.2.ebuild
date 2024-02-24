# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="UASM is a free MASM-compatible assembler"
HOMEPAGE="https://www.terraspace.co.uk/uasm.html"
SRC_URI="https://github.com/Terraspace/UASM/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Watcom-1.0"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND=""
BDEPEND=""
S="${WORKDIR}/UASM-${PV}"

src_prepare() {
	default
	# don't strip binary
	sed -i gccLinux64.mak -e 's/ -s / /g' || die
}

src_compile() {
	# -fcommon: https://github.com/Terraspace/UASM/issues/143
	emake -f gccLinux64.mak CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -fcommon" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin GccUnixR/uasm
	dodoc *.txt Doc/*.txt
}
