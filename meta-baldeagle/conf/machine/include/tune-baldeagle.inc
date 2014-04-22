DEFAULTTUNE ?= "core2-64"
require conf/machine/include/tune-core2.inc
include conf/machine/include/x86-base.inc
TUNE_CCARGS .= " -march=bdver3"
