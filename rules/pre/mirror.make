# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/mirror = $(foreach mirror,$(PTXCONF_SETUP_$(strip $(1))MIRROR),$(mirror)/$(strip $(2)))

_chars = a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
ptx/mirror-pypi-chars = $(strip $(foreach c,$(_chars),$(if $(filter $(c)%,$(1)),$(c))))
ptx/mirror-pypi = $(foreach mirror, $(call ptx/mirror,PYPI,$(call ptx/mirror-pypi-chars,$(1))/$(strip $(1))/$(strip $(2))),$(mirror))

# vim: syntax=make
