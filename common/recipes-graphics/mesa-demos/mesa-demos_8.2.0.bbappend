FILESEXTRAPATHS_prepend_amd := "${THISDIR}/${PN}_${PV}:"

SRC_URI_append_amd = "\
			file://0010-sharedtex_mt-fix-rendering-thread-hang.patch \
"
