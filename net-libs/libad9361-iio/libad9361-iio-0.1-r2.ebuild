# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="IIO AD9361 library for filter design and handling, multi-chip sync, etc."
HOMEPAGE="https://github.com/analogdevicesinc/libad9361-iio"
if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/analogdevicesinc/libad9361-iio"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/analogdevicesinc/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0/${PV}"

RDEPEND="net-libs/libiio:="
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "s:"${CMAKE_INSTALL_PREFIX}/lib":"${CMAKE_INSTALL_PREFIX}/$(get_libdir)":g" CMakeLists.txt || die
	eapply "${FILESDIR}/7206bb2a9b655be3bdb66c6cf03aa504817ed240.patch"
	cmake-utils_src_prepare
	eapply_user
}
