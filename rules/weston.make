# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#               2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WESTON) += weston

#
# Paths and names
#
WESTON_VERSION	:= 14.0.1
LIBWESTON_MAJOR := 14
WESTON_MD5	:= d07a8f4dfb7cb81035052928ba1a8c71
WESTON		:= weston-$(WESTON_VERSION)
WESTON_SUFFIX	:= tar.gz
WESTON_URL	:= https://gitlab.freedesktop.org/wayland/weston/-/archive/$(WESTON_VERSION)/$(WESTON).$(WESTON_SUFFIX)
WESTON_SOURCE	:= $(SRCDIR)/$(WESTON).$(WESTON_SUFFIX)
WESTON_DIR	:= $(BUILDDIR)/$(WESTON)
WESTON_LICENSE	:= MIT
WESTON_LICENSE_FILES	:= file://COPYING;md5=d79ee9e66bb0f95d3386a7acae780b70

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WESTON_SIMPLE_CLIENTS-y := damage im shm touch
WESTON_SIMPLE_CLIENTS-$(PTXCONF_WESTON_GL) += egl dmabuf-egl dmabuf-feedback

WESTON_CONF_TOOL	:= meson
WESTON_CONF_OPT		:= \
	$(CROSS_MESON_USR) \
	-Dbackend-default=drm \
	-Dbackend-drm=true \
	-Dbackend-drm-screencast-vaapi=false \
	-Dbackend-headless=$(call ptx/truefalse,PTXCONF_WESTON_HEADLESS_COMPOSITOR) \
	-Dbackend-pipewire=$(call ptx/truefalse,PTXCONF_WESTON_BACKEND_PIPEWIRE) \
	-Dbackend-rdp=false \
	-Dbackend-vnc=$(call ptx/truefalse,PTXCONF_WESTON_BACKEND_VNC) \
	-Dbackend-wayland=$(call ptx/truefalse,PTXCONF_WESTON_GL) \
	-Dbackend-x11=false \
	-Dcolor-management-lcms=$(call ptx/truefalse,PTXCONF_WESTON_COLOR_MANAGEMENT_LCMS) \
	-Ddemo-clients=$(call ptx/truefalse,PTXCONF_WESTON_IVISHELL_EXAMPLE) \
	-Ddesktop-shell-client-default=weston-desktop-shell \
	-Ddoc=false \
	-Dimage-jpeg=true \
	-Dimage-webp=false \
	-Dpipewire=$(call ptx/truefalse,PTXCONF_WESTON_PIPEWIRE) \
	-Dremoting=$(call ptx/truefalse,PTXCONF_WESTON_REMOTING) \
	-Drenderer-gl=$(call ptx/truefalse,PTXCONF_WESTON_GL) \
	-Dresize-pool=true \
	-Dscreenshare=false \
	-Dshell-desktop=true \
	-Dshell-fullscreen=true \
	-Dshell-ivi=$(call ptx/truefalse,PTXCONF_WESTON_IVISHELL) \
	-Dshell-kiosk=$(call ptx/truefalse,PTXCONF_WESTON_SHELL_KIOSK) \
	-Dsimple-clients=$(subst $(space),$(comma),$(WESTON_SIMPLE_CLIENTS-y)) \
	-Dsystemd=$(call ptx/truefalse,PTXCONF_WESTON_SYSTEMD) \
	-Dtest-junit-xml=false \
	-Dtest-skip-is-failure=false \
	-Dtests=false \
	-Dtools=calibrator,debug,info,terminal,touch-calibrator \
	-Dwcap-decode=$(call ptx/truefalse,PTXCONF_WESTON_WCAP_TOOLS) \
	-Dxwayland=$(call ptx/truefalse,PTXCONF_WESTON_XWAYLAND) \
	-Dxwayland-path=/usr/bin/Xwayland

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/weston.install:
	@$(call targetinfo)
	@$(call world/install, WESTON)

ifndef PTXCONF_WESTON_IVISHELL_EXAMPLE
	@install -D -m644 $(WESTON_DIR)-build/frontend/weston.ini \
		$(WESTON_PKGDIR)/etc/xdg/weston/weston.ini
