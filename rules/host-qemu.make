# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <bernhard@bwalle.de>
#           (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#           (C) 2013 by Jan Luebbe <j.luebbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QEMU) += host-qemu

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#

HOST_QEMU_BROKEN_ICECC	:= \
	$(call ptx/sh, gcc -dumpversion | awk -F . '{ if ($$1*100 + $$2 < 409) print "y" }')

ifeq ($(HOST_QEMU_BROKEN_ICECC),y)
HOST_QEMU_MAKE_ENV	:= PTXDIST_ICECC=$(PTXDIST_ICERUN)
endif
HOST_QEMU_MAKE_OPT	:= V=$(filter 1,$(PTXDIST_VERBOSE))

HOST_QEMU_TARGETS	:= $(PTXCONF_ARCH_STRING)
ifndef PTXCONF_ARCH_X86_64
ifdef PTXCONF_ARCH_X86
HOST_QEMU_TARGETS	:= i386
endif
endif
ifdef PTXCONF_ARCH_ARM64
HOST_QEMU_TARGETS	:= aarch64
endif
HOST_QEMU_SYS_TARGETS	:= $(patsubst %,%-softmmu,$(HOST_QEMU_TARGETS))
HOST_QEMU_USR_TARGETS	:= $(patsubst %,%-linux-user,$(HOST_QEMU_TARGETS))

HOST_QEMU_CONF_TOOL	:= autoconf
# Note: not really autoconf:
# e.g. there is --enable-debug but not --disable-debug
HOST_QEMU_CONF_OPT	:= \
	--prefix=/usr \
	--target-list=" \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_SYS,$(HOST_QEMU_SYS_TARGETS),) \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_USR,$(HOST_QEMU_USR_TARGETS),) \
	" \
	--meson=meson \
	--ninja=ninja \
	--disable-sanitizers \
	--disable-tsan \
	--disable-strip \
	--disable-werror \
	--enable-stack-protector \
	--audio-drv-list= \
	--block-drv-rw-whitelist= \
	--block-drv-ro-whitelist= \
	--with-coroutine= \
	--tls-priority=NORMAL \
	--disable-plugins \
	--disable-containers \
	--disable-capstone \
	--disable-cfi \
	--enable-fdt \
	--disable-fuzzing \
	--disable-tcg-interpreter \
	--enable-trace-backends=nop \
	--disable-alsa \
	--enable-attr \
	--disable-auth-pam \
	--disable-bpf \
	--disable-brlapi \
	--disable-bzip2 \
	--enable-cap-ng \
	--disable-cocoa \
	--disable-coreaudio \
	--disable-curl \
	--disable-curses \
	--disable-docs \
	--disable-dsound \
	--disable-fuse \
	--disable-fuse-lseek \
	--disable-gcrypt \
	--disable-gettext \
	--disable-glusterfs \
	--disable-gnutls \
	--disable-gtk \
	--disable-guest-agent-msi \
	--disable-hax \
	--disable-hvf \
	--enable-iconv \
	--disable-jack \
	--enable-kvm \
	--disable-l2tpv3 \
	--disable-libdaxctl \
	--disable-libiscsi \
	--disable-libnfs \
	--disable-libpmem \
	--disable-libudev \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_SYS)-libusb \
	--disable-linux-aio \
	--disable-linux-io-uring \
	--disable-lzfse \
	--disable-lzo \
	--enable-malloc-trim \
	--disable-mpath \
	--enable-multiprocess \
	--disable-netmap \
	--disable-nettle \
	--disable-nvmm \
	--disable-oss \
	--disable-pa \
	--disable-rbd \
	--disable-sdl \
	--disable-sdl-image \
	--disable-seccomp \
	--disable-selinux \
	--enable-slirp \
	--disable-smartcard \
	--disable-snappy \
	--disable-sparse \
	--disable-spice \
	--disable-spice-protocol \
	--enable-tcg \
	--disable-u2f \
	--disable-usb-redir \
	--disable-vhost-user-blk-server \
	--disable-libvduse \
	--disable-virglrenderer \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_SYS)-virtfs \
	--disable-virtiofsd \
	--disable-vnc \
	--disable-vnc-jpeg \
	--disable-vnc-sasl \
	--disable-vte \
	--disable-whpx \
	--disable-xen \
	--disable-xen-pci-passthrough \
	--disable-xkbcommon \
	--disable-zstd \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_SYS)-system \
	--disable-user \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_USR)-linux-user \
	--disable-bsd-user \
	--disable-guest-agent \
	--enable-pie \
	--disable-modules \
	--disable-module-upgrades \
	--disable-debug-tcg \
	--disable-debug-info \
	--disable-lto \
	--disable-safe-stack \
	--enable-membarrier \
	--disable-rdma \
	--disable-pvrdma \
	--enable-vhost-net \
	--disable-vhost-crypto \
	--enable-vhost-kernel \
	--disable-vhost-user \
	--disable-vhost-vdpa \
	--disable-live-block-migration \
	--enable-coroutine-pool \
	--disable-tpm \
	--disable-libssh \
	--disable-numa \
	--disable-replication \
	--disable-opengl \
	--disable-qom-cast-debug \
	--disable-tools \
	--disable-bochs \
	--disable-cloop \
	--disable-dmg \
	--disable-qcow1 \
	--disable-vdi \
	--disable-vvfat \
	--disable-qed \
	--disable-parallels \
	--disable-crypto-afalg \
	--disable-debug-mutex \
	--disable-rng-none \
	--disable-gio \
	--disable-slirp-smbd \
	\
	--disable-keyring

