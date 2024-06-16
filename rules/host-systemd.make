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
	-Dapparmor=disabled \
	-Daudit=disabled \
	-Dbacklight=false \
	-Dbinfmt=false \
	-Dblkid=disabled \
	-Dbootloader=disabled \
	-Dbpf-framework=disabled \
	-Dbump-proc-sys-fs-file-max=true \
	-Dbump-proc-sys-fs-nr-open=true \
	-Dbzip2=disabled \
	-Dcompat-mutable-uid-boundaries=false \
	-Dcoredump=false \
	-Dcreate-log-dirs=false \
	-Dcryptolib=auto \
	-Ddbus=disabled \
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
	-Ddefault-network=false \
	-Ddev-kvm-mode=0660 \
	-Ddns-over-tls=false \
	-Ddns-servers= \
	-Defi=false \
	-Delfutils=disabled \
	-Denvironment-d=false \
	-Dfallback-hostname=localhost \
	-Dfdisk=disabled \
	-Dfexecve=false \
	-Dfirstboot=false \
	-Dfuzz-tests=false \
	-Dgcrypt=disabled \
	-Dglib=disabled \
	-Dgnutls=disabled \
	-Dgroup-render-mode=0666 \
	-Dgshadow=false \
	-Dhibernate=false \
	-Dhomed=disabled \
	-Dhostnamed=false \
	-Dhtml=disabled \
	-Dhwdb=true \
	-Didn=false \
	-Dima=false \
	-Dimportd=disabled \
	-Dinitrd=false \
	-Dinstall-sysconfdir=false \
	-Dinstall-tests=false \
	-Dintegration-tests=false \
	-Dkernel-install=false \
	-Dkexec-path=/usr/sbin/kexec \
	-Dkmod=disabled \
	-Dldconfig=false \
	-Dlibarchive=disabled \
	-Dlibcryptsetup=disabled \
	-Dlibcurl=disabled \
	-Dlibfido2=disabled \
	-Dlibidn=disabled \
	-Dlibidn2=disabled \
	-Dlibiptc=disabled \
	-Dlink-boot-shared=true \
	-Dlink-journalctl-shared=true \
	-Dlink-networkd-shared=true \
	-Dlink-portabled-shared=true \
	-Dlink-systemctl-shared=true \
	-Dlink-timesyncd-shared=true \
	-Dlink-udev-shared=true \
	-Dllvm-fuzz=false \
	-Dlocaled=false \
	-Dlog-message-verification=disabled \
	-Dlog-trace=false \
	-Dlogind=false \
	-Dlz4=disabled \
	-Dmachined=false \
	-Dman=disabled \
	-Dmemory-accounting-default=false \
	-Dmicrohttpd=disabled \
	-Dmode=release \
	-Dmount-path=/usr/bin/mount \
	-Dmountfsd=false \
	-Dnetworkd=false \
	-Dnobody-group=nogroup \
	-Dnobody-user=nobody \
	-Dnscd=false \
	-Dnsresourced=false \
	-Dnss-myhostname=false \
	-Dnss-mymachines=disabled \
	-Dnss-resolve=disabled \
	-Dnss-systemd=false \
	-Dntp-servers= \
	-Dok-color=green \
	-Doomd=false \
	-Dopenssl=disabled \
	-Doss-fuzz=false \
	-Dp11kit=disabled \
	-Dpam=disabled \
	-Dpasswdqc=disabled \
	-Dpcre2=disabled \
	-Dpolkit=disabled \
	-Dportabled=false \
	-Dpstore=false \
	-Dpwquality=disabled \
	-Dqrencode=disabled \
	-Dquotacheck=false \
	-Drandomseed=false \
	-Dremote=false \
	-Drepart=disabled \
	-Dresolve=false \
	-Drepart=disabled \
	-Dresolve=false \
	-Drfkill=false \
	-Dseccomp=disabled \
	-Dselinux=disabled \
	-Dslow-tests=false \
	-Dsmack=false \
	-Dsplit-bin=true \
	-Dstandalone-binaries=false \
	-Dstatic-libsystemd=false \
	-Dstatic-libudev=false \
	-Dstatus-unit-format-default=name \
	-Dstoragetm=false \
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
	-Dtpm2=disabled \
	-Dtranslations=false \
	-Dukify=disabled \
	-Durlify=false \
	-Duserdb=false \
	-Dutmp=false \
	-Dvconsole=false \
	-Dvmspawn=disabled \
	-Dversion-tag=$(HOST_SYSTEMD_VERSION) \
	-Dwheel-group=false \
	-Dxdg-autostart=false \
	-Dxenctrl=disabled \
	-Dxkbcommon=disabled \
	-Dxz=disabled \
	-Dzlib=disabled \
	-Dzstd=disabled

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
