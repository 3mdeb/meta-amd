RDEPENDS_${PN}-apps_remove_amd := "${@bb.utils.contains("DISTRO", "mel", "", "gaku", d)}"
