FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Add keyring fix to all that are not mel or mel-lite
SRC_URI += "${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", "file://kernel-keyring-CVE-2016-0728.patch", d)}"

#
# Work around race in linux-yocto recipe for archive files.
# This is fixed properly in the master branch with:
#     http://patchwork.openembedded.org/patch/107179/
#
python do_ar_patched_prepend() {
    bb.utils.mkdirhier("${STAGING_KERNEL_BUILDDIR}")
    bb.utils.mkdirhier("${STAGING_KERNEL_DIR}")
}
