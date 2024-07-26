# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_V4L_UTILS) += v4l-utils

#
# Paths and names
#
V4L_UTILS_VERSION	:= 1.28.1
V4L_UTILS_MD5		:= 6716de513a1fd2e1edb404a46a455855
V4L_UTILS		:= v4l-utils-$(V4L_UTILS_VERSION)
V4L_UTILS_SUFFIX	:= tar.xz
V4L_UTILS_URL		:= http://linuxtv.org/downloads/v4l-utils/$(V4L_UTILS).$(V4L_UTILS_SUFFIX)
V4L_UTILS_SOURCE	:= $(SRCDIR)/$(V4L_UTILS).$(V4L_UTILS_SUFFIX)
V4L_UTILS_DIR		:= $(BUILDDIR)/$(V4L_UTILS)
V4L_UTILS_LICENSE	:= GPL-2.0-or-later (tools); LGPL-2.1-or-later (libs)
V4L_UTILS_LICENSE_FILES	:= \
	file://COPYING;md5=48da9957849056017dc568bbc43d8975 \
	file://COPYING.libdvbv5;md5=28fb0f8e5cecc8a7a1a88008019dc3d0 \
	file://COPYING.libv4l;md5=d749e86a105281d7a44c2328acebc4b0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

V4L_UTILS_CONF_TOOL	:= meson
V4L_UTILS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbpf=disabled \
	-Ddocdir= \
	-Ddoxygen-doc=disabled \
	-Ddoxygen-html=false \
	-Ddoxygen-man=false \
	-Dgconv=disabled \
	-Dgconvsysdir= \
	-Djpeg=$(call ptx/endis, PTXCONF_V4L_UTILS_LIBV4LCONVERT)d \
	-Dlibdvbv5=disabled \
	-Dlibv4l1subdir=libv4l \
	-Dlibv4l2subdir=libv4l \
	-Dlibv4lconvertsubdir=libv4l \
	-Dqv4l2=disabled \
	-Dqvidcap=disabled \
	-Dsystemdsystemunitdir=/usr/lib/systemd/system \
	-Dudevdir=/usr/lib/udev \
	-Dv4l-plugins=true \
	-Dv4l-utils=true \
	-Dv4l-wrappers=$(call ptx/truefalse, PTXCONF_V4L_UTILS_V4L2CONVERT) \
	-Dv4l2-compliance-32=false \
	-Dv4l2-compliance-libv4l=true \
	-Dv4l2-ctl-32=false \
	-Dv4l2-ctl-libv4l=true \
	-Dv4l2-ctl-stream-to=true \
	-Dv4l2-tracer=$(call ptx/endis, PTXCONF_V4L_UTILS_TRACER)d

ifdef PTXCONF_KERNEL_HEADER
V4L_UTILS_CPPFLAGS	:= \
	-isystem $(KERNEL_HEADERS_INCLUDE_DIR)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/v4l-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, v4l-utils)
	@$(call install_fixup, v4l-utils,PRIORITY,optional)
	@$(call install_fixup, v4l-utils,SECTION,base)
	@$(call install_fixup, v4l-utils,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, v4l-utils,DESCRIPTION,missing)

ifdef PTXCONF_V4L_UTILS_LIBV4L1
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l1)
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l/v4l1compat)
endif
ifdef PTXCONF_V4L_UTILS_LIBV4L2
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l2)
ifdef PTXCONF_V4L_UTILS_V4L2CONVERT
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l/v4l2convert)
endif
endif
ifdef PTXCONF_V4L_UTILS_LIBV4LCONVERT
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4lconvert)
endif
ifdef PTXCONF_V4L_UTILS_CECCOMPLIANCE
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cec-compliance)
endif
ifdef PTXCONF_V4L_UTILS_CECCTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cec-ctl)
endif
ifdef PTXCONF_V4L_UTILS_CECFOLLOWER
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cec-follower)
endif
ifdef PTXCONF_V4L_UTILS_CX18CTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cx18-ctl)
endif
ifdef PTXCONF_V4L_UTILS_DECODETM6000
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/decode_tm6000)
endif
ifdef PTXCONF_V4L_UTILS_IRCTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/ir-ctl)
endif
ifdef PTXCONF_V4L_UTILS_IRKEYTABLE
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/ir-keytable)
endif
ifdef PTXCONF_V4L_UTILS_IVTVCTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/ivtv-ctl)
endif
ifdef PTXCONF_V4L_UTILS_MEDIACTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/media-ctl)
endif
ifdef PTXCONF_V4L_UTILS_RDSCTL
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l2rds)
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/rds-ctl)
endif
ifdef PTXCONF_V4L_UTILS_V4L2COMPLIANCE
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/v4l2-compliance)
endif
ifdef PTXCONF_V4L_UTILS_V4L2DBG
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/sbin/v4l2-dbg)
endif
ifdef PTXCONF_V4L_UTILS_V4L2CTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/v4l2-ctl)
endif
ifdef PTXCONF_V4L_UTILS_V4L2SYSFSPATH
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/v4l2-sysfs-path)
endif
ifdef PTXCONF_V4L_UTILS_TRACER
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/v4l2-tracer)
endif
	@$(call install_finish, v4l-utils)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/v4l-utils.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, V4L_UTILS)

# vim: syntax=make
