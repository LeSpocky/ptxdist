# -*-makefile-*-
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

install_check =										\
	CMD="$(strip $(1))";								\
	if [ ! -f "$(PTXDIST_TEMPDIR)/$(notdir $(@)).$$XPKG" ]; then			\
		echo;									\
		echo "Error: install_init was not called for package '$$XPKG'!";	\
		echo "This is probably caused by a typo in the package name of:";	\
		echo "\$$(call $$CMD, $$XPKG, ...)";					\
		echo;									\
		exit 1;									\
	fi

#
# install_copy
#
# Installs a file with user/group ownership and permissions via
# fakeroot.
#
# $1: xpkg label
# $2: UID
# $3: GID
# $4: permissions (octal)
#
# a) install src->dst:
#     $5: source (for files); directory (for directories)
#     $6: destination (for files); empty (for directories). Prefixed with
#         $(ROOTDIR), so it needs to have a leading /
#
# b) install from PKG_PKGDIR (result of 'make install'):
#
#     $5: "-": source is taken from $(PKG_PKGDIR)/$destination
#     $6: destination
#
# binaries are stripped automatically
#
install_copy = 											\
	XPKG="$(subst _,-,$(strip $(1)))";							\
	OWN="$(strip $(2))";									\
	GRP="$(strip $(3))";									\
	PER="$(strip $(4))";									\
	SRC="$(strip $(5))";									\
	DST="$(strip $(6))";									\
	STRIP="$(strip $(7))";									\
	$(call install_check, install_copy);							\
	if [ -z "$(6)" ]; then									\
		echo "ptxd_install_dir '$$SRC' '$$OWN' '$$GRP' '$$PER'" >> "$(STATEDIR)/$$XPKG.cmds";\
	else											\
		echo "ptxd_install_file '$$SRC' '$$DST' '$$OWN' '$$GRP' '$$PER' '$$STRIP'" >> "$(STATEDIR)/$$XPKG.cmds";\
	fi

#
# install_alternative
#
# Installs a file with user/group ownership and permissions via
# fakeroot.
#
# This macro first looks in $(PTXDIST_WORKSPACE)/projectroot for the file to copy and then
# in $(PTXDIST_TOPDIR)/projectroot and installs the file under $(ROOTDIR)
#
# $1: xpkg label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source file
# $6: (strip, obsolete)
# $7: destination (optional)
#
install_alternative =									\
	XPKG=$(subst _,-,$(strip $(1)));						\
	OWN=$(strip $(2));								\
	GRP=$(strip $(3));								\
	PER=$(strip $(4));								\
	FILE=$(strip $(5));								\
	STRIP=$(strip $(6));								\
	DST=$(strip $(7));								\
	$(call install_check, install_alternative);					\
	echo "ptxd_install_alternative '$$FILE' '$$DST' '$$OWN' '$$GRP' '$$PER' '$$STRIP'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_config
#
# Installs a config file with user/group ownership and permissions via
# fakeroot. Adds filename to conffiles
#
# This macro first looks in $(PTXDIST_WORKSPACE)/projectroot for the file to copy and then
# in $(PTXDIST_TOPDIR)/projectroot and installs the file under $(ROOTDIR)
#
# $1: xpkg label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source file
# $6: (strip, obsolete)
# $7: destination (optional)
#
install_config =									\
	XPKG=$(subst _,-,$(strip $(1)));						\
	OWN=$(strip $(2));								\
	GRP=$(strip $(3));								\
	PER=$(strip $(4));								\
	FILE=$(strip $(5));								\
	STRIP=$(strip $(6));								\
	DST=$(strip $(7));								\
	$(call install_check, install_config);						\
	echo "ptxd_install_config '$$FILE' '$$DST' '$$OWN' '$$GRP' '$$PER' '$$STRIP'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_tree
#
# Installs all files and subdirectories with user/group ownership and
# permissions via fakeroot.
#
#
# $1: xpkg label
# $2: OWN, use '-' to use the real UID of each file/directory
# $3: GID, use '-' to use the real GID of each file/directory
# $4: the toplevel directory, or  "-": to use $(PKG_PKGDIR)/$destination
# $5: the target directory.
# $6: strip
#
install_tree =			\
	XPKG=$(subst _,-,$(strip $(1)));	\
	OWN=$(strip $(2));	\
	GRP=$(strip $(3));	\
	DIR=$(strip $(4));	\
	DST=$(strip $(5));	\
	STRIP=$(strip $(6));	\
	$(call install_check, install_tree);	\
	echo "ptxd_install_tree '$$DIR' '$$DST' '$$OWN' '$$GRP' '$$STRIP'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_alternative_tree
