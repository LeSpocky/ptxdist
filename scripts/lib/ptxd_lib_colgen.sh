#!/bin/bash

ptxd_colgen_generate_sections()
{
    #
    # "ptxdist -q allyesconfig" collection gives an empty collection
    # ignore the '-q' option to get a valid collection.
    #
    unset PTXDIST_QUIET
    ptxd_make_log "print-PACKAGES-m" "print-CROSS_PACKAGES-m" "print-HOST_PACKAGES-m" | gawk '
	BEGIN {
		FS = "=\"|\"|=";
		col_in     = "'"${PTX_KGEN_DIR}"'" "/generated/ptx_collection.in";
	}

	$1 ~ /^PTX_MAP_TO_package/ {
		pkg = gensub(/PTX_MAP_TO_package_/, "", "g", $1);
		pkgs[$2] = pkg;

		next;
	}

	$1 ~ /^PTX_MAP_._DEP/ {
		pkg = gensub(/PTX_MAP_._DEP_/, "", "g", $1);
		deps[pkg] = deps[pkg] " " $2;

		next;
	}

	$1 ~ /^[a-z0-9]+/ {
		n = split($1, module, " ");
		for (i = 1; i <= n; i++) {
#			print "module: " module[i] ", pkg: " pkgs[module[i]] ", deps: " deps[pkgs[module[i]]];
			module_pkgs[pkgs[module[i]]] = module[i];
		}

		next;
	}

	END {
		n = asorti(module_pkgs, sorted);

		printf "" > col_in;

		for (i = 1; i <= n; i++) {
			pkg = sorted[i];
			pkg_lc = module_pkgs[pkg];

			if (pkg_lc ~ /^host-|cross-/)
				prompt = ""
			else
				prompt = "\tprompt \"" pkg_lc "\" if COLLECTION_MANUAL\n"

			printf \
				"config " pkg "\n"\
				"\t"	"bool\n"\
				prompt\
				"\t"	"default COLLECTION_ALL\n"	> col_in;


			m = split(deps[pkg], dep, " ");
			asort(dep, sdep);
			last = "";
			for (j = 1; j <= m; j++) {
				if (sdep[j] in module_pkgs && sdep[j] != last )
					print "\tselect " sdep[j]	> col_in;
				last = sdep[j]
			}

			printf "\n"					> col_in;
		}
		close(col_in);
	}

    ' \
	"${PTX_MAP_ALL}" \
	"${PTX_MAP_DEPS}" \
	-
    check_pipe_status
}


ptxd_colgen()
{
    mkdir -p "${PTX_KGEN_DIR}/collection" &&
    ptxd_colgen_generate_sections
}
