# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


define ptx/error
$(shell ptxd_make_log_error $(PTXDIST_TEMPDIR)/make-errors '$(lastword $(MAKEFILE_LIST))' '$(strip $(1))')
endef

define ptx/have-errors
$(wildcard $(PTXDIST_TEMPDIR)/make-errors)
endef

define ptx/report-errors
$(shell ptxd_make_report_errors $(PTXDIST_TEMPDIR)/make-errors)
endef

# vim: syntax=make
