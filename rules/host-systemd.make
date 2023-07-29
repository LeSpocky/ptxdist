# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEMD) += host-systemd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEMD_CONF_TOOL	:= meson
# prefix=/usr is needed for systemd-hwdb to work correctly
HOST_SYSTEMD_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dprefix=/usr \
	-Dacl=false \
	-Dadm-group=true \
	-Danalyze=false \
	-Dapparmor=false \
	-Daudit=false \
	-Dbacklight=false \
	-Dbinfmt=false \
	-Dblkid=false \
	-Dbootloader=false \
	-Dbpf-framework=false \
	-Dbump-proc-sys-fs-file-max=true \
	-Dbump-proc-sys-fs-nr-open=true \
	-Dbzip2=false \
	-Dcompat-mutable-uid-boundaries=false \
	-Dcoredump=false \
	-Dcreate-log-dirs=false \
	-Dcryptolib=auto \
	-Ddbus=false \
	-Ddbuspolicydir=/usr/share/dbus-1/system.d \
	-Ddbussessionservicedir=/usr/share/dbus-1/services \
	-Ddbussystemservicedir=/usr/share/dbus-1/system-services \
	-Ddefault-dns-over-tls=no \
	-Ddefault-dnssec=no \
	-Ddefault-hierarchy=unified \
	-Ddefault-kill-user-processes=true \
	-Ddefault-llmnr=no \
	-Ddefault-locale=C \
	-Ddefault-mdns=no \
	-Ddefault-net-naming-scheme=latest \
	-Ddev-kvm-mode=0660 \
	-Ddns-over-tls=false \
	-Ddns-servers= \
	-Defi=false \
	-Delfutils=false \
	-Denvironment-d=false \
	-Dfallback-hostname=localhost \
	-Dfdisk=false \
	-Dfexecve=false \
	-Dfirstboot=false \
	-Dfuzz-tests=false \
	-Dgcrypt=false \
	-Dglib=false \
	-Dgnutls=false \
	-Dgroup-render-mode=0666 \
	-Dgshadow=false \
	-Dhibernate=false \
	-Dhomed=false \
	-Dhostnamed=false \
	-Dhtml=false \
	-Dhwdb=true \
	-Didn=false \
	-Dima=false \
	-Dimportd=false \
	-Dinitrd=false \
	-Dinstall-sysconfdir=false \
	-Dinstall-tests=false \
	-Dkernel-install=false \
	-Dkmod=false \
	-Dldconfig=false \
	-Dlibcryptsetup=false \
	-Dlibcurl=false \
	-Dlibfido2=false \
	-Dlibidn=false \
	-Dlibidn2=false \
	-Dlibiptc=false \
	-Dlink-boot-shared=true \
	-Dlink-journalctl-shared=true \
	-Dlink-networkd-shared=true \
	-Dlink-portabled-shared=true \
	-Dlink-systemctl-shared=true \
	-Dlink-timesyncd-shared=true \
	-Dlink-udev-shared=true \
	-Dllvm-fuzz=false \
	-Dlocaled=false \
	-Dlog-message-verification=false \
	-Dlog-trace=false \
	-Dlogind=false \
	-Dlz4=false \
	-Dmachined=false \
	-Dman=false \
	-Dmemory-accounting-default=false \
	-Dmicrohttpd=false \
	-Dmode=release \
	-Dnetworkd=false \
	-Dnobody-group=nobody \
	-Dnobody-user=nobody \
	-Dnscd=false \
	-Dnss-myhostname=false \
	-Dnss-mymachines=false \
	-Dnss-resolve=false \
	-Dnss-systemd=false \
	-Dntp-servers= \
	-Dok-color=green \
	-Doomd=false \
	-Dopenssl=false \
	-Doss-fuzz=false \
	-Dp11kit=false \
	-Dpam=false \
	-Dpasswdqc=false \
	-Dpcre2=false \
	-Dpolkit=false \
	-Dportabled=false \
	-Dpstore=false \
	-Dpwquality=false \
	-Dqrencode=false \
	-Dquotacheck=false \
	-Drandomseed=false \
	-Dremote=false \
	-Drepart=false \
	-Dresolve=false \
	-Drfkill=false \
	-Dseccomp=false \
	-Dselinux=false \
	-Dslow-tests=false \
	-Dsmack=false \
	-Dsplit-bin=true \
	-Dsplit-usr=false \
	-Dstandalone-binaries=false \
	-Dstatic-libsystemd=false \
	-Dstatic-libudev=false \
	-Dstatus-unit-format-default=name \
	-Dsysext=false \
	-Dsystem-gid-max=999 \
	-Dsystem-uid-max=999 \
	-Dsysusers=false \
	-Dsysvinit-path= \
	-Dsysvrcnd-path= \
	-Dtests=false \
	-Dtime-epoch=$(SOURCE_DATE_EPOCH) \
	-Dtimedated=false \
	-Dtimesyncd=false \
	-Dtmpfiles=false \
	-Dtpm=false \
	-Dtpm2=false \
	-Dtranslations=false \
	-Duserdb=false \
	-Dutmp=false \
	-Dvconsole=false \
	-Dversion-tag=$(HOST_SYSTEMD_VERSION) \
	-Dwheel-group=false \
	-Dxdg-autostart=false \
	-Dxenctrl=false \
	-Dxkbcommon=false \
	-Dxz=false \
	-Dzlib=false \
	-Dzstd=false

HOST_SYSTEMD_MAKE_OPT := systemd-hwdb

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-systemd.install:
	@$(call targetinfo)
	@rm -rf $(HOST_SYSTEMD_PKGDIR)/usr
	@install -vD -m755 $(HOST_SYSTEMD_DIR)-build/systemd-hwdb \
		$(HOST_SYSTEMD_PKGDIR)/usr/bin/systemd-hwdb
	@install -vD -m755 $(HOST_SYSTEMD_DIR)-build/src/shared/libsystemd-shared-$(SYSTEMD_VERSION_MAJOR).so \
		$(HOST_SYSTEMD_PKGDIR)/usr/lib/libsystemd-shared-$(SYSTEMD_VERSION_MAJOR).so
	@$(call touch)

# vim: syntax=make