else
	@install -D -m644 $(WESTON_DIR)-build/ivi-shell/weston.ini \
		$(WESTON_PKGDIR)/etc/xdg/weston/weston.ini
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/weston.targetinstall:
	@$(call targetinfo)

	@$(call install_init, weston)
	@$(call install_fixup, weston,PRIORITY,optional)
	@$(call install_fixup, weston,SECTION,base)
	@$(call install_fixup, weston,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, weston,DESCRIPTION,"wayland reference compositor implementation")

	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-debug)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-screenshooter)
ifdef PTXCONF_WESTON_SIMPLE_CLIENTS
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-damage)
ifdef PTXCONF_WESTON_GL
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-egl)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-dmabuf-egl)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-dmabuf-feedback)
endif
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-shm)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-touch)
endif
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-terminal)
ifdef PTXCONF_WESTON_TOUCH_CALIBRATOR
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-touch-calibrator)
endif

ifdef PTXCONF_WESTON_WCAP_TOOLS
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/wcap-decode)
endif

	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR))
ifdef PTXCONF_WESTON_XWAYLAND
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/xwayland)
endif
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/drm-backend)
ifdef PTXCONF_WESTON_HEADLESS_COMPOSITOR
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/headless-backend)
endif
ifdef PTXCONF_WESTON_BACKEND_PIPEWIRE
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/pipewire-backend)
endif
ifdef PTXCONF_WESTON_BACKEND_VNC
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/vnc-backend)
endif
ifdef PTXCONF_WESTON_GL
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/wayland-backend)
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/gl-renderer)
endif
ifdef PTXCONF_WESTON_PIPEWIRE
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/pipewire-plugin)
endif
ifdef PTXCONF_WESTON_REMOTING
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/remoting-plugin)
endif
	@$(call install_lib, weston, 0, 0, 0644, weston/desktop-shell)
	@$(call install_lib, weston, 0, 0, 0644, weston/fullscreen-shell)
ifdef PTXCONF_WESTON_IVISHELL
	@$(call install_lib, weston, 0, 0, 0644, weston/ivi-shell)
endif
ifdef PTXCONF_WESTON_SHELL_KIOSK
	@$(call install_lib, weston, 0, 0, 0644, weston/kiosk-shell)
endif
ifdef PTXCONF_WESTON_SYSTEMD
	@$(call install_lib, weston, 0, 0, 0644, weston/systemd-notify)
endif
	@$(call install_lib, weston, 0, 0, 0644, weston/libexec_weston)

ifdef PTXCONF_WESTON_STARTSCRIPT
	@$(call install_alternative, weston, 0, 0, 0755, /etc/init.d/weston-init)
ifneq ($(call remove_quotes,$(PTXCONF_WESTON_BBINIT_LINK)),)
	@$(call install_link, weston, \
		../init.d/weston-init, \
		/etc/rc.d/$(PTXCONF_WESTON_BBINIT_LINK))
endif
endif

	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-simple-im)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-desktop-shell)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-keyboard)


	@$(foreach image, \
		border.png \
		icon_window.png \
		pattern.png \
		sign_close.png \
		sign_maximize.png \
		sign_minimize.png \
		terminal.png \
		wayland.png \
		wayland.svg, \
		$(call install_copy, weston, 0, 0, 0644, -, /usr/share/weston/$(image))$(ptx/nl))

ifdef PTXCONF_WESTON_INSTALL_CONFIG
	@$(call install_alternative, weston, 0, 0, 0644, /etc/xdg/weston/weston.ini)
endif

ifdef PTXCONF_WESTON_IVISHELL_EXAMPLE
	@$(call install_lib, weston, 0, 0, 0644, weston/hmi-controller)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-ivi-shell-user-interface)

	@$(foreach image, \
		background.png \
		fullscreen.png \
		home.png \
		icon_ivi_clickdot.png \
		icon_ivi_flower.png \
		icon_ivi_simple-egl.png \
		icon_ivi_simple-shm.png \
		icon_ivi_smoke.png \
		panel.png \
		random.png \
		sidebyside.png \
		tiling.png, \
		$(call install_copy, weston, 0, 0, 0644, -, /usr/share/weston/$(image))$(ptx/nl))

	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-clickdot)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-flower)
ifdef PTXCONF_WESTON_GL
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-egl)
endif
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-simple-shm)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-smoke)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-tablet)
endif

	@$(call install_finish, weston)

	@$(call touch)

# vim: syntax=make
