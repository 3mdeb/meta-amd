FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
inherit kernel-openssl
SRC_URI_append_snowyowl = " file://0001-Update-kvm-instrumentation-for-4.15.patch \
                            file://0002-Fix-kvm-instrumentation-for-4.15.patch \
                            file://0003-Update-kvm-instrumentation-for-3.16.52-and-3.2.97.patch \
                            file://0004-Update-kvm-instrumentation-for-4.14.14-4.9.77-4.4.11.patch \
                            file://0001-kvm.h-workaround-kernel-version-issues.patch"
