RRECOMMENDS_${PN}_remove_amd := " \
    ${@base_contains("DISTRO", "mel", "", "perf kernel-module-oprofile", d)} \
"

PROFILETOOLS_remove_amd := " \
    ${@base_contains("DISTRO", "mel", "", "oprofile oprofileui-server", d)} \
"
