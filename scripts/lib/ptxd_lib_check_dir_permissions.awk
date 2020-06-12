#!/usr/bin/awk -f

BEGIN {
	FS = "\x1F";
}

FNR == 1 {
	pkg = gensub(/.*\/(.*).perms/, "\\1", 1, FILENAME)
}

function check(path, perm, implicit) {
	if ((path in perms) && (perms[path] != perm)) {
		if (implicit && (pkg == names[path]))
			return;
		print("\nIncompatible ownership or permissions for '" path "':")
		print(names[path] ": " perms[path] (imp[path] ? " (implicit from " imp[path]")" : ""))
		print(pkg ": " perm (implicit ? " (implicit)" : ""))
		print("\nOne of these packages must be fixed!\n")
		exit 1
	}
	names[path] = pkg
	perms[path] = perm
	imp[path] = implicit
}

function check_parents(base) {
	path = base
	while (1) {
		path = gensub(/\/[^/]*$/,"",1,path)
		if (path == "")
			break;
		check(path, "0.0 0755", base)
	}
}

$1 ~ "d" {
	path = gensub(/\/$/,"",1,$2)
	perm = $3 "." $4 " " $5
	check(path, perm, "")
	check_parents(path)
}

$1 ~ "f" {
	path = $2
	check_parents(path)
}
