python __anonymous () {
    if d.getVar("DISTRO", True) == "mel-lite":
        # Remove gaku from the apps as it depends
        # on gstreamer which is currently unsupported
        # in MEL Lite.
        rdepvar = "RDEPENDS_%s-apps" % (d.getVar("PN", True))
        rdep = d.getVar(rdepvar, True)
        d.setVar(rdepvar, rdep.replace("gaku", ""))
}
