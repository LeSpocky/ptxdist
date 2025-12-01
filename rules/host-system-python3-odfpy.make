# -*-makefile-*-
#
# Copyright (C) 2024 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_ODFPY) += host-system-python3-odfpy

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_ODFPY_VERSION	:= 1.4.1
HOST_SYSTEM_PYTHON3_ODFPY_MD5		:= d1a186ae75b2ae038a8aab1396444342
HOST_SYSTEM_PYTHON3_ODFPY		:= odfpy-$(HOST_SYSTEM_PYTHON3_ODFPY_VERSION)
HOST_SYSTEM_PYTHON3_ODFPY_SUFFIX	:= tar.gz
HOST_SYSTEM_PYTHON3_ODFPY_URL		:= $(call ptx/mirror-pypi, odfpy, $(HOST_SYSTEM_PYTHON3_ODFPY).$(HOST_SYSTEM_PYTHON3_ODFPY_SUFFIX))
HOST_SYSTEM_PYTHON3_ODFPY_SOURCE	:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_ODFPY).$(HOST_SYSTEM_PYTHON3_ODFPY_SUFFIX)
HOST_SYSTEM_PYTHON3_ODFPY_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_ODFPY)
HOST_SYSTEM_PYTHON3_ODFPY_LICENSE	:= GPL-2.0-or-later OR Apache-2.0
HOST_SYSTEM_PYTHON3_ODFPY_LICENSE_FILES	:= \
	file://README.md;startline=44;endline=59;md5=c8daa7bfd0c10a4e41706233c6a42f25 \
	file://APACHE-LICENSE-2.0.txt;md5=3b83ef96387f14655fc854ddc3c6bd57 \
	file://GPL-LICENSE-2.txt;md5=751419260aa954499f7abaabaa882bbe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_ODFPY_CONF_TOOL	:= python3

# vim: syntax=make
