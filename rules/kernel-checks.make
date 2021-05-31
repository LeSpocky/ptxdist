# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_KERNEL

ifeq ($(PTXCONF_KERNEL_VERSION),)
$(call ptx/error, PTXCONF_KERNEL_VERSION is empty)
$(call ptx/error, please run 'ptxdist platformconfig' and activate the kernel)
endif

endif	# PTXCONF_KERNEL

# vim: syntax=make
