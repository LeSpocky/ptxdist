#
# SYNOPSIS
#
#   AX_DETECT_ARMV8([ACTION-IF-ARMv8],[ACTION-IF-NO-ARMv8])
#
# DESCRIPTION
#
#   AX_DETECT_ARMV8 detects from the compiler settings if the target is of
#   type ARMv8. It is intended mostly for cross compiling to be able to collect
#   more information about the target architecture and features. The user can
#   overwrite the detection by using the option --enable-armv8core or
#   --disable-armv8core.
#   It works by detecting the compiler's macro __ARM_ARCH=8 and __ARM_ARCH_8A.
#   These are set in gcc compilers when they are configured to create code for
#   ARMv8 cores.
#   This macro cannot detect the correct target's features if the compiler is
#   not correctly configured to reflect the target's features.
#
# LICENSE
#
#   Copyright (c) 2019 Juergen Borleis <jbe@pengutronix.de>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

AC_DEFUN([AX_DETECT_ARMV8],
	[AC_REQUIRE([AC_PROG_CC])
dnl
dnl Give the user the possibility to overwrite the auto detection
dnl
	AC_ARG_ENABLE([armv8core],
		[AS_HELP_STRING([--enable-armv8core],
			[Enable optimizations for ARMv8 cores @<:@default=auto@:>@])],
		[ax_armv8core="${enableval}"],
		[ax_armv8core=auto])

	AC_CACHE_CHECK([for ARMv8 target core], [ax_cv_armv8core],
		[ax_cv_armv8core=${ax_armv8core}])
dnl	AC_MSG_RESULT([${ax_cv_armv8core}])

	if test "x${ax_cv_armv8core}" = "xauto"; then
		if test "x$GCC" != "xyes"; then
dnl only for GCC we know it works in this way
			AC_MSG_ERROR([Cannot autodetect the architecture for non GCC compilers])
		else
			AC_MSG_CHECKING(if target's core is of type ARMv8)
			AC_COMPILE_IFELSE(
				[AC_LANG_PROGRAM([[]],
					[[
#undef THIS_IS_V8
#if __ARM_ARCH==8  || defined(__ARM_ARCH_8A__)
# define THIS_IS_V8 1
#endif
int foo = THIS_IS_V8;
					]]) dnl AC_LANG_PROGRAM
				],
				[ax_cv_armv8core=yes],
				[ax_cv_armv8core=no],
				[ARMv8 core]); dnl AC_COMPILE_IFELSE
			AC_MSG_RESULT([${ax_cv_armv8core}]);
		fi
	fi

	case "x${ax_cv_armv8core}" in
	"xyes")
		$1
		;;
	"xno")
		$2
		;;
	*)
		AC_MSG_ERROR([Unknown setting for ARMv8 architecture: '${ax_cv_armv8core}'.])
		;;
	esac
]) dnl AC_DEFUN
