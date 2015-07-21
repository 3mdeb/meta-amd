FILESEXTRAPATHS_prepend_amdfalconx86 := "${THISDIR}/${PN}:"

SRC_URI_amdfalconx86 = " \
	    git://anongit.freedesktop.org/xorg/driver/glamor;branch=master \
"

SRCREV_amdfalconx86 = "347ef4f01edba49820eefaf4b25522fc260d118c"
PV_amdfalconx86 = "0.6.0+git${SRCPV}"

S_amdfalconx86 = "${WORKDIR}/git"

DEPENDS_append_amdfalconx86 = " libepoxy "
