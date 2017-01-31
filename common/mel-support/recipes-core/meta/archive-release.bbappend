IMAGE_EXTENSION_live_amd := "${@oe_filter_out('iso', '${IMAGE_EXTENSION_live}', d)}"
ARCHIVE_RELEASE_IMAGE_FSTYPES_EXCLUDE_amd = "iso"
