FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCREV = "99469895318be8283586e314b145d1552cb687c6"
PV = "6.0"
PATCH_VERSION = "0"

DEPENDS += "libxml2"

SRC_URI_remove = "git://github.com/llvm-mirror/llvm.git;branch=release_50;protocol=http"
SRC_URI_append = " git://github.com/llvm-mirror/llvm.git;branch=master;protocol=http \
                   file://0003-CMakeLists-don-t-use-a-version-suffix.patch"
