IMAGE_EXTENSION_live := "${@oe_filter_out('iso', '${IMAGE_EXTENSION_live}', d)}"
