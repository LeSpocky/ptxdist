#!/usr/bin/gawk -f
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

BEGIN {
	PTXDIST_TEMPDIR		= ENVIRON["PTXDIST_TEMPDIR"];
	dirs = ""
}

$1 == "PATCHES:" {
	pkg = $2
	patch_dir = $3
	pkgs[patch_dir]  = pkgs[patch_dir] " " pkg
	dirs = dirs " " patch_dir
}

$1 == "CONFIG:" {
	pkg = $2
	config = $3
	configs[pkg] = configs[pkg] " " config
}

$1 == "RULES:" {
	pkg = $2
	rule = $3
	rules[pkg] = rules[pkg] " " rule
}

function dump_file(src, dst, tmp) {
	if (!src)
		return

	old_RS = RS
	RS = "^$"
	getline tmp < src
	printf "%s", tmp >> dst
	RS = old_RS
	close(src)
	close(dst)
}

END {
	for (pkg in rules) {
		f1 = PTXDIST_TEMPDIR "/pkghash-" pkg
		n = split(rules[pkg], cfgs)
		for (rule = 1; rule <= n; rule++) {
			dump_file(cfgs[rule], f1)
			printf "\n" >> f1
		}
	}
	for (pkg in configs) {
		config = configs[pkg]
		f1 = PTXDIST_TEMPDIR "/pkghash-" pkg
		n = split(configs[pkg], cfgs)
		for (config = 1; config <= n; config++)
			dump_file(cfgs[config], f1)
	}
	if (dirs == "")
		exit;
	n = split(dirs, dir_array, " ");
	asort(dir_array, dir_array);
	dirs = ""
	last = ""
	for (i = 1; i <= n; i++) {
		if (dir_array[i] != last)
			dirs = dirs " " dir_array[i]
		last = dir_array[i]
	}
	command = "find -L " dirs " -type f ! -name '.*' -printf '%H %P\\n'"
	while (command | getline)
		files[$1] = files[$1] " " $2
	close(command)
	for (dir in pkgs) {
		split(pkgs[dir], list, " ")
		n = split(files[dir], file_list, " ")
		asort(file_list, file_list)
		for (pkg in list) {
			pkg = list[pkg]
			f1 = PTXDIST_TEMPDIR "/pkghash-" pkg
			f2 = PTXDIST_TEMPDIR "/pkghash-" pkg "_EXTRACT"
			for (i = 1; i <= n; i++) {
				file = dir "/" file_list[i]
				dump_file(file, f1)
				dump_file(file, f2)
			}
		}
	}
}
