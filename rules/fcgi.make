# -*-makefile-*-
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FCGI) += fcgi

#
# Paths and names
#
FCGI_VERSION		:= 2.4.6
FCGI_MD5		:= 4a5ef95d55d0a372967f86f56b3ad7c0
FCGI			:= fcgi-$(FCGI_VERSION)
FCGI_SUFFIX		:= tar.gz
FCGI_URL		:= https://github.com/FastCGI-Archives/fcgi2/archive/$(FCGI_VERSION).$(FCGI_SUFFIX)
FCGI_SOURCE		:= $(SRCDIR)/$(FCGI).$(FCGI_SUFFIX)
FCGI_DIR		:= $(BUILDDIR)/$(FCGI)
FCGI_LICENSE		:= OML
FCGI_LICENSE_FILES	:= file://LICENSE;md5=e3aacac3a647af6e7e31f181cda0a06a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FCGI_CONF_TOOL	:= autoconf
FCGI_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fcgi.targetinstall:
	@$(call targetinfo)
	@$(call install_init, fcgi)
	@$(call install_fixup, fcgi,PRIORITY,optional)
	@$(call install_fixup, fcgi,SECTION,base)
	@$(call install_fixup, fcgi,AUTHOR,"Daniel Schnell <danielsch@marel.com>")
	@$(call install_fixup, fcgi,DESCRIPTION,missing)

	@$(call install_copy, fcgi, 0, 0, 0755, -, /usr/bin/cgi-fcgi)
	@$(call install_lib, fcgi, 0, 0, 0644, libfcgi)
	@$(call install_lib, fcgi, 0, 0, 0644, libfcgi++)

	@$(call install_finish, fcgi)
	@$(call touch)

# vim: syntax=make
