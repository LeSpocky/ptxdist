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

$1 == "DEPS:" {
	pkg = $2
	$1 = $2 = ""
	deps[pkg] = $0
}

function read_file(src, data, pkg, tmp) {
	if (!src)
		return

	old_RS = RS
	RS = "^$"
	getline tmp < src
	RS = old_RS
	close(src)
	data[pkg] = data[pkg] tmp "\n"
}

END {
	for (pkg in rules) {
		f1 = PTXDIST_TEMPDIR "/pkghash-" pkg
		f2 = PTXDIST_TEMPDIR "/pkghash-" pkg "_EXTRACT"
		old_RS = RS
		RS = "^$"
		getline tmp < f1
		data[pkg] = tmp
		getline tmp < f2
		extract_data[pkg] = tmp
		RS = old_RS
		close(f1)
		close(f2)
	}
	for (pkg in rules) {
		n = split(rules[pkg], cfgs)
		for (rule = 1; rule <= n; rule++)
			read_file(cfgs[rule], data, pkg)
	}
	for (pkg in configs) {
		config = configs[pkg]
		n = split(configs[pkg], cfgs)
		for (config = 1; config <= n; config++)
			read_file(cfgs[config], data, pkg)
	}
	if (dirs == "")
		exit;
	n = split(dirs, dir_array, " ");
	asort(dir_array);
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
		asort(file_list)
		for (j in list) {
			pkg = list[j]
			for (i = 1; i <= n; i++) {
				file = dir "/" file_list[i]
				read_file(file, extract_data, pkg)
			}
		}
	}
	for (pkg in rules) {
		f1 = PTXDIST_TEMPDIR "/pkghash-" pkg
		f2 = PTXDIST_TEMPDIR "/pkghash-" pkg "_EXTRACT"
		print data[pkg] extract_data[pkg] > f1
		print extract_data[pkg] > f2
		m = split(deps[pkg], list, " ");
		for (j in list) {
			dep = list[j]
			if (match(dep, /^HOST_SYSTEM_/))
				continue
			print data[dep] extract_data[dep] >> f1
		}
		close(f1)
		close(f2)
	}
}
