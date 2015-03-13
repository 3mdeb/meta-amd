RRECOMMENDS_${PN}_remove_amd := " \
    ${@bb.utils.contains("DISTRO", "mel", "", "perf kernel-module-oprofile", d)} \
"

PROFILETOOLS_remove_amd := " \
    ${@bb.utils.contains("DISTRO", "mel", "", "oprofile oprofileui-server", d)} \
"
