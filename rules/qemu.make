# -*-makefile-*-
#
# Copyright (C) 2021 by Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QEMU) += qemu

#
# Paths and names
#
QEMU_VERSION	:= 6.1.0
QEMU_MD5	:= 47f776c276a24f42108ba512a2aa3013
QEMU		:= qemu-$(QEMU_VERSION)
QEMU_SUFFIX	:= tar.xz
QEMU_URL	:= https://download.qemu.org/$(QEMU).$(QEMU_SUFFIX)
QEMU_SOURCE	:= $(SRCDIR)/$(QEMU).$(QEMU_SUFFIX)
QEMU_DIR	:= $(BUILDDIR)/$(QEMU)
QEMU_LICENSE	:= GPL-2.0-only AND GPL-2.0-or-later AND MIT AND BSD-1-Clause AND BSD-2-Clause AND BSD-3-Clause
QEMU_BUILD_OOT	:= YES

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

QEMU_MAKE_OPT	:= V=$(filter 1,$(PTXDIST_VERBOSE))

QEMU_TARGETS	:= $(call remove_quotes,$(PTXCONF_QEMU_TARGETS))

QEMU_SYS_TARGETS	:= $(foreach target, $(QEMU_TARGETS), $(patsubst %,%-softmmu,$(target)))
QEMU_USR_TARGETS	:= $(foreach target, $(QEMU_TARGETS), $(patsubst %,%-linux-user,$(target)))

QEMU_CONF_TOOL	:= autoconf
# Note: not really autoconf:
# e.g. there is --enable-debug but not --disable-debug
QEMU_CONF_OPT	:= \
	--prefix=/usr \
	--target-list=" \
		$(call ptx/ifdef, PTXCONF_QEMU_SYS,$(QEMU_SYS_TARGETS),) \
		$(call ptx/ifdef, PTXCONF_QEMU_USR,$(QEMU_USR_TARGETS),) \
	" \
	--meson=meson \
	--ninja=ninja \
	--cross-prefix=$(CROSS_COMPILE) \
	--disable-sanitizers \
	--disable-tsan \
	--disable-strip \
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
	--$(call ptx/endis, PTXCONF_QEMU_SYS)-system \
	--disable-user \
	--$(call ptx/endis, PTXCONF_QEMU_USR)-linux-user \
	--disable-bsd-user \
	--disable-docs \
	--disable-guest-agent \
	--disable-guest-agent-msi \
	--enable-pie \
	--disable-modules \
	--disable-module-upgrades \
	--disable-debug-tcg \
	--disable-debug-info \
	--disable-lto \
	--disable-sparse \
	--disable-safe-stack \
	--disable-cfi \
	--disable-gnutls \
	--disable-nettle \
	--disable-gcrypt \
	--disable-auth-pam \
	--$(call ptx/endis, PTXCONF_QEMU_SDL)-sdl \
	--disable-sdl-image \
	--$(call ptx/endis, PTXCONF_QEMU_GTK)-gtk \
	--disable-vte \
	--disable-curses \
	--enable-iconv \
	--disable-vnc \
	--disable-vnc-sasl \
	--disable-vnc-jpeg \
	--disable-vnc-png \
	--disable-cocoa \
	--$(call ptx/endis, PTXCONF_QEMU_SYS)-virtfs \
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
	--$(call ptx/endis, PTXCONF_QEMU_SYS)-libusb \
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
	--$(call ptx/endis, PTXCONF_QEMU_TOOLS)-tools \
	--disable-bochs \
	--disable-cloop \
	--disable-dmg \
	--disable-qcow1 \
	--disable-vdi \
	--disable-vvfat \
	--disable-qed \
	--disable-parallels \
	--disable-crypto-afalg \
	--disable-capstone \
	--disable-debug-mutex \
	--disable-libpmem \
	--disable-xkbcommon \
	--disable-rng-none \
	--disable-libdaxctl \
	--disable-fuse \
	--enable-multiprocess \
	--disable-gio \
	\
	--disable-fuzzing \
	--disable-keyring

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qemu.install:
	@$(call targetinfo)
	@$(call world/install, QEMU)
ifdef PTXCONF_QEMU_SYS
# necessary for qemu to find its ROM files
	@ln -vsf usr/share/qemu $(QEMU_PKGDIR)/pc-bios
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qemu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qemu)
	@$(call install_fixup, qemu,PRIORITY,optional)
	@$(call install_fixup, qemu,SECTION,base)
	@$(call install_fixup, qemu,AUTHOR,"Christian Melki <christian.melki@t2data.com>")
	@$(call install_fixup, qemu,DESCRIPTION,missing)

	@$(call install_copy, qemu, 0, 0, 0755, /usr/share/qemu)
	@$(call install_copy, qemu, 0, 0, 0755, /usr/share/qemu/firmware)

ifdef PTXCONF_QEMU_SYS
	@$(foreach target, $(QEMU_TARGETS), \
		@$(call install_copy, qemu, 0, 0, 0755, -, /usr/bin/qemu-system-$(target))$(ptx/nl))

	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/libexec/virtfs-proxy-helper)
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/libexec/qemu-bridge-helper)

ifneq ($(filter i386 x86_64,$(QEMU_TARGETS)),)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/bios-256k.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/bios-microvm.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/bios.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-i386-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-i386-secure-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-i386-vars.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-x86_64-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-x86_64-secure-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/linuxboot.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/linuxboot_dma.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/pxe-e1000.rom)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/pxe-eepro100.rom)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/pxe-virtio.rom)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/vgabios-ati.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/vgabios-cirrus.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/vgabios-stdvga.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/vgabios-virtio.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/vgabios-vmware.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/vgabios.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/kvmvapic.bin)
	@$(call install_glob, qemu, 0, 0, -, /usr/share/qemu/firmware, *i386*,)
	@$(call install_glob, qemu, 0, 0, -, /usr/share/qemu/firmware, *x86_64*,)
endif

ifneq ($(filter arm aarch64,$(QEMU_TARGETS)),)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-aarch64-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-arm-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-arm-vars.fd)
	@$(call install_glob, qemu, 0, 0, -, /usr/share/qemu/firmware, *arm*,)
	@$(call install_glob, qemu, 0, 0, -, /usr/share/qemu/firmware, *aarch64*,)
endif

	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/efi-e1000.rom)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/efi-e1000e.rom)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/efi-eepro100.rom)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/efi-virtio.rom)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/pvh.bin)
endif

ifdef PTXCONF_QEMU_USR
	@$(foreach target, $(QEMU_TARGETS), \
		@$(call install_copy, qemu, 0, 0, 0755, -, /usr/bin/qemu-$(target))$(ptx/nl))
endif

ifdef PTXCONF_QEMU_TOOLS
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/bin/qemu-edid)
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/bin/qemu-img)
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/bin/qemu-io)
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/bin/qemu-pr-helper)
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/bin/qemu-storage-daemon)
endif

	@$(call install_copy, qemu, 0, 0, 0755, /usr/share/qemu/keymaps)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/keymaps/en-us)

	@$(call install_finish, qemu)

	@$(call touch)

# vim: syntax=make