# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VIM) += vim

#
# Paths and names
#
VIM_VERSION	:= 9.1.0061
VIM_MD5		:= 61c5918a6098e7930b9998ad4cbf0633
VIM		:= vim-$(VIM_VERSION)
VIM_SUFFIX	:= tar.gz
VIM_URL		:= https://github.com/vim/vim/archive/refs/tags/v$(VIM_VERSION).$(VIM_SUFFIX)
VIM_SOURCE	:= $(SRCDIR)/$(VIM).$(VIM_SUFFIX)
VIM_DIR		:= $(BUILDDIR)/$(VIM)
VIM_SUBDIR	:= src
VIM_LICENSE	:= Vim
VIM_LICENSE_FILES := \
	file://LICENSE;md5=d1a651ab770b45d41c0f8cb5a8ca930e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VIM_CONF_ENV	:= \
	$(CROSS_ENV) \
	vim_cv_toupper_broken=no \
	vim_cv_terminfo=yes \
	vim_cv_tgetent=zero \
	vim_cv_tty_group=world \
	vim_cv_tty_mode=0620 \
	vim_cv_getcwd_broken=no \
	vim_cv_stat_ignores_slash=no \
	vim_cv_memmove_handles_overlap=yes

#
# autoconf
#
VIM_CONF_TOOL	:= autoconf
VIM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-fail-if-missing \
	--disable-darwin \
	--disable-smack \
	--disable-selinux \
	--disable-xattr \
	--disable-xsmp \
	--disable-xsmp-interact \
	--disable-luainterp \
	--disable-mzschemeinterp \
	--disable-perlinterp \
	--disable-pythoninterp \
	--disable-python3interp \
	--disable-tclinterp \
	--disable-rubyinterp \
	--disable-cscope \
	--disable-netbeans \
	--disable-channel \
	--disable-terminal \
	--disable-autoservername \
	--enable-multibyte \
	--disable-rightleft \
	--disable-arabic \
	--disable-farsi \
	--disable-xim \
	--disable-fontset \
	--disable-gui \
	--disable-gtk2-check \
	--disable-gnome-check \
	--disable-gtk3-check \
	--disable-motif-check \
	--disable-gtktest \
	--disable-icon-cache-update \
	--disable-desktop-database-update \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-canberra \
	--disable-libsodium \
	--disable-acl \
	--disable-gpm \
	--disable-sysmouse \
	--disable-nls \
	--without-x \
	--without-gnome \
	--with-tlib=ncurses

VIM_INSTALL_OPT := \
	installvimbin \
	installrtbase \
	installmacros \
	installspell

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vim.install:
	@$(call targetinfo)
	@$(call world/install, VIM)
ifdef PTXCONF_VIM_XXD
	install -vD -m755 $(VIM_DIR)/$(VIM_SUBDIR)/xxd/xxd \
		$(VIM_PKGDIR)/usr/bin/xxd
endif
	@$(call touch)
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

VIM_LINKS := ex rview rvim view vimdiff

ifdef PTXCONF_VIM_VI_SYMLINK
VIM_LINKS += vi
endif

$(STATEDIR)/vim.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vim)
	@$(call install_fixup, vim,PRIORITY,optional)
	@$(call install_fixup, vim,SECTION,base)
	@$(call install_fixup, vim,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, vim,DESCRIPTION,missing)

ifdef PTXCONF_VIM_VIM
	@$(call install_copy, vim, 0, 0, 0755, -, /usr/bin/vim)

	@$(foreach link, $(VIM_LINKS), \
		$(call install_link, vim, vim, /usr/bin/$(link))$(ptx/nl))

	@$(call install_tree, vim, 0, 0, -, /usr/share/vim)
endif

ifdef PTXCONF_VIM_XXD
	@$(call install_copy, vim, 0, 0, 0755, -, /usr/bin/xxd)
endif
	@$(call install_finish, vim)

	@$(call touch)

# vim: syntax=make