# Use '=' to delay $(shell ...) calls until this is needed
QEMU_CROSS_QEMU = $(call ptx/get-alternative, config/qemu, qemu-cross)
QEMU_CROSS_DL = $(shell ptxd_cross_cc_v | sed -n -e 's/.* -dynamic-linker \([^ ]*\).*/\1/p')
QEMU_CROSS_TOOLEXECLIBDIR = $(shell dirname $$(realpath $$(ptxd_cross_cc -print-file-name=libatomic.so 2> /dev/null)))
QEMU_CROSS_LD_LIBRARY_PATH = $(PTXDIST_SYSROOT_TOOLCHAIN)/lib:$(QEMU_CROSS_TOOLEXECLIBDIR):$(SYSROOT)/lib:$(SYSROOT)/usr/lib

QEMU_CROSS_QEMU_ENV = \
	QEMU="$(PTXDIST_SYSROOT_HOST)/usr/bin/qemu-$(HOST_QEMU_TARGETS)" \
	KERNEL_VERSION="$(KERNEL_VERSION)" \
	QEMU_LD_PREFIX="$(PTXDIST_SYSROOT_TOOLCHAIN)" \
	QEMU_LD_LIBRARY_PATH="$(QEMU_CROSS_LD_LIBRARY_PATH)" \
	LINKER="$(shell readlink -f "$$(ptxd_cross_cc -print-file-name=$$(ptxd_get_dl))")"

$(STATEDIR)/host-qemu.install:
	@$(call targetinfo)
	@$(call world/install, HOST_QEMU)
ifdef PTXCONF_HOST_QEMU_SYS
#	# necessary for qemu to find its ROM files
	@ln -vsf share/qemu $(HOST_QEMU_PKGDIR)/usr/pc-bios
endif
	@$(call touch)

$(STATEDIR)/host-qemu.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_QEMU)
ifdef PTXCONF_HOST_QEMU_USR
	@$(QEMU_CROSS_QEMU_ENV) ptxd_replace_magic $(QEMU_CROSS_QEMU) > $(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu-cross
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu-cross
	@install -d -m 755 $(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu/
	@sed \
		-e 's|RTLDLIST=.*|RTLDLIST="$(PTXDIST_SYSROOT_TOOLCHAIN)$(QEMU_CROSS_DL)"|' \
		-e 's|eval $$add_env|eval $(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu-cross -E "$${add_env// /,}"|' \
		-e 's|verify_out=`|verify_out=`$(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu-cross |' \
		-e 's|#! */.*$$|#!$(shell readlink $(PTXDIST_TOPDIR)/bin/bash)|' \
		$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/bin/ldd > $(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu/ldd
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu/ldd
endif
	@$(call touch)

# vim: syntax=make
