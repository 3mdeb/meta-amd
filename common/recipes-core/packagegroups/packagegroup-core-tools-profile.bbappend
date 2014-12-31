RRECOMMENDS_${PN}_remove_amd := " \
    ${@base_contains("DISTRO", "mel-lite", "perf", "", d)} \
"
