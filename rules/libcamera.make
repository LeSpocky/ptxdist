# -*-makefile-*-
#
# Copyright (C) 2022 by Matthias Fend <matthias.fend@emfend.at>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCAMERA) += libcamera

#
# Paths and names
#
LIBCAMERA_VERSION	:= 0.2.0
LIBCAMERA_MD5		:= 08f0681221c654838e54e6b3a32f89b5
LIBCAMERA		:= libcamera-$(LIBCAMERA_VERSION)
LIBCAMERA_SUFFIX	:= tar.gz
LIBCAMERA_URL		:= https://gitlab.freedesktop.org/camera/libcamera/-/archive/v$(LIBCAMERA_VERSION)/$(LIBCAMERA).$(LIBCAMERA_SUFFIX)
LIBCAMERA_SOURCE	:= $(SRCDIR)/$(LIBCAMERA).$(LIBCAMERA_SUFFIX)
LIBCAMERA_DIR		:= $(BUILDDIR)/$(LIBCAMERA)
LIBCAMERA_LICENSE	:= Apache-2.0 AND \
			   BSD-2-Clause AND BSD-3-Clause AND \
			   CC0-1.0 AND CC-BY-SA-4.0 AND \
			   GPL-2.0-or-later AND GPL-2.0 WITH Linux-syscall-note AND \
			   (GPL-2.0-or-later WITH Linux-syscall-note OR MIT) AND LGPL-2.1-or-later
LIBCAMERA_LICENSE_FILES	:= file://LICENSES/Apache-2.0.txt;md5=3b83ef96387f14655fc854ddc3c6bd57 \
			   file://LICENSES/BSD-2-Clause.txt;md5=63d6ee386b8aaba70b1bf15a79ca50f2 \
			   file://LICENSES/BSD-3-Clause.txt;md5=954f4d71a37096249f837652a7f586c0 \
			   file://LICENSES/CC0-1.0.txt;md5=6fd064768b8d61c31ddd0540570fbd33 \
			   file://LICENSES/CC-BY-SA-4.0.txt;md5=598a2bb2d212cf9bc240fb554efcb169 \
			   file://LICENSES/GPL-2.0-or-later.txt;md5=fed54355545ffd980b814dab4a3b312c \
			   file://LICENSES/GPL-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
			   file://LICENSES/Linux-syscall-note.txt;md5=370f20aa0795bf47c9a50d8cee5a7cfb \
			   file://LICENSES/GPL-2.0+.txt;md5=fed54355545ffd980b814dab4a3b312c \
			   file://LICENSES/MIT.txt;md5=38aa75cf4c4c87f018227d5ec9638d75 \
			   file://LICENSES/LGPL-2.1-or-later.txt;md5=2a4f4fd2128ea2f65047ee63fbca9f68

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCAMERA_IPAS-y					:=
LIBCAMERA_IPAS-$(PTXCONF_LIBCAMERA_IPA_IPU3)		+= ipu3
LIBCAMERA_IPASC-$(PTXCONF_LIBCAMERA_IPA_RASPBERRYPI)	+= rpi/vc4
LIBCAMERA_IPASM-$(PTXCONF_LIBCAMERA_IPA_RASPBERRYPI)	+= rpi_vc4
LIBCAMERA_IPAS-$(PTXCONF_LIBCAMERA_IPA_RKISP1)		+= rkisp1
LIBCAMERA_IPAS-$(PTXCONF_LIBCAMERA_IPA_VIMC)		+= vimc

LIBCAMERA_IPASC-y	+= $(LIBCAMERA_IPAS-y)
LIBCAMERA_IPASM-y	+= $(LIBCAMERA_IPAS-y)

LIBCAMERA_PIPELINES-y						:=
LIBCAMERA_PIPELINES-$(PTXCONF_LIBCAMERA_PIPELINE_IMX8ISI)	+= imx8-isi
LIBCAMERA_PIPELINES-$(PTXCONF_LIBCAMERA_PIPELINE_IPU3)		+= ipu3
LIBCAMERA_PIPELINES-$(PTXCONF_LIBCAMERA_PIPELINE_RASPBERRYPI)	+= rpi/vc4
LIBCAMERA_PIPELINES-$(PTXCONF_LIBCAMERA_PIPELINE_RKISP1)	+= rkisp1
LIBCAMERA_PIPELINES-$(PTXCONF_LIBCAMERA_PIPELINE_SIMPLE)	+= simple
LIBCAMERA_PIPELINES-$(PTXCONF_LIBCAMERA_PIPELINE_UVCVIDEO)	+= uvcvideo
LIBCAMERA_PIPELINES-$(PTXCONF_LIBCAMERA_PIPELINE_VIMC)		+= vimc

