# Remove gaku from the apps as it depends 
# on gstreamer which is currently unsupported
python __anonymous () {
    rdepvar = "RDEPENDS_%s-apps" % (d.getVar("PN", True))
    rdep = d.getVar(rdepvar, True)
    d.setVar(rdepvar, rdep.replace("gaku", ""))
}
