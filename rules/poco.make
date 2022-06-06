# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POCO) += poco

#
# Paths and names
#
POCO_VERSION	:= 1.9.0
POCO_MD5	:= 9047586e0ba393bfeced96e3b7ae6286
POCO		:= poco-$(POCO_VERSION)
POCO_SUFFIX	:= tar.gz
POCO_URL	:= http://pocoproject.org/releases/$(POCO)/$(POCO)-all.$(POCO_SUFFIX)
POCO_SOURCE	:= $(SRCDIR)/$(POCO).$(POCO_SUFFIX)
POCO_DIR	:= $(call ptx/sh, readlink -f "$(BUILDDIR)/$(POCO)")
POCO_LICENSE	:= BSL-1.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POCO_LIBS-y					+= Foundation
POCO_LIBS-$(PTXCONF_POCO_ENCODINGS)		+= Encodings
POCO_LIBS-$(PTXCONF_POCO_XML)			+= XML
POCO_LIBS-$(PTXCONF_POCO_JSON)			+= JSON
POCO_LIBS-$(PTXCONF_POCO_UTIL)			+= Util
POCO_LIBS-$(PTXCONF_POCO_NET)			+= Net
POCO_LIBS-$(PTXCONF_POCO_NETSSL_OPENSSL)	+= NetSSL_OpenSSL
POCO_LIBS-$(PTXCONF_POCO_CRYPTO)		+= Crypto
POCO_LIBS-$(PTXCONF_POCO_DATA)			+= Data
POCO_LIBS-$(PTXCONF_POCO_DATA_SQLITE)		+= Data/SQLite
POCO_LIBS-$(PTXCONF_POCO_DATA_MYSQL)		+= Data/MySQL
POCO_LIBS-$(PTXCONF_POCO_ZIP)			+= Zip
POCO_LIBS-$(PTXCONF_POCO_MONGODB)		+= MongoDB
POCO_LIBS-$(PTXCONF_POCO_REDIS)			+= Redis

POCO_CONF_TOOL	:= cmake
POCO_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DENABLE_APACHECONNECTOR=OFF \
	-DENABLE_CPPPARSER=OFF \
	-DENABLE_CRYPTO=$(call ptx/onoff,PTXCONF_POCO_CRYPTO) \
	-DENABLE_DATA=$(call ptx/onoff,PTXCONF_POCO_DATA) \
	-DENABLE_DATA_MYSQL=$(call ptx/onoff,PTXCONF_POCO_DATA_MYSQL) \
	-DENABLE_DATA_ODBC=OFF \
	-DENABLE_DATA_SQLITE=$(call ptx/onoff,PTXCONF_POCO_DATA_SQLITE) \
	-DENABLE_ENCODINGS=$(call ptx/onoff,PTXCONF_POCO_ENCODINGS) \
	-DENABLE_ENCODINGS_COMPILER=OFF \
	-DENABLE_JSON=$(call ptx/onoff,PTXCONF_POCO_JSON) \
	-DENABLE_MONGODB=$(call ptx/onoff,PTXCONF_POCO_MONGODB) \
	-DENABLE_NET=$(call ptx/onoff,PTXCONF_POCO_NET) \
	-DENABLE_NETSSL=$(call ptx/onoff,PTXCONF_POCO_NETSSL_OPENSSL) \
	-DENABLE_NETSSL_WIN=OFF \
	-DENABLE_PAGECOMPILER=OFF \
	-DENABLE_PAGECOMPILER_FILE2PAGE=OFF \
	-DENABLE_PDF=OFF \
	-DENABLE_POCODOC=OFF \
	-DENABLE_REDIS=$(call ptx/onoff,PTXCONF_POCO_REDIS) \
	-DENABLE_SEVENZIP=OFF \
	-DENABLE_TESTS=OFF \
	-DENABLE_UTIL=$(call ptx/onoff,PTXCONF_POCO_UTIL) \
	-DENABLE_XML=$(call ptx/onoff,PTXCONF_POCO_XML) \
	-DENABLE_ZIP=$(call ptx/onoff,PTXCONF_POCO_ZIP) \
	-DFORCE_OPENSSL=OFF \
	-DPOCO_STATIC=OFF \
	-DPOCO_UNBUNDLED=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/poco.targetinstall:
	@$(call targetinfo)

	@$(call install_init, poco)
	@$(call install_fixup, poco,PRIORITY,optional)
	@$(call install_fixup, poco,SECTION,base)
	@$(call install_fixup, poco,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, poco,DESCRIPTION,missing)

	@$(foreach lib, $(POCO_LIBS-y), \
		$(call install_lib, poco, 0, 0, 0644, \
			libPoco$(subst /,,$(subst _OpenSSL,,$(lib))));)

	@$(call install_finish, poco)

	@$(call touch)

# vim: syntax=make
