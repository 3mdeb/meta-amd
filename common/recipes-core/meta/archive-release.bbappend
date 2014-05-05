IMAGE_EXTENSION_live := "${@oe_filter_out('iso', '${IMAGE_EXTENSION_live}', d)}"

prepare_templates_append() {
    sed -i 's,^\(EXTERNAL_TOOLCHAIN ?= \"\$\)\({MELDIR}/../..\)",\1\2/codebench-lite",' local.conf.sample
}