#
# Installs all files and subdirectories with user/group ownership and
# permissions via fakeroot.
#
#
# $1: xpkg label
# $2: OWN, use '-' to use the real UID of each file/directory
# $3: GID, use '-' to use the real GID of each file/directory
# $4: the toplevel directory, searched for like install_alternative
# $5: strip
# $6: the target directory (optional)
#
install_alternative_tree =	\
	XPKG=$(subst _,-,$(strip $(1)));	\
	OWN=$(strip $(2));	\
	GRP=$(strip $(3));	\
	DIR=$(strip $(4));	\
	STRIP=$(strip $(5));	\
	DST=$(strip $(6));	\
	$(call install_check, install_alternative_tree);	\
	echo "ptxd_install_alternative_tree '$$DIR' '$$DST' '$$OWN' '$$GRP' '$$STRIP'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_archive
#
# Installs all files and directories in an archive with user/group ownership and
# permissions via fakeroot.
#
#
# $1: xpkg label
# $2: OWN, use '-' to use the real UID of each file/directory
# $3: GID, use '-' to use the real GID of each file/directory
# $4: the archive
# $5: the target directory.
#
install_archive =		\
	XPKG=$(subst _,-,$(strip $(1)));	\
	OWN=$(strip $(2));	\
	GRP=$(strip $(3));	\
	DIR=$(strip $(4));	\
	DST=$(strip $(5));	\
	$(call install_check, install_archive);	\
	echo "ptxd_install_archive '$$DIR' '$$DST' '$$OWN' '$$GRP'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_glob
#
# Installs all files and subdirectories with user/group ownership and
# permissions via fakeroot.
#
#
# $1: xpkg label
# $2: OWN, use '-' to use the real UID of each file/directory
# $3: GID, use '-' to use the real GID of each file/directory
# $4: the toplevel directory, or  "-": to use $(PKG_PKGDIR)/$destination
# $5: the target directory.
# $6: the search patterns for 'find -path'
# $7: the search patterns for '! find -path'
# $8: strip
#
install_glob =			\
	XPKG=$(subst _,-,$(strip $(1)));	\
	OWN=$(strip $(2));	\
	GRP=$(strip $(3));	\
	DIR=$(strip $(4));	\
	DST=$(strip $(5));	\
	YGLOB="$(strip $(6))";	\
	NGLOB="$(strip $(7))";	\
	STRIP=$(strip $(8));	\
	$(call install_check, install_tree);	\
	echo "ptxd_install_glob '$$DIR' '$$DST' '$$YGLOB' '$$NGLOB' '$$OWN' '$$GRP' '$$STRIP'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_spec
#
# Installs files specified by a spec file
# format as defined in linux/Documentation/filesystems/ramfs-rootfs-initramfs.txt
#	file  <name> <location> <mode> <uid> <gid>
#	dir   <name> <mode> <uid> <gid>
#	nod   <name> <mode> <uid> <gid> <dev_type> <maj> <min>
#	slink <name> <target> <mode> <uid> <gid>
#
# $1: xpkg label
# $2: spec file to parse
#
install_spec =			\
	XPKG=$(subst _,-,$(strip $(1)));	\
	SPECFILE=$(strip $(2));	\
	$(call install_check, install_spec);	\
	echo "ptxd_install_spec '$$SPECFILE'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_package
#
# Installs usefull files and directories in an archive with user/group ownership and
# permissions via fakeroot.
# Usefull means binaries, libs + links, etc.
#
#
# $1: xpkg label
# $2: the toplevel directory
#
install_package =		\
	XPKG=$(subst _,-,$(strip $(1)));	\
	$(call install_check, install_package);	\
	echo "ptxd_install_package" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_lib
#
# Installs a library + links in an archive with root/root ownership and
# 0644 permissions via fakeroot.
#
#
# $1: xpkg label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: library name without suffix.
# $6: optional root dir
#
install_lib =			\
	XPKG=$(subst _,-,$(strip $(1)));	\
	OWN="$(strip $(2))";	\
	GRP="$(strip $(3))";	\
	PER="$(strip $(4))";	\
	LIB=$(strip $(5));	\
	DST=$(strip $(6)); \
	$(call install_check, install_lib);	\
	echo "ptxd_install_lib '$$LIB' '$$DST' '$$OWN' '$$GRP' '$$PER'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_replace
