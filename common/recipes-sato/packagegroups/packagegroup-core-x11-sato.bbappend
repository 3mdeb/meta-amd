RDEPENDS_${PN}-apps_remove := "${@base_contains("DISTRO", "mel", "", "gaku", d)}"
