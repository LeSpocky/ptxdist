# -*-makefile-*-
#
# Copyright (C) 2019 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PAHO_MQTT_CPP) += paho-mqtt-cpp

#
# Paths and names
#
PAHO_MQTT_CPP_VERSION	:= 1.5.3
PAHO_MQTT_CPP_MD5	:= 5e854904a4eb7eae6a1bf4cfcdff28da
PAHO_MQTT_CPP		:= paho.mqtt.cpp-$(PAHO_MQTT_CPP_VERSION)
PAHO_MQTT_CPP_SUFFIX	:= tar.gz
PAHO_MQTT_CPP_URL	:= https://github.com/eclipse/paho.mqtt.cpp/archive/v$(PAHO_MQTT_CPP_VERSION).$(PAHO_MQTT_CPP_SUFFIX)
PAHO_MQTT_CPP_SOURCE	:= $(SRCDIR)/$(PAHO_MQTT_CPP).$(PAHO_MQTT_CPP_SUFFIX)
PAHO_MQTT_CPP_DIR	:= $(BUILDDIR)/$(PAHO_MQTT_CPP)
# "Eclipse Distribution License - v 1.0" is in fact BSD-3-Clause
PAHO_MQTT_CPP_LICENSE	:= EPL-2.0 AND BSD-3-Clause
PAHO_MQTT_CPP_LICENSE_FILES := \
	file://about.html;md5=fa779b102043e99492d92d501aaa2456 \
	file://epl-v20;md5=d9fc0efef5228704e7f5b37f27192723 \
	file://edl-v10;md5=3adfcc70f5aeb7a44f3f9b495aa1fbf3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PAHO_MQTT_CPP_CONF_TOOL	:= cmake

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/paho-mqtt-cpp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, paho-mqtt-cpp)
	@$(call install_fixup, paho-mqtt-cpp,PRIORITY,optional)
	@$(call install_fixup, paho-mqtt-cpp,SECTION,base)
	@$(call install_fixup, paho-mqtt-cpp,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, paho-mqtt-cpp,DESCRIPTION,missing)

	@$(call install_lib, paho-mqtt-cpp, 0, 0, 0644, libpaho-mqttpp3)

	@$(call install_finish, paho-mqtt-cpp)

	@$(call touch)

# vim: syntax=make
