# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_TZ_DATABASE) += host-tz-database

#
# Paths and names
#
HOST_TZ_DATABASE	:= tz-database
HOST_TZ_DATABASE_DIR	:= $(HOST_BUILDDIR)/$(HOST_TZ_DATABASE)
HOST_TZ_DATABASE_VERSION:= 2020d

TZCODE_VERSION		:= $(HOST_TZ_DATABASE_VERSION)
TZCODE_MD5		:= b4c46a69e5894aac713e8365a9be9411
TZCODE			:= tzcode$(TZCODE_VERSION)
TZCODE_SUFFIX		:= tar.gz
TZCODE_URL		:= \
	http://www.iana.org/time-zones/repository/releases/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_SOURCE		:= $(SRCDIR)/$(TZCODE).$(TZCODE_SUFFIX)
$(TZCODE_SOURCE)	:= TZCODE
TZCODE_DIR		:= $(HOST_TZ_DATABASE_DIR)
TZCODE_STRIP_LEVEL	:= 0

TZDATA_VERSION		:= $(HOST_TZ_DATABASE_VERSION)
TZDATA_MD5		:= 2f58d72e31cf073f5076c2cbf182cba3
TZDATA			:= tzdata$(TZDATA_VERSION)
TZDATA_SUFFIX		:= tar.gz
TZDATA_URL		:= \
	http://www.iana.org/time-zones/repository/releases/$(TZDATA).$(TZDATA_SUFFIX)
TZDATA_SOURCE		:= $(SRCDIR)/$(TZDATA).$(TZDATA_SUFFIX)
$(TZDATA_SOURCE)	:= TZDATA
TZDATA_DIR		:= $(HOST_TZ_DATABASE_DIR)
TZDATA_STRIP_LEVEL	:= 0

HOST_TZ_DATABASE_SOURCES := $(TZCODE_SOURCE) $(TZDATA_SOURCE)
HOST_TZ_DATABASE_LICENSE := public_domain AND BSD-3-Clause
HOST_TZ_DATABASE_LICENSE_FILES := \
	file://LICENSE;md5=c679c9d6b02bc2757b3eaf8f53c43fba \
	file://date.c;startline=3;endline=28;md5=0b516100709f6de9dc65257bf91e6dd0

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-tz-database.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_TZ_DATABASE_DIR))
	@$(call extract, TZCODE)
	@$(call extract, TZDATA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TZ_DATABASE_PATH		:= PATH=$(HOST_PATH)
HOST_TZ_DATABASE_CONF_TOOL	:= NO
HOST_TZ_DATABASE_MAKE_OPT	:= \
	zic TZDIR=/usr/share/zoneinfo CFLAGS=-DSTD_INSPIRED
HOST_TZ_DATABASE_INSTALL_OPT	:= \
	posix_only TZDIR=/usr/share/zoneinfo

# vim: syntax=make
