# -*-makefile-*-

# these are the defaults path definitions for xorg stuff
XORG_PREFIX  := /usr
XORG_LIBDIR  := $(XORG_PREFIX)/lib
XORG_DATADIR := $(XORG_PREFIX)/share
XORG_FONTDIR := $(XORG_PREFIX)/share/fonts/X11
XORG_BINDIR  := /usr/bin

XORG_OPTIONS_TRANS	:= \
	--$(call ptx/endis,PTXCONF_XORG_OPTIONS_TRANS_UNIX)-unix-transport \
	--$(call ptx/endis,PTXCONF_XORG_OPTIONS_TRANS_TCP)-tcp-transport \
	$(GLOBAL_IPV6_OPTION) \
	--disable-local-transport

XORG_OPTIONS_DOCS	:= \
	--without-xmlto \
	--without-fop \
	--without-xsltproc

# vim: syntax=make
