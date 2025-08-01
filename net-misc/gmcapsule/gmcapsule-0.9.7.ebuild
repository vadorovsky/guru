# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} pypy3_11 )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi systemd

DESCRIPTION="Extensible Gemini/Titan server"
HOMEPAGE="
	https://pypi.org/project/gmcapsule/
	https://git.skyjake.fi/gemini/gmcapsule
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/gemini
	>=dev-python/pyopenssl-21
"

EPYTEST_PLUGINS=( pytest-import-check )

distutils_enable_tests import-check

python_install() {
	rm "${BUILD_DIR}/install$(python_get_sitedir)"/*.ini || die
	distutils-r1_python_install
}

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}"/gmcapsuled.initd gmcapsuled
	newconfd "${FILESDIR}"/gmcapsuled.confd gmcapsuled
	systemd_dounit "${FILESDIR}"/gmcapsuled.service

	insinto /etc/gmcapsule
	newins example.ini config.example.ini
}
