FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://fix_output_redirection.patch \
            file://fix_regression_tests.patch"
