# -*-makefile-*-
#
# Copyright (C) 2023 by Ian Abbott <abbotti@mev.co.uk>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PROTOBUF_C) += host-protobuf-c

#
# autoconf
#
HOST_PROTOBUF_C_CONF_TOOL	:= autoconf
HOST_PROTOBUF_C_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static

# vim: syntax=make
