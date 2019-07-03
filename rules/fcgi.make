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
FCGI_VERSION    	:= 2.4.0
FCGI_MD5		:= d15060a813b91383a9f3c66faf84867e
FCGI			:= fcgi-$(FCGI_VERSION)
FCGI_SUFFIX		:= tar.gz
FCGI_URL		:= https://sourceforge.net/projects/slackbuildsdirectlinks/files/fcgi/$(FCGI).$(FCGI_SUFFIX)
FCGI_SOURCE		:= $(SRCDIR)/$(FCGI).$(FCGI_SUFFIX)
FCGI_DIR		:= $(BUILDDIR)/$(FCGI)
FCGI_LICENSE		:= OML
FCGI_LICENSE_FILES	:= file://LICENSE.TERMS;md5=e3aacac3a647af6e7e31f181cda0a06a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FCGI_AUTOCONF := $(CROSS_AUTOCONF_USR)

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
