FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_amd = " file://disable-so-versioning.patch"

#
# The .so files populated by libomxil are not intended to be versioned and symlinked.
# Make sure they get packaged in the main package.
#
# Reorder the PACKAGES variable so FILES_${PN} is filled before FILES_${PN}-dev.
# This has been fixed in a more robust fashion in poky/master.
#
PACKAGES_amd := "${@oe_filter_out('${PN}-dev', '${PACKAGES}', d)} ${PN}-dev"
FILES_${PN}_append_amd = " ${libdir}/bellagio/*.so"

RDEPENDS_${PN}_append_amd = "libomx-mesa"

#
# This package should not have commercial license flags.
# There is discussion in the OE community about fixing this
# but in the meantime we'll explicitly remove it here.
#
LICENSE_FLAGS_remove = "commercial"
