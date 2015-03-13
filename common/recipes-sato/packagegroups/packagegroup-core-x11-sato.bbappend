RDEPENDS_${PN}-apps_remove := "${@bb.utils.contains("DISTRO", "mel", "", "gaku", d)}"
