DEFAULTTUNE ?= "znver1"

require conf/machine/include/x86/arch-x86.inc
require conf/machine/include/x86-base.inc


# AMD ZNVER1 64bit (Snowy Owl)
TUNEVALID[znver1] = "Enable AMD DB-FP4 (64 bit) specific processor optimizations"
TUNECONFLICTS[znver1] = "m32 mx32"
TUNE_ARCH .= "${@bb.utils.contains("TUNE_FEATURES", "znver1", "${X86ARCH64}", "" ,d)}"
TUNE_CCARGS .= "${@bb.utils.contains("TUNE_FEATURES", "znver1", " -march=znver1", "", d)}"

# Extra tune selections
AVAILTUNES += "znver1"
TUNE_FEATURES_tune-znver1 = "znver1"
BASE_LIB_tune-znver1 = "lib64"
TUNE_PKGARCH_tune-znver1 = "znver1"
PACKAGE_EXTRA_ARCHS_tune-znver1 = "${TUNE_PKGARCH_tune-znver1}"
