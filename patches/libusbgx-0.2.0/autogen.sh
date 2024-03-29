#!/bin/bash

set -e

aclocal $ACLOCAL_FLAGS

libtoolize \
	--force \
	--copy

autoreconf \
	--force \
	--install \
	--warnings=syntax \
	--warnings=obsolete \
	--warnings=unsupported
