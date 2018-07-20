FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
inherit kernel-openssl
SRC_URI_append_snowyowl = " file://0001-kvm.h-workaround-kernel-version-issues.patch"
