#!/bin/bash

NAME="${1}"
if [ -z "$NAME" ]; then
	echo -n "project name: "
	read NAME
fi
NAME_UP="$(echo $NAME | tr '[a-z-]' '[A-Z_]')"

mv "@name@.c" "${NAME}.c"

for i in \
	configure.ac \
	link.ld \
	Makefile.in \
	"${NAME}.c" \
; do
	sed -i -e "s/\@name\@/${NAME}/g" \
	       -e "s/\@NAME\@/${NAME_UP}/g" $i
done

