SRCREV = "089d4c0c490687db6c75f1d074e99c4d42936a50"
PV = "6.0"
PATCH_VERSION = "0"

DEPENDS += "libxml2"

SRC_URI_remove = "git://github.com/llvm-mirror/llvm.git;branch=release_50;protocol=http"
SRC_URI_append = " git://github.com/llvm-mirror/llvm.git;branch=release_60;protocol=http"
