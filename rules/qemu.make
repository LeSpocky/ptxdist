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
QEMU_VERSION	:= 9.1.2
QEMU_MD5	:= ea4bb735d60ad3392875f7cd48e551af
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

QEMU_AUDIO_DRIVER-y				:=
QEMU_AUDIO_DRIVER-$(PTXCONF_QEMU_ALSA)		+= alsa
QEMU_AUDIO_DRIVER-$(PTXCONF_QEMU_PULSEAUDIO)	+= pa
QEMU_AUDIO_DRIVER-$(PTXCONF_QEMU_PIPEWIRE)	+= pipewire

QEMU_CONF_TOOL	:= autoconf
# Note: not really autoconf:
# e.g. there is --enable-debug but not --disable-debug
QEMU_CONF_OPT	:= \
	--prefix=/usr \
	--target-list=$(subst $(space),$(comma),$(strip \
		$(call ptx/ifdef, PTXCONF_QEMU_SYS,$(QEMU_SYS_TARGETS),) \
		$(call ptx/ifdef, PTXCONF_QEMU_USR,$(QEMU_USR_TARGETS),))) \
	--cross-prefix=$(CROSS_COMPILE) \
	--ninja=ninja \
	--disable-download \
	--disable-sanitizers \
	--disable-tsan \
	--disable-werror \
	--enable-stack-protector \
	--with-coroutine=auto \
	--disable-plugins \
	--disable-containers \
	--audio-drv-list=$(subst $(space),$(comma),$(strip $(QEMU_AUDIO_DRIVER-y))) \
	--block-drv-ro-whitelist= \
	--block-drv-rw-whitelist= \
	--enable-coroutine-pool \
	--disable-cfi \
	--disable-debug-mutex \
	--enable-fdt=system \
	--disable-fuzzing \
	--disable-lto \
	--disable-module-upgrades \
	--disable-qom-cast-debug \
	--disable-rng-none \
	--disable-strip \
	--disable-tcg-interpreter \
	--enable-trace-backends=nop \
	--tls-priority=NORMAL \
	--$(call ptx/endis, PTXCONF_QEMU_ALSA)-alsa \
	--enable-attr \
	--disable-auth-pam \
	--disable-blkio \
	--disable-bochs \
	--disable-bpf \
	--disable-brlapi \
	--disable-bzip2 \
	--disable-canokey \
	--enable-cap-ng \
	--disable-capstone \
	--disable-cloop \
	--disable-cocoa \
	--disable-coreaudio \
	--disable-crypto-afalg \
	--disable-curl \
	--disable-curses \
	--disable-dmg \
	--disable-docs \
	--disable-dsound \
	--disable-fuse \
	--disable-fuse-lseek \
	--disable-gcrypt \
	--disable-gettext \
	--disable-gio \
	--disable-glusterfs \
	--disable-gnutls \
	--$(call ptx/endis, PTXCONF_QEMU_GTK)-gtk \
	--$(call ptx/endis, PTXCONF_QEMU_GTK)-gtk-clipboard \
	--disable-guest-agent \
	--disable-guest-agent-msi \
	--disable-hvf \
	--enable-iconv \
	--disable-jack \
	--disable-keyring \
	--enable-kvm \
	--disable-l2tpv3 \
	--disable-libdaxctl \
	--disable-libdw \
	--disable-libiscsi \
	--disable-libnfs \
	--disable-libpmem \
	--disable-libssh \
	--disable-libudev \
	--$(call ptx/endis, PTXCONF_QEMU_SYS)-libusb \
	--disable-libvduse \
	--disable-linux-aio \
	--disable-linux-io-uring \
	--disable-lzfse \
	--disable-lzo \
	--enable-malloc-trim \
	--enable-membarrier \
	--disable-mpath \
	--enable-multiprocess \
	--disable-netmap \
	--disable-nettle \
	--disable-numa \
	--disable-nvmm \
	--disable-opengl \
	--disable-oss \
	--$(call ptx/endis, PTXCONF_QEMU_PULSEAUDIO)-pa \
	--$(call ptx/endis, PTXCONF_QEMU_PIPEWIRE)-pipewire \
	--disable-parallels \
	--disable-png \
	--disable-qcow1 \
	--disable-qed \
	--disable-qga-vss \
	--disable-rbd \
	--disable-rdma \
	--disable-replication \
	--$(call ptx/endis, PTXCONF_QEMU_SDL)-sdl \
	--disable-sdl-image \
	--disable-seccomp \
	--disable-selinux \
	--enable-slirp \
	--disable-slirp-smbd \
	--disable-smartcard \
	--disable-snappy \
	--disable-sndio \
	--disable-sparse \
	--disable-spice \
	--disable-spice-protocol \
	--enable-tcg \
	--$(call ptx/endis, PTXCONF_QEMU_TOOLS)-tools \
	--disable-tpm \
	--disable-u2f \
	--disable-usb-redir \
	--disable-vde \
	--disable-vdi \
	--disable-vduse-blk-export \
	--disable-vfio-user-server \
	--disable-vhost-crypto \
	--enable-vhost-kernel \
	--enable-vhost-net \
	--disable-vhost-user \
	--disable-vhost-user-blk-server \
	--disable-vhost-vdpa \
	--disable-virglrenderer \
	--$(call ptx/endis, PTXCONF_QEMU_SYS)-virtfs \
	--disable-vmnet \
	--disable-vnc \
	--disable-vnc-jpeg \
	--disable-vnc-sasl \
	--disable-vte \
	--disable-vvfat \
	--disable-whpx \
	--disable-xen \
	--disable-xen-pci-passthrough \
	--disable-xkbcommon \
	--disable-zstd \
	--$(call ptx/endis, PTXCONF_QEMU_SYS)-system \
	--disable-user \
	--$(call ptx/endis, PTXCONF_QEMU_USR)-linux-user \
	--disable-bsd-user \
	--enable-pie \
	--disable-modules \
	--disable-debug-tcg \
	--disable-debug-info \
	--disable-safe-stack

ifdef PTXCONF_QEMU_PULSEAUDIO
QEMU_LDFLAGS      := \
        -Wl,-rpath-link,$(SYSROOT)/usr/lib/pulseaudio
endif

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

ifdef PTXCONF_QEMU_TOOLS
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/libexec/virtfs-proxy-helper)
	@$(call install_copy, qemu, 0, 0, 0755, -, /usr/libexec/qemu-bridge-helper)
endif

ifneq ($(filter i386 x86_64,$(QEMU_TARGETS)),)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/bios-256k.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/bios-microvm.bin)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/bios.bin)
ifdef PTXCONF_QEMU_EDK2_FIRMWARE
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-i386-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-i386-secure-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-i386-vars.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-x86_64-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-x86_64-secure-code.fd)
endif
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
ifdef PTXCONF_QEMU_EDK2_FIRMWARE
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-aarch64-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-arm-code.fd)
	@$(call install_copy, qemu, 0, 0, 0644, -, /usr/share/qemu/edk2-arm-vars.fd)
endif
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
