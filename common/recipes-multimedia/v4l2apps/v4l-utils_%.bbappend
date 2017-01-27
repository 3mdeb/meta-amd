DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'virtual/libgl libglu', '', d)}"
