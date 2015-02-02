RRECOMMENDS_${PN}_remove_amd := " \
    ${@base_contains("DISTRO", "mel-lite", "perf kernel-module-oprofile", "", d)} \
"

PROFILETOOLS_remove_amd := " \
    ${@base_contains("DISTRO", "mel-lite", "oprofile oprofileui-server", "", d)} \
"
