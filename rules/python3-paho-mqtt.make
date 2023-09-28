# -*-makefile-*-
#
# Copyright (C) 2023 by Bruno Thomsen <bruno.thomsen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PAHO_MQTT) += python3-paho-mqtt

#
# Paths and names
#
PYTHON3_PAHO_MQTT_VERSION	:= 1.6.1
PYTHON3_PAHO_MQTT_MD5		:= bdb20f88db291fdb4a0fe804c0f29316
PYTHON3_PAHO_MQTT		:= paho-mqtt-$(PYTHON3_PAHO_MQTT_VERSION)
PYTHON3_PAHO_MQTT_SUFFIX	:= tar.gz
PYTHON3_PAHO_MQTT_URL		:= $(call ptx/mirror-pypi, paho-mqtt, $(PYTHON3_PAHO_MQTT).$(PYTHON3_PAHO_MQTT_SUFFIX))
PYTHON3_PAHO_MQTT_SOURCE	:= $(SRCDIR)/$(PYTHON3_PAHO_MQTT).$(PYTHON3_PAHO_MQTT_SUFFIX)
PYTHON3_PAHO_MQTT_DIR		:= $(BUILDDIR)/$(PYTHON3_PAHO_MQTT)
PYTHON3_PAHO_MQTT_LICENSE	:= EPL-2.0 OR BSD-3-Clause
PYTHON3_PAHO_MQTT_LICENSE_FILES	:= \
	file://LICENSE.txt;md5=8e5f264c6988aec56808a3a11e77b913 \
	file://edl-v10;md5=c09f121939f063aeb5235972be8c722c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PAHO_MQTT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-paho-mqtt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-paho-mqtt)
	@$(call install_fixup, python3-paho-mqtt,PRIORITY,optional)
	@$(call install_fixup, python3-paho-mqtt,SECTION,base)
	@$(call install_fixup, python3-paho-mqtt,AUTHOR,"Bruno Thomsen <bruno.thomsen@gmail.com>")
	@$(call install_fixup, python3-paho-mqtt,DESCRIPTION,missing)

	@$(call install_glob, python3-paho-mqtt, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-paho-mqtt)

	@$(call touch)

# vim: syntax=make
