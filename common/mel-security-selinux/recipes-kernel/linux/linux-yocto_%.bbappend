FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://enable-selinux-support.cfg \
            file://enable-audit-support.cfg"
