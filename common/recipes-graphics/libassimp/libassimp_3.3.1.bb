DESCRIPTION = "Open Asset Import Library is a portable Open Source library to import \
               various well-known 3D model formats in a uniform manner."
HOMEPAGE = "http://www.assimp.org/"
SECTION = "devel"
LICENSE = "BSD"
#LIC_FILES_CHKSUM = "file://LICENSE;md5=bc4231a2268da8fc55525ad119638a87"
LIC_FILES_CHKSUM = "file://LICENSE;md5=4cd8c0aedc7a0623476669377d7eeda8"

DEPENDS = "boost"

SRC_URI = "https://github.com/assimp/assimp/archive/v3.3.1.zip"
SRC_URI[md5sum] = "c20ae75c10d1569cd6fa435eef079f56"
SRC_URI[sha256sum] = "72489ee89fee447ae97772bb85eed10418c739b529af9dd39dd46f3bc06e42c5"

S = "${WORKDIR}/assimp-3.3.1/"

inherit cmake

EXTRA_OECMAKE += "-DASSIMP_LIB_INSTALL_DIR=${libdir}"

INSANE_SKIP_${PN} = "libdir"

FILES_${PN}-dev += "${libdir}/cmake"
