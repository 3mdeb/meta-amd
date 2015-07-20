DEPENDS_append_amd = " python3-native"

do_compile_prepend_amd() {
    # Make sure we can find python3
    export PATH="${PATH}:${STAGING_BINDIR_NATIVE}/python3-native"
}

do_install_append_amd() {
    [ -e ${D}/usr/lib ] && rmdir ${D}/usr/lib
}

# Clear PNBLACKLIST conditionally for AMD.
# Suffix overrides and flags don't work well together.
# Anonymous python would be less convoluted but that appears
# to be too late in the parsing process to do what we need.
OVERRIDES_LIST := "${@MACHINEOVERRIDES.replace(':', ' ')}"
UPSTREAM_BLACKLIST_VALUE := "${@d.getVarFlag('PNBLACKLIST', 'mplayer2', False)}"
PNBLACKLIST[mplayer2] = "${@bb.utils.contains('OVERRIDES_LIST', 'amd', '', '${UPSTREAM_BLACKLIST_VALUE}', d)}"

#
# mplayer has broken auto-tools scripts for
# configuration which do not allow out-of-tree building
#
inherit autotools-brokensep
