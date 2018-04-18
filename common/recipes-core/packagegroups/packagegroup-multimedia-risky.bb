DESCRIPTION = "AMD risky multimedia packages"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r0"

inherit packagegroup

RDEPENDS_${PN} += "\
    libfaad \
    libid3tag \
    gstreamer1.0-plugins-bad-meta \
    gstreamer1.0-plugins-ugly-meta \
    gstreamer1.0-libav \
"
