#
# Work around race in linux-yocto recipe for archive files.
# This is fixed properly in the master branch with:
#     http://patchwork.openembedded.org/patch/107179/
#
python do_ar_patched_prepend() {
    bb.utils.mkdirhier("${STAGING_KERNEL_BUILDDIR}")
    bb.utils.mkdirhier("${STAGING_KERNEL_DIR}")
}
