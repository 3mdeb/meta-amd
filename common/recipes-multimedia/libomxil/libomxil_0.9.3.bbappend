RDEPENDS_${PN}_append_baldeagle = "libomx-mesa"
RDEPENDS_${PN}_append_steppeeagle = "libomx-mesa"

#
# This package should not have commercial license flags.
# There is discussion in the OE community about fixing this
# but in the meantime we'll explicitly remove it here.
#
LICENSE_FLAGS := "${@oe_filter_out('commercial', '${LICENSE_FLAGS}', d)}"
