# -*-makefile-*-
#
# Copyright (C) 2008 by J.Kilb
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2019 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GPSD) += gpsd

#
# Paths and names
#
GPSD_VERSION	:= 3.21
GPSD_MD5	:= 782e4b10193f225cc95c65528636d4f5
GPSD		:= gpsd-$(GPSD_VERSION)
GPSD_SUFFIX	:= tar.xz
GPSD_URL	:= http://download.savannah.gnu.org/releases/gpsd/$(GPSD).$(GPSD_SUFFIX)
GPSD_SOURCE	:= $(SRCDIR)/$(GPSD).$(GPSD_SUFFIX)
GPSD_DIR	:= $(BUILDDIR)/$(GPSD)
GPSD_LICENSE	:= BSD-2-Clause
GPSD_LICENSE_FILES	:= file://COPYING;md5=7a5d174db44ec45f9638b2c747806821

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GPSD_PROGS-y				:=
GPSD_PROGS-$(PTXCONF_GPSD_GPS2UDP)	+= gps2udp
GPSD_PROGS-$(PTXCONF_GPSD_GPSCTL)	+= gpsctl
GPSD_PROGS-$(PTXCONF_GPSD_GPSDECODE)	+= gpsdecode
GPSD_PROGS-$(PTXCONF_GPSD_GPSPIPE)	+= gpspipe
GPSD_PROGS-$(PTXCONF_GPSD_GPSRINEX)	+= gpsrinex
GPSD_PROGS-$(PTXCONF_GPSD_GPXLOGGER)	+= gpxlogger
GPSD_PROGS-$(PTXCONF_GPSD_LCDGPS)	+= lcdgps
GPSD_PROGS-$(PTXCONF_GPSD_CGPS)		+= cgps
GPSD_PROGS-$(PTXCONF_GPSD_GPSMON)	+= gpsmon
GPSD_PROGS-$(PTXCONF_GPSD_NTPSHMMON)	+= ntpshmmon
GPSD_PROGS-$(PTXCONF_GPSD_PPSCHECK)	+= ppscheck

GPSD_BUILD_CLIENTS := $(call ptx/ifdef, PTXCONF_GPSD_GPSDCTL, yes, \
			$(if $(strip $(GPSD_PROGS-y)), yes, no))

# Python programs
GPSD_PROGS-$(PTXCONF_GPSD_GEGPS)	+= gegps
GPSD_PROGS-$(PTXCONF_GPSD_GPSCAT)	+= gpscat
GPSD_PROGS-$(PTXCONF_GPSD_GPSFAKE)	+= gpsfake
GPSD_PROGS-$(PTXCONF_GPSD_GPSPROF)	+= gpsprof
GPSD_PROGS-$(PTXCONF_GPSD_UBXTOOL)	+= ubxtool
GPSD_PROGS-$(PTXCONF_GPSD_ZERK)		+= zerk

GPSD_CONF_TOOL	:= scons
GPSD_CONF_ENV	:= \
	$(CROSS_ENV_PKG_CONFIG)
