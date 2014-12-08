FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " \
     file://Update-compaction-instrumentation-to-3.12-kernel.patch \
"
