FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

OPENSSL_CVE = " \
    file://0001_SSLv2_doesnot_block_disabled_ciphers_CVE-2016-0701.patch \
    file://0002_SSLv2_doesnot_block_disabled_ciphers_CVE-2016-0701.patch \
    file://DH_small_subgroups_CVE-2015-3197.patch \
"

# Add CVE fix to all that are not mel
SRC_URI += "${@bb.utils.contains("DISTRO", "mel", "", "${OPENSSL_CVE}", d)}"
