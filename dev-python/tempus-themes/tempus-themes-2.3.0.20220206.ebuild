# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..13} pypy3_11 )
inherit distutils-r1 pypi

DESCRIPTION="Accessible themes for Pygments"
HOMEPAGE="
	https://pypi.org/project/tempus-themes/
	https://gitlab.com/protesilaos/tempus-themes-generator
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-import-check )

distutils_enable_tests import-check
