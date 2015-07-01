DEPENDS_append_amd = " python3-native"

do_compile_prepend_amd() {
    # Make sure we can find python3
    export PATH="${PATH}:${STAGING_BINDIR_NATIVE}/python3-native"
}

do_install_append_amd() {
    [ -e ${D}/usr/lib ] && rmdir ${D}/usr/lib
}

PNBLACKLIST_amd[mplayer2] = ""

#
# mplayer has broken auto-tools scripts for
# configuration which do not allow out-of-tree building
#
inherit autotools-brokensep
