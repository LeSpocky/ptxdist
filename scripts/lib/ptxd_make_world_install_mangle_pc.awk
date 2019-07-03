#!/usr/bin/gawk -f
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

BEGIN {
	FS = "([[:space:]]|=)[[:space:]]*";

	SYSROOT	= ENVIRON["pkg_sysroot_dir"];
	pkg_pkg_dir = ENVIRON["pkg_pkg_dir"];

	# quote "+" and "/"
	q_pkg_pkg_dir = gensub(/([+/])/, "\\\\\\1", "g", ENVIRON["pkg_pkg_dir"]);

	replace["prefix"]	= "${pcfiledir}/../..";
	replace["exec_prefix"]	= "${prefix}";
	replace["libdir"]	= "${prefix}/lib";
	replace["includedir"]	= "${prefix}/include";

	replace[SYSROOT "/include"]	= replace["includedir"]
	replace[SYSROOT "/lib"]		= replace["libdir"]
}


FNR == 1 {
	this_regex = "^" q_pkg_pkg_dir "(.*)lib\\/pkgconfig\\/.*";

	#
	# first remove pkg_pkg_dir
	#
	prefix = gensub(this_regex, "\\1", 1, FILENAME);
	replace[prefix "include"] = replace["includedir"];
	replace[prefix "lib"]     = replace["libdir"];

	rel_sysroot = replace["prefix"] gensub(/\/[^/]+/, "/..", "g", prefix);


	# delete file, in order to rename "in-place"
	system("rm " FILENAME);
}

$1 ~ /^(prefix|exec_prefix)$/ {
	print $1 "=" replace[$1]				> FILENAME;
	next;
}

$1 ~ /^(includedir|libdir)$/ {
	# replace e.g. /usr/include
	if (match($2, "^" "(" pkg_pkg_dir "|" SYSROOT ")?" "(" prefix "(include|lib)" ")", groups)) {
		sub(groups[0], replace[groups[2]]);
	}

	print $0						> FILENAME;
	next;
}


$1 ~ /^(Libs(\.private)?|Cflags):$/ {
	this_regex = "(-[LI])(" SYSROOT "|" pkg_pkg_dir")/";

	#
	# replace absolute path by relative ones
	#
	print gensub(this_regex, "\\1" rel_sysroot, "g")	> FILENAME;
	next;
}

{
	print $0						> FILENAME;
}