GPSD_CONF_OPT	= \
	aivdm=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_AIVDM) \
	ashtech=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_ASHTECH) \
	bluez=$(call ptx/yesno, PTXCONF_GPSD_BLUEZ) \
	clientdebug=no \
	control_socket=yes \
	coveraging=no \
	dbus_export=$(call ptx/yesno, PTXCONF_GPSD_DBUS) \
	debug=no \
	earthmate=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_EARTHMATE) \
	evermore=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_EVERMORE) \
	force_global=yes \
	fury=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_FURY) \
	fv18=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_FV18) \
	garmin=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_GARMIN) \
	garmintxt=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_GARMINTXT) \
	geostar=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_GEOSTAR) \
	gpsclock=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_GPSCLOCK) \
	gpsd=$(call ptx/yesno, PTXCONF_GPSD_GPSD) \
	gpsdclients=$(GPSD_BUILD_CLIENTS) \
	greis=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_GREIS) \
	implicit_link=yes \
	isync=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_ISYNC) \
	itrax=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_ITRAX) \
	libgpsmm=no \
	magic_hat=no \
	manbuild=no \
	minimal=yes \
	mtk3301=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_MTK3301) \
	navcom=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_NAVCOM) \
	ncurses=$(call ptx/yesno, PTXCONF_GPSD_NCURSES) \
	netfeed=yes \
	nmea0183=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_NMEA) \
	nmea2000=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_NMEA) \
	nostrip=yes \
	ntrip=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_NTRIP) \
	oceanserver=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_OCEANSERVER) \
	oncore=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_ONCORE) \
	oscillator=$(call ptx/yesno, PTXCONF_GPSD_OSCILLATOR) \
	passthrough=no \
	prefix=/usr \
	profiling=$(call ptx/yesno, PTXCONF_GPSD_PROFILING) \
	python=$(call ptx/yesno, PTXCONF_GPSD_PYTHON) \
	python_libdir=/usr/lib/python$(PYTHON3_MAJORMINOR) \
	qt=no \
	rtcm104v2=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_RTCM104V2) \
	rtcm104v3=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_RTCM104V3) \
	rundir=/run \
	shared=yes \
	shm_export=$(call ptx/yesno, PTXCONF_GPSD_SHM) \
	sirf=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_SIRF) \
	skytraq=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_SKYTRAQ) \
	socket_export=$(call ptx/yesno, PTXCONF_GPSD_SOCKET) \
	squelch=yes \
	superstar2=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_SUPERSTAR2) \
	sysconfdir=/etc \
	systemd=$(call ptx/yesno, PTXCONF_GPSD_SYSTEMD) \
	target=$(PTXCONF_GNU_TARGET) \
	target_python=$(CROSS_PYTHON3) \
	timeservice=no \
	tnt=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_TNT) \
	tripmate=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_TRIPMATE) \
	tsip=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_TSIP) \
	ublox=$(call ptx/yesno, PTXCONF_GPSD_DRIVER_UBLOX) \
	udevdir=/usr/lib/udev \
	usb=$(call ptx/yesno, PTXCONF_GPSD_USB) \
	xgps=no

ifneq ($(call remove_quotes,$(PTXCONF_GPSD_GROUP)),)
GPSD_CONF_OPT += gpsd_group=$(PTXCONF_GPSD_GROUP)
endif
ifneq ($(call remove_quotes,$(PTXCONF_GPSD_USER)),)
GPSD_CONF_OPT += gpsd_user=$(PTXCONF_GPSD_USER)
endif

ifneq ($(call remove_quotes,$(PTXCONF_GPSD_MAX_CLIENTS)),)
GPSD_CONF_OPT += max_clients=$(PTXCONF_GPSD_MAX_CLIENTS)
endif
ifneq ($(call remove_quotes,$(PTXCONF_GPSD_MAX_DEVICES)),)
GPSD_CONF_OPT += max_devices=$(PTXCONF_GPSD_MAX_DEVICES)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gpsd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gpsd)
	@$(call install_fixup, gpsd,PRIORITY,optional)
	@$(call install_fixup, gpsd,SECTION,base)
	@$(call install_fixup, gpsd,AUTHOR,"Jürgen Kilb <j.kilb@phytec.de>")
	@$(call install_fixup, gpsd,DESCRIPTION,missing)

	@$(call install_lib, gpsd, 0, 0, 0644, libgps)
	@$(call install_lib, gpsd, 0, 0, 0644, libgpsdpacket)
	@$(foreach prog, $(GPSD_PROGS-y), \
		$(call install_copy, gpsd, 0, 0, 0755, -, \
			/usr/bin/$(prog))$(ptx/nl))
ifdef PTXCONF_GPSD_GPSD
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/sbin/gpsd)
endif
ifdef PTXCONF_GPSD_GPSDCTL
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/sbin/gpsdctl)
endif
ifdef PTXCONF_GPSD_SYSTEMD_UNIT
	@$(call install_alternative, gpsd, 0, 0, 0644, \
		/usr/lib/systemd/system/gpsd.service)
	@$(call install_replace, gpsd, \
		/usr/lib/systemd/system/gpsd.service, \
		@ARGS@, $(PTXCONF_GPSD_GPSD_ARGS))
	@$(call install_link, gpsd, ../gpsd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/gpsd.service)
	@$(call install_alternative, gpsd, 0, 0, 0644, \
		/usr/lib/systemd/system/gpsd.socket)
	@$(call install_link, gpsd, ../gpsd.socket, \
		/usr/lib/systemd/system/sockets.target.wants/gpsd.socket)
ifdef PTXCONF_GPSD_GPSDCTL
	@$(call install_alternative, gpsd, 0, 0, 0644, \
		/usr/lib/systemd/system/gpsdctl@.service)
endif
endif
ifdef PTXCONF_GPSD_PYTHON
	@$(call install_glob, gpsd, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR), *.py)
endif
	@$(call install_finish, gpsd)

	@$(call touch)

# vim: syntax=make
