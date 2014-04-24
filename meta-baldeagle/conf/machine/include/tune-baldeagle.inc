DEFAULTTUNE ?= "dbfp3"

require conf/machine/include/x86/arch-x86.inc
require conf/machine/include/x86-base.inc


# AMD DB-FP3 64bit (BaldEagle)
TUNEVALID[dbfp3] = "Enable AMD DB-FP3 (64 bit) specific processor optimizations"
TUNECONFLICTS[dbfp3] = "m32 mx32"
TUNE_ARCH .= "${@bb.utils.contains("TUNE_FEATURES", "dbfp3", "${X86ARCH64}", "" ,d)}"
TUNE_CCARGS .= "${@bb.utils.contains("TUNE_FEATURES", "dbfp3", " -march=bdver3", "", d)}"

# Extra tune selections
AVAILTUNES += "dbfp3"
TUNE_FEATURES_tune-dbfp3 = "dbfp3"
BASE_LIB_tune-dbfp3 = "lib64"
TUNE_PKGARCH_tune-dbfp3 = "dbfp3"
PACKAGE_EXTRA_ARCHS_tune-dbfp3 = "${TUNE_PKGARCH_tune-dbfp3}"
