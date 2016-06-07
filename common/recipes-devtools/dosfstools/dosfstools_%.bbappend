FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " \
                      file://0001-Disable-iconv-conversion.patch \
"
