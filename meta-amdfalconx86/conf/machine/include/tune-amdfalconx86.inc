DEFAULTTUNE ?= "dbfp4"

require conf/machine/include/x86/arch-x86.inc
require conf/machine/include/x86-base.inc


# AMD DB-FP4 64bit (MerlinFalcon)
TUNEVALID[dbfp4] = "Enable AMD DB-FP4 (64 bit) specific processor optimizations"
TUNECONFLICTS[dbfp4] = "m32 mx32"
TUNE_ARCH .= "${@bb.utils.contains("TUNE_FEATURES", "dbfp4", "${X86ARCH64}", "" ,d)}"
TUNE_CCARGS .= "${@bb.utils.contains("TUNE_FEATURES", "dbfp4", " -march=bdver4", "", d)}"

# Extra tune selections
AVAILTUNES += "dbfp4"
TUNE_FEATURES_tune-dbfp4 = "dbfp4"
BASE_LIB_tune-dbfp4 = "lib64"
TUNE_PKGARCH_tune-dbfp4 = "dbfp4"
PACKAGE_EXTRA_ARCHS_tune-dbfp4 = "${TUNE_PKGARCH_tune-dbfp4}"