LIBCAMERA_IPA_PROXIES-y						:=
LIBCAMERA_IPA_PROXIES-$(PTXCONF_LIBCAMERA_PIPELINE_IPU3)	+= ipu3
LIBCAMERA_IPA_PROXIES-$(PTXCONF_LIBCAMERA_PIPELINE_RASPBERRYPI)	+= raspberrypi
LIBCAMERA_IPA_PROXIES-$(PTXCONF_LIBCAMERA_PIPELINE_RKISP1)	+= rkisp1
LIBCAMERA_IPA_PROXIES-$(PTXCONF_LIBCAMERA_PIPELINE_VIMC)	+= vimc

LIBCAMERA_CONF_TOOL	:= meson
LIBCAMERA_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dandroid=disabled \
	-Dcam=$(call ptx/endis,PTXCONF_LIBCAMERA_CAM)d \
	-Ddocumentation=disabled \
	-Dgstreamer=$(call ptx/endis,PTXCONF_LIBCAMERA_GSTREAMER)d \
	-Dipas=$(subst $(ptx/def/space),$(ptx/def/comma),$(strip $(LIBCAMERA_IPASC-y))) \
	-Dlc-compliance=disabled \
	-Dpipelines=$(subst $(ptx/def/space),$(ptx/def/comma),$(strip $(LIBCAMERA_PIPELINES-y))) \
	-Dpycamera=disabled \
	-Dqcam=$(call ptx/endis,PTXCONF_LIBCAMERA_QCAM)d \
	-Dtest=false \
	-Dtracing=disabled \
	-Dudev=enabled \
	-Dv4l2=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

define install_ipa_proxy
	@$(call install_copy, libcamera, 0, 0, 0755, -, \
		/usr/libexec/libcamera/$(strip $(1))_ipa_proxy)
endef

define install_ipa
	@$(call install_alternative_tree, libcamera, 0, 0, \
		/usr/share/libcamera/ipa/$(strip $(1)))
endef

define install_ipa_module_signed
	# The IPA modules must not be stripped, otherwise the associated
	# signatures will no longer be valid.
	@$(call install_copy, libcamera, 0, 0, 0644, -, \
		/usr/lib/libcamera/ipa_$(strip $(1)).so, n)
	@$(call install_copy, libcamera, 0, 0, 0644, -, \
		/usr/lib/libcamera/ipa_$(strip $(1)).so.sign)
endef

define install_ipa_module
	@$(call install_copy, libcamera, 0, 0, 0644, -, \
		/usr/lib/libcamera/ipa_$(strip $(1)).so)
endef

$(STATEDIR)/libcamera.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcamera)
	@$(call install_fixup, libcamera, PRIORITY, optional)
	@$(call install_fixup, libcamera, SECTION, base)
	@$(call install_fixup, libcamera, AUTHOR, "Matthias Fend <matthias.fend@emfend.at>")
	@$(call install_fixup, libcamera, DESCRIPTION, missing)

	@$(call install_lib, libcamera, 0, 0, 0644, libcamera)
	@$(call install_lib, libcamera, 0, 0, 0644, libcamera-base)

	@$(foreach proxy,$(LIBCAMERA_IPA_PROXIES-y), \
		$(call install_ipa_proxy, $(proxy))$(ptx/nl))

	@$(foreach ipa,$(LIBCAMERA_IPASC-y), \
		$(call install_ipa, $(ipa))$(ptx/nl))

ifdef PTXCONF_LIBCAMERA_IPA_MODULE_SIGN
	@$(foreach ipa_module,$(LIBCAMERA_IPASM-y), \
		$(call install_ipa_module_signed, $(ipa_module))$(ptx/nl))
else
	@$(foreach ipa_module,$(LIBCAMERA_IPASM-y), \
		$(call install_ipa_module, $(ipa_module))$(ptx/nl))
endif

ifdef PTXCONF_LIBCAMERA_GSTREAMER
	@$(call install_lib, libcamera, 0, 0, 0644, gstreamer-1.0/libgstlibcamera)
endif

ifdef PTXCONF_LIBCAMERA_CAM
	@$(call install_copy, libcamera, 0, 0, 0755, -, /usr/bin/cam)
endif

ifdef PTXCONF_LIBCAMERA_QCAM
	@$(call install_copy, libcamera, 0, 0, 0755, -, /usr/bin/qcam)
endif

	@$(call install_finish, libcamera)

	@$(call touch)

# vim: syntax=make
