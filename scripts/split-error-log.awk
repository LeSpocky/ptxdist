#!/usr/bin/awk -f

BEGIN {
	stages = " "
}

/^target: / {
	n = split(stages, l, " ")
	for (i = 1; i <= n; i++) {
		switch (l[i]) {
			case /.*\.(get|extract|prepare|compile|install|targetinstall|urlcheck|srchash|cfghash)(.[a-z]+)?/:
				break
			# other stuff, such as archive downloads may not have a explicit end
			# so stop them when the next target starts
			default:
				drop(l[i])
				break
		}
	}
	stages = stages $2 " "
	cache[$2][0] = last
}

function drop(stage) {
	delete cache[stage]
	do {
		old = stages
		stages = gensub(" " stage " ", " ", "g", stages)
	} while (old != stages)
}

/\<finished target / {
	drop($NF)
}

{
	n = split(stages, l, " ")
	for (i = 1; i <= n; i++) {
		if (l[i] in cache) {
			j = length(cache[l[i]])
			cache[l[i]][j] = $0
		}
	}
	last = $0
}

/.*platform.*\/(state|images)\/.*\..*\] Error [1-9][0-9]*$/ {
	stage = gensub(/.*\/(state|images)\/(.+\..+)\] Error.*/, "\\2", 1, $0)
	targetfile = FILENAME "." stage ".txt"

	if (!(stage in cache))
		print "Found error without target for", stage
	else {
		print targetfile

		len = length(cache[stage])
		for (i = 0; i < len; i++) {
			print cache[stage][i] >> targetfile
		}
		close(targetfile)

		drop(stage)
	}
}

/^({{{|}})/ {
	for (stage in cache)
		drop(stage)
}
