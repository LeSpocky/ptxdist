# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/image-fit/env/impl = \
	$(call world/image/env, $(1))					\
	$(CODE_SIGNING_ENV)						\
	image_sign_role="$(call ptx/escape,$($(1)_SIGN_ROLE))"		\
	image_key_name_hint="$(call ptx/escape,$($(1)_KEY_NAME_HINT))"	\
	image_kernel="$(call ptx/escape,$($(1)_KERNEL))"		\
	image_initramfs="$(call ptx/escape,$($(1)_INITRAMFS))"		\
	image_dtb="$(call ptx/escape,$($(1)_DTB))"

world/image-fit/env = \
	$(call world/image-fit/env/impl,$(strip $(1)))

world/image-fit = \
	$(call world/image-fit/env, $(1)) \
	ptxd_make_image_fit

# vim: syntax=make
