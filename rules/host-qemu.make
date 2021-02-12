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

#
# Paths and names
#
HOST_QEMU_VERSION	:= 5.2.0
HOST_QEMU_MD5		:= 179f86928835da857c237b42f4b2df73
HOST_QEMU		:= qemu-$(HOST_QEMU_VERSION)
HOST_QEMU_SUFFIX	:= tar.xz
HOST_QEMU_URL		:= https://download.qemu.org/$(HOST_QEMU).$(HOST_QEMU_SUFFIX)
HOST_QEMU_SOURCE	:= $(SRCDIR)/$(HOST_QEMU).$(HOST_QEMU_SUFFIX)
HOST_QEMU_DIR		:= $(HOST_BUILDDIR)/$(HOST_QEMU)
HOST_QEMU_LICENSE	:= GPL-2.0-only AND GPL-2.0-or-later AND MIT AND BSD-1-Clause AND BSD-2-Clause AND BSD-3-Clause
HOST_QEMU_BUILD_OOT	:= YES

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
# Note: not realy autoconf:
# e.g. there is --enable-debug but not --disable-debug
HOST_QEMU_CONF_OPT	:= \
	--prefix=/. \
	--target-list=" \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_SYS,$(HOST_QEMU_SYS_TARGETS),) \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_USR,$(HOST_QEMU_USR_TARGETS),) \
	" \
	--meson=meson \
	--ninja=ninja \
	--disable-sanitizers \
	--disable-tsan \
	--disable-werror \
	--enable-stack-protector \
	--audio-drv-list= \
	--block-drv-rw-whitelist= \
	--block-drv-ro-whitelist= \
	--enable-trace-backends=nop \
	--disable-tcg-interpreter \
	--enable-malloc-trim \
	--with-coroutine= \
	--tls-priority=NORMAL \
	--disable-plugins \
	--disable-containers \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_SYS)-system \
	--disable-user \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_USR)-linux-user \
	--disable-bsd-user \
	--disable-docs \
	--disable-guest-agent \
	--disable-guest-agent-msi \
	--enable-pie \
	--disable-modules \
	--disable-module-upgrades \
	--disable-debug-tcg \
	--disable-debug-info \
	--disable-sparse \
	--disable-safe-stack \
	--disable-gnutls \
	--disable-nettle \
	--disable-gcrypt \
	--disable-auth-pam \
	--disable-sdl \
	--disable-sdl-image \
	--disable-gtk \
	--disable-vte \
	--disable-curses \
	--enable-iconv \
	--disable-vnc \
	--disable-vnc-sasl \
	--disable-vnc-jpeg \
	--disable-vnc-png \
	--disable-cocoa \
	--enable-virtfs \
	--disable-virtiofsd \
	--disable-libudev \
	--disable-mpath \
	--disable-xen \
	--disable-xen-pci-passthrough \
	--disable-brlapi \
	--disable-curl \
	--enable-membarrier \
	--enable-fdt \
	--enable-kvm \
	--disable-hax \
	--disable-hvf \
	--disable-whpx \
	--disable-rdma \
	--disable-pvrdma \
	--disable-netmap \
	--disable-linux-aio \
	--disable-linux-io-uring \
	--enable-cap-ng \
	--enable-attr \
	--enable-vhost-net \
	--enable-vhost-vsock \
	--enable-vhost-scsi \
	--disable-vhost-crypto \
	--enable-vhost-kernel \
	--disable-vhost-user \
	--disable-vhost-user-blk-server \
	--disable-vhost-vdpa \
	--disable-spice \
	--disable-rbd \
	--disable-libiscsi \
	--disable-libnfs \
	--disable-smartcard \
	--disable-u2f \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_SYS)-libusb \
	--disable-live-block-migration \
	--disable-usb-redir \
	--disable-lzo \
	--disable-snappy \
	--disable-bzip2 \
	--disable-lzfse \
	--disable-zstd \
	--disable-seccomp \
	--enable-coroutine-pool \
	--disable-glusterfs \
	--disable-tpm \
	--disable-libssh \
	--disable-numa \
	--disable-libxml2 \
	--disable-tcmalloc \
	--disable-jemalloc \
	--enable-replication \
	--disable-opengl \
	--disable-virglrenderer \
	--disable-xfsctl \
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
	--disable-sheepdog \
	--disable-crypto-afalg \
	--disable-capstone \
	--disable-debug-mutex \
	--disable-libpmem \
	--disable-xkbcommon \
	--disable-rng-none \
	--disable-libdaxctl \
	\
	--disable-fuzzing \
	--disable-keyring

# Use '=' to delay $(shell ...) calls until this is needed
QEMU_CROSS_QEMU = $(call ptx/get-alternative, config/qemu, qemu-cross)
QEMU_CROSS_DL = $(shell ptxd_cross_cc_v | sed -n -e 's/.* -dynamic-linker \([^ ]*\).*/\1/p')
QEMU_CROSS_TOOLEXECLIBDIR = $(shell dirname $$(realpath $$(ptxd_cross_cc -print-file-name=libatomic.so 2> /dev/null)))
QEMU_CROSS_LD_LIBRARY_PATH = $(PTXDIST_SYSROOT_TOOLCHAIN)/lib:$(QEMU_CROSS_TOOLEXECLIBDIR):$(SYSROOT)/$(CROSS_LIB_DIR):$(SYSROOT)/usr/$(CROSS_LIB_DIR)

QEMU_CROSS_QEMU_ENV = \
	QEMU="$(PTXDIST_SYSROOT_HOST)/bin/qemu-$(HOST_QEMU_TARGETS)" \
	KERNEL_VERSION="$(KERNEL_VERSION)" \
	QEMU_LD_PREFIX="$(PTXDIST_SYSROOT_TOOLCHAIN)" \
	QEMU_LD_LIBRARY_PATH="$(QEMU_CROSS_LD_LIBRARY_PATH)" \
	LINKER="$(shell readlink -f "$$(ptxd_cross_cc -print-file-name=$$(ptxd_get_dl))")"

$(STATEDIR)/host-qemu.install:
	@$(call targetinfo)
	@$(call world/install, HOST_QEMU)
ifdef PTXCONF_HOST_QEMU_SYS
#	# necessary for qemu to find its ROM files
	@ln -vsf share/qemu $(HOST_QEMU_PKGDIR)/pc-bios
endif
	@$(call touch)

$(STATEDIR)/host-qemu.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_QEMU)
ifdef PTXCONF_HOST_QEMU_USR
	@$(QEMU_CROSS_QEMU_ENV) ptxd_replace_magic $(QEMU_CROSS_QEMU) > $(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross
	@install -d -m 755 $(PTXDIST_SYSROOT_CROSS)/bin/qemu/
	@sed \
		-e 's|RTLDLIST=.*|RTLDLIST="$(PTXDIST_SYSROOT_TOOLCHAIN)$(QEMU_CROSS_DL)"|' \
		-e 's|eval $$add_env|eval $(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross -E "$${add_env// /,}"|' \
		-e 's|verify_out=`|verify_out=`$(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross |' \
		-e 's|#! */.*$$|#!$(shell readlink $(PTXDIST_TOPDIR)/bin/bash)|' \
		$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/bin/ldd > $(PTXDIST_SYSROOT_CROSS)/bin/qemu/ldd
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/qemu/ldd
endif
	@$(call touch)

# vim: syntax=make