#
# Replace placeholder with value in a previously
# installed file
#
# $1: xpkg label
# $2: filename
# $3: placeholder
# $4: value
#
install_replace = \
	XPKG=$(subst _,-,$(strip $(1)));							\
	FILE=$(strip $(2));									\
	PLACEHOLDER=$(strip $(3));								\
	VALUE=$(strip $(4));									\
	$(call install_check, install_replace);							\
	echo "ptxd_install_replace '$$FILE' '$$PLACEHOLDER' '$$VALUE'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_replace_figlet
#
# Replace placeholder with `figlet value` in a previously
# installed file
# Note: packages using this need to select host-figlet!
#
# $1: xpkg label
# $2: filename
# $3: placeholder
# $4: value
# $5: escape mode (empty or 'etcissue')
#
install_replace_figlet = \
	XPKG=$(subst _,-,$(strip $(1)));							\
	FILE=$(strip $(2));									\
	PLACEHOLDER=$(strip $(3));								\
	VALUE=$(strip $(4));									\
	ESCAPEMODE=$(strip $(5));									\
	$(call install_check, install_replace);							\
	echo "ptxd_install_replace_figlet '$$FILE' '$$PLACEHOLDER' '$$VALUE' '$$ESCAPEMODE'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_script_replace
#
# Replace placeholder with value in a script
#
# $1: xpkg label
# $2: script (preinst, postinst, ...)
# $3: placeholder
# $4: value
#
install_script_replace = \
	XPKG=$(subst _,-,$(strip $(1)));							\
	FILE=$(strip $(2));									\
	PLACEHOLDER=$(strip $(3));								\
	VALUE=$(strip $(4));									\
	$(call install_check, install_script_replace);						\
	echo "ptxd_install_script_replace '$$FILE' '$$PLACEHOLDER' '$$VALUE'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_copy_toolchain_lib
#
# $1: xpkg label
# $2: source
# $3: destination
# $4: strip (y|n)	default is to strip
#
install_copy_toolchain_lib =									\
	XPKG=$(subst _,-,$(strip $(1)));							\
	LIB="$(strip $2)";									\
	DST="$(strip $3)";									\
	STRIP="$(strip $4)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	$(call install_check, install_copy_toolchain_lib);					\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${XPKG}" -l "$${LIB}" $${DST} -s "$${STRIP}"

#
# install_copy_toolchain_dl
#
# $1: xpkg label
# $2: strip (y|n)	default is to strip
#
install_copy_toolchain_dl =									\
	XPKG=$(subst _,-,$(strip $(1)));							\
	STRIP="$(strip $2)";									\
	$(call install_check, install_copy_toolchain_dl);					\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${XPKG}" -l LINKER -s "$${STRIP}"

#
# install_copy_toolchain_other
#
# $1: xpkg label
# $2: source
# $3: destination
# $4: strip (y|n)	default is to strip
#
install_copy_toolchain_usr =									\
	XPKG=$(subst _,-,$(strip $(1)));							\
	LIB="$(strip $2)";									\
	DST="$(strip $3)";									\
	STRIP="$(strip $4)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	$(call install_check, install_copy_toolchain_other);					\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${XPKG}" -u "$${LIB}" $${DST} -s "$${STRIP}"

#
# install_link
#
# Installs a soft link in root directory in an xpkg package
#
# $1: xpkg label
# $2: source
# $3: destination
#
install_link =									\
	XPKG=$(subst _,-,$(strip $(1)));					\
	SRC=$(strip $(2));							\
	DST=$(strip $(3));							\
	$(call install_check, install_link);					\
	echo "ptxd_install_link '$$SRC' '$$DST'" >> "$(STATEDIR)/$$XPKG.cmds"

#
# install_node
#
# Installs a device node in root directory in an xpkg package
#
# $1: xpkg label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: type
# $6: major
# $7: minor
# $8: device node name
#
install_node =				\
	XPKG=$(subst _,-,$(strip $(1)));\
	OWN=$(strip $(2));		\
	GRP=$(strip $(3));		\
	PER=$(strip $(4));		\
	TYP=$(strip $(5));		\
	MAJ=$(strip $(6));		\
	MIN=$(strip $(7));		\
	DEV=$(strip $(8));		\
	$(call install_check, install_node);	\
	echo "ptxd_install_node '$$DEV' '$$OWN' '$$GRP' '$$PER' '$$TYP' '$$MAJ' '$$MIN'" >> "$(STATEDIR)/$$XPKG.cmds"

# vim: syntax=make
