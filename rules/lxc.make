# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Grzeschik <mgr@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LXC) += lxc

#
# Paths and names
#
LXC_VERSION	:= 6.0.6
LXC_SHA256	:= b0ba4537258d2b848fd07dedb1044dab132de3fb3f1976d240da40a7dee1b8cf
LXC		:= lxc-$(LXC_VERSION)
LXC_SUFFIX	:= tar.gz
LXC_URL		:= https://linuxcontainers.org/downloads/lxc/$(LXC).$(LXC_SUFFIX)
LXC_SOURCE	:= $(SRCDIR)/$(LXC).$(LXC_SUFFIX)
LXC_DIR		:= $(BUILDDIR)/$(LXC)
LXC_LICENSE	:= LGPL-2.1-or-later AND GPL-2.0-only
LXC_LICENSE_FILES := \
	file://COPYING;md5=4b6551da9cb7d5b3017d1c0a3e31469b \
	file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c \
	file://LICENSE.GPL2;md5=751419260aa954499f7abaabaa882bbe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# distrosysconfdir is pinned: when empty, meson picks sysconfig or default
# from the build host's /etc.
LXC_CONF_TOOL	:= meson
LXC_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dapi-docs=false \
	-Dapparmor=false \
	-Dapparmor-cache-path=cache/lxc/apparmor \
	-Dcapabilities=true \
	-Dcgroup-pattern= \
	-Dcommands=true \
	-Dcoverity-build=false \
	-Ddata-path=lib/lxc \
	-Ddbus=false \
	-Ddistrosysconfdir=default \
	-Ddoc-path=doc/lxc \
	-Dexamples=false \
	-Dglobal-config-path=lxc \
	-Dinit-script=$(call ptx/ifdef,PTXCONF_LXC_SYSTEMD_UNIT,systemd,[]) \
	-Dinstall-init-files=true \
	-Dinstall-state-dirs=true \
	-Dio-uring-event-loop=false \
	-Dlog-path=log/lxc \
	-Dman=false \
	-Dmemfd-rexec=true \
	-Dopenssl=false \
	-Doss-fuzz=false \
	-Dpam-cgroup=false \
	-Drootfs-mount-path=lxc/rootfs \
	-Druntime-path=/run \
	-Dseccomp=true \
	-Dselinux=$(call ptx/truefalse,PTXCONF_GLOBAL_SELINUX) \
	-Dspecfile=false \
	-Dsystemd-unitdir=/usr/lib/systemd/system \
	-Dtests=$(call ptx/truefalse,PTXCONF_LXC_TEST_TOOLS) \
	-Dthread-safety=true \
	-Dtools=true \
	-Dtools-multicall=false \
	-Dusernet-config-path=lxc/lxc-usernet \
	-Dusernet-db-path=lxc/nics

LXC_APPLICATIONS := \
	copy \
	cgroup \
	create \
	snapshot \
	freeze \
	config \
	monitor \
	unfreeze \
	device \
	destroy \
	ls \
	console \
	wait \
	execute \
	update-config \
	stop \
	checkconfig \
	checkpoint \
	usernsexec \
	attach \
	start \
	top \
	info \
	autostart \
	unshare

ifdef PTXCONF_LXC_TEST_TOOLS
LXC_TEST_TOOLS := \
	api-reboot \
	apparmor \
	apparmor-generated \
	apparmor-mount \
	arch-parse \
	attach \
	automount \
	autostart \
	basic \
	capabilities \
	cgpath \
	checkpoint-restore \
	cloneconfig \
	clonetest \
	concurrent \
	config-jump-table \
	console \
	console-log \
	containertests \
	createconfig \
	createtest \
	criu-check-feature \
	cve-2019-5736 \
	destroytest \
	device-add-remove \
	exit-code \
	get_item \
	getkeys \
	list \
	locktests \
	lxc-attach \
	lxcpath \
	may-control \
	mount-injection \
	no-new-privs \
	parse-config-file \
	proc-pid \
	procsys \
	raw-clone \
	reboot \
	rootfs \
	rootfs-options \
	saveconfig \
	share-ns \
	shortlived \
	shutdowntest \
	snapdeps \
	snapshot \
	startone \
	state-server \
	symlink \
	sysctls \
	sys-mixed \
	unpriv \
	usernic \
	usernsexec \
	utils
endif

LXC_LIBEXEC_APPS := \
	containers \
	monitord \
	net \
	user-nic

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lxc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lxc)
	@$(call install_fixup, lxc, PRIORITY, optional)
	@$(call install_fixup, lxc, SECTION, base)
	@$(call install_fixup, lxc, AUTHOR, "Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, lxc, DESCRIPTION, missing)

	@$(call install_lib, lxc, 0, 0, 0644, liblxc)

	@$(call install_copy, lxc, 0, 0, 0755, -, /usr/sbin/init.lxc)

	@$(call install_copy, lxc, 0, 0, 0755, /var/lib/lxc)
	@$(call install_copy, lxc, 0, 0, 0755, /usr/lib/lxc/rootfs)

	@$(call install_tree, lxc, 0, 0, -, /usr/share/lxc/config)

ifdef PTXCONF_GLOBAL_SELINUX
	@$(call install_tree, lxc, 0, 0, -, /usr/share/lxc/selinux)
endif

	@$(call install_alternative, lxc, 0, 0, 0644, /etc/lxc/default.conf)
	@$(call install_alternative, lxc, 0, 0, 0644, /etc/default/lxc-net)

	@$(call install_copy, lxc, 0, 0, 0644, -, /etc/default/lxc)

	@$(foreach app, $(LXC_APPLICATIONS), \
		$(call install_copy, lxc, 0, 0, 0755, -, \
			/usr/bin/lxc-$(app))$(ptx/nl))

	@$(foreach app, $(LXC_LIBEXEC_APPS), \
		$(call install_copy, lxc, 0, 0, 0755, -, \
			/usr/libexec/lxc/lxc-$(app))$(ptx/nl))

ifdef PTXCONF_LXC_TEST_TOOLS
	@$(foreach app, $(LXC_TEST_TOOLS), \
		$(call install_copy, lxc, 0, 0, 0755, \
			$(LXC_PKGDIR)/usr/bin/lxc-test-$(app), \
			/usr/bin/lxc-tests/$(app))$(ptx/nl))
endif

ifdef PTXCONF_LXC_SYSTEMD_UNIT
	@$(call install_copy, lxc, 0, 0, 0644, -, \
		/usr/lib/systemd/system/lxc.service)
	@$(call install_copy, lxc, 0, 0, 0644, -, \
		/usr/lib/systemd/system/lxc@.service)
	@$(call install_copy, lxc, 0, 0, 0644, -, \
		/usr/lib/systemd/system/lxc-net.service)

	@$(call install_link, lxc, ../lxc.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lxc.service)
	@$(call install_link, lxc, ../lxc@.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lxc@.service)
	@$(call install_link, lxc, ../lxc-net.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lxc-net.service)
endif

	@$(call install_finish, lxc)

	@$(call touch)

# vim: syntax=make
