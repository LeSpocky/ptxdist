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
PACKAGES-$(PTXCONF_INITMETHOD_SYSTEMD) += initmethod-systemd

INITMETHOD_SYSTEMD_VERSION	:= 1.0.0
INITMETHOD_SYSTEMD_LICENSE	:= ignore

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initmethod-systemd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, initmethod-systemd)
	@$(call install_fixup,initmethod-systemd,PRIORITY,optional)
	@$(call install_fixup,initmethod-systemd,SECTION,base)
	@$(call install_fixup,initmethod-systemd,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,initmethod-systemd,DESCRIPTION,missing)

	@$(call install_alternative, initmethod-systemd, 0, 0, 0755, /usr/lib/init/initmethod-bbinit-functions.sh)

ifdef PTXCONF_INITMETHOD_SYSTEMD_IFUPDOWN
	@$(call install_alternative, initmethod-systemd, 0, 0, 0755, \
		/usr/lib/systemd/ifupdown-prepare)
	@$(call install_alternative, initmethod-systemd, 0, 0, 0644, \
		/usr/lib/systemd/system/ifupdown-prepare.service)
	@$(call install_link, initmethod-systemd, ../ifupdown-prepare.service, \
		/usr/lib/systemd/system/ifupdown.service.wants/ifupdown-prepare.service)

	@$(call install_alternative, initmethod-systemd, 0, 0, 0644, \
		/usr/lib/systemd/system/ifupdown.service)
	@$(call install_link, initmethod-systemd, ../ifupdown.service, \
		/usr/lib/systemd/system/network.target.wants/ifupdown.service)

	@$(call install_link, initmethod-systemd, ../network.target, \
		/usr/lib/systemd/system/multi-user.target.wants/network.target)

	@$(call install_alternative, initmethod-systemd, 0, 0, 0644, /etc/network/interfaces)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-down.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-up.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-pre-down.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-post-down.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-pre-up.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-post-up.d)
endif

	@$(call install_finish,initmethod-systemd)

	@$(call touch)

# vim: syntax=make
