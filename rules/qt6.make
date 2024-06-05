# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QT6) += qt6

#
# Paths and names
#
QT6_VERSION		:= 6.6.2
QT6_MD5			:= b92112e12298f4b27050ef7060658191
QT6			:= qt-everywhere-src-$(QT6_VERSION)
QT6_SUFFIX		:= tar.xz
QT6_URL			:= \
	http://download.qt-project.org/archive/qt/$(basename $(QT6_VERSION))/$(QT6_VERSION)/single/$(QT6).$(QT6_SUFFIX) \
	http://download.qt-project.org/development_releases/qt/$(basename $(QT6_VERSION))/$(QT6_VERSION)/single/$(QT6).$(QT6_SUFFIX)
QT6_SOURCE		:= $(SRCDIR)/$(QT6).$(QT6_SUFFIX)
QT6_DIR			:= $(realpath $(BUILDDIR))/$(QT6)
QT6_BUILD_OOT		:= YES
# "GPL-3.0-only WITH Qt-GPL-exception-1.0" for tools
# "GFDL-1.3-no-invariants-only" for documentation
QT6_LICENSE		:= (LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only) AND (GPL-3.0-only WITH Qt-GPL-exception-1.0) AND GFDL-1.3-no-invariants-only
QT6_LICENSE_FILES	:= \
	file://qtbase/LICENSES/GPL-2.0-only.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://qtbase/LICENSES/GPL-3.0-only.txt;md5=d32239bcb673463ab874e80d47fae504 \
	file://qtbase/LICENSES/Qt-GPL-exception-1.0.txt;md5=9a13522cd91a88fba784baf16ea66af8 \
	file://qtbase/LICENSES/LGPL-3.0-only.txt;md5=e6a600fd5e1d9cbde2d983680233ad02 \
	file://qtbase/LICENSES/GFDL-1.3-no-invariants-only.txt;md5=a22d0be1ce2284b67950a4d1673dd1b0
QT6_MKSPECS		:= $(call ptx/get-alternative, config/qt6, linux-ptx-g++)

ifdef PTXCONF_QT6
ifeq ($(strip $(QT6_MKSPECS)),)
$(call ptx/error, Qt6 mkspecs are missing)
endif
endif

# QtWebengine is not supported on PPC
ifdef PTXCONF_ARCH_PPC
PTXCONF_QT6_MODULE_QTWEBENGINE :=
PTXCONF_QT6_MODULE_QTWEBENGINE_WIDGETS :=
PTXCONF_QT6_MODULE_QTWEBVIEW :=
endif

# QtWebengine is not supported on 32-bit x86
ifdef PTXCONF_ARCH_X86
ifndef PTXCONF_ARCH_X86_64
PTXCONF_QT6_MODULE_QTWEBENGINE :=
PTXCONF_QT6_MODULE_QTWEBENGINE_WIDGETS :=
PTXCONF_QT6_MODULE_QTWEBVIEW :=
endif
endif

# QtWebEngine needs at least ARMv6
ifdef PTXCONF_ARCH_ARM
ifndef PTXCONF_ARCH_ARM_V6
PTXCONF_QT6_MODULE_QTWEBENGINE :=
PTXCONF_QT6_MODULE_QTWEBENGINE_WIDGETS :=
PTXCONF_QT6_MODULE_QTWEBVIEW :=
endif
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# the extra section seems to confuse the Webkit JIT code
QT6_WRAPPER_BLACKLIST := \
	TARGET_COMPILER_RECORD_SWITCHES

QT6_CONF_ENV := \
	$(CROSS_ENV) \
	COMPILER_PREFIX=$(COMPILER_PREFIX)

ifdef PTXCONF_QT6_MODULE_QTWEBENGINE
QT6_CONF_ENV += \
	PKG_CONFIG_HOST=$(PTXDIST_SYSROOT_HOST)/usr/bin/pkg-config \
	PTX_CMAKE_CFLAGS="$(filter -m%,$(shell ptxd_cross_cc_v | sed -n -e "s/'//g" -e "/^COLLECT_GCC_OPTIONS=/{s/[^=]*=\(.*\)/\1/p;q}"))"
endif

QT6_MODULES-y						:=
QT6_MODULES-						:=
QT6_MODULES-$(PTXCONF_QT6_MODULE_QT3D)			+= qt3d
QT6_MODULES-$(PTXCONF_QT6_MODULE_QT5COMPAT)		+= qt5compat
QT6_MODULES-						+= qtactiveqt
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTBASE)		+= qtbase
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTCHARTS)		+= qtcharts
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTCOAP)		+= qtcoap
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTCONNECTIVITY)	+= qtconnectivity
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTDATAVIS3D)		+= qtdatavis3d
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)		+= qtdeclarative
QT6_MODULES-						+= qtgrpc
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTGRAPHS)		+= qtgraphs
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTHTTPSERVER)		+= qthttpserver
QT6_MODULES-						+= qtdoc
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTIMAGEFORMATS)	+= qtimageformats
QT6_MODULES-						+= qtlanguageserver
QT6_MODULES-						+= qtlocation
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTLOTTIE)		+= qtlottie
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTMQTT)		+= qtmqtt
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTMULTIMEDIA)		+= qtmultimedia
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTNETWORKAUTH)		+= qtnetworkauth
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTOPCUA)		+= qtopcua
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTPOSITIONING)		+= qtpositioning
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTQUICK3D)		+= qtquick3d
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTQUICK3DPHYSICS)	+= qtquick3dphysics
QT6_MODULES-						+= qtquickeffectmaker
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTQUICKTIMELINE)	+= qtquicktimeline
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTREMOTEOBJECTS)	+= qtremoteobjects
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTSCXML)		+= qtscxml
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTSENSORS)		+= qtsensors
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTSERIALBUS)		+= qtserialbus
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTSERIALPORT)		+= qtserialport
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTSHADERTOOLS)		+= qtshadertools
QT6_MODULES-						+= qtspeech
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTSVG)			+= qtsvg
QT6_MODULES-						+= qttools
QT6_MODULES-						+= qttranslations
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTVIRTUALKEYBOARD)	+= qtvirtualkeyboard
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTWAYLAND)		+= qtwayland
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTWEBCHANNEL)		+= qtwebchannel
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTWEBENGINE)		+= qtwebengine
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTWEBSOCKETS)		+= qtwebsockets
QT6_MODULES-$(PTXCONF_QT6_MODULE_QTWEBVIEW)		+= qtwebview

#
# cmake
#
QT6_CONF_OPT := \
	-DQT_HOST_PATH=$(PTXDIST_SYSROOT_HOST)/usr \
	-DBUILD_SHARED_LIBS=ON \
	$(foreach module,$(QT6_MODULES-y),-DBUILD_$(module)=ON) \
	$(foreach module,$(QT6_MODULES-),-DBUILD_$(module)=OFF) \
	-DQT_BUILD_SUBMODULES="$(subst $(space),;,$(sort $(QT6_MODULES-) $(QT6_MODULES-y)))" \
	-DINSTALL_ARCHDATADIR=lib/qt6 \
	-DINSTALL_DATADIR=share/qt6 \
	-DINSTALL_EXAMPLESDIR=lib/qt6/examples \
	-DINSTALL_INCLUDEDIR=include/qt6 \
	-DINSTALL_MKSPECSDIR=lib/qt6/mkspecs

ifdef PTXCONF_QT6_MODULE_QTBASE
QT6_CONF_OPT += \
	-DFEATURE_accessibility=$(call ptx/onoff,PTXCONF_QT6_ACCESSIBILITY) \
	-DFEATURE_accessibility_atspi_bridge=OFF \
	-DFEATURE_action=ON \
	-DFEATURE_animation=ON \
	-DFEATURE_appstore_compliant=OFF \
	-DFEATURE_backtrace=OFF \
	-DFEATURE_brotli=OFF \
	-DFEATURE_cborstreamreader=ON \
	-DFEATURE_cborstreamwriter=ON \
	-DFEATURE_ccache=OFF \
	-DFEATURE_clipboard=ON \
	-DFEATURE_colornames=ON \
	-DFEATURE_commandlineparser=ON \
	-DFEATURE_concatenatetablesproxymodel=ON \
	-DFEATURE_concurrent=ON \
	-DFEATURE_cross_compile=ON \
	-DFEATURE_cssparser=ON \
	-DFEATURE_cursor=ON \
	-DFEATURE_datestring=ON \
	-DFEATURE_datetimeparser=ON \
	-DFEATURE_dbus=$(call ptx/onoff,PTXCONF_QT6_DBUS) \
	-DFEATURE_dbus_linked=$(call ptx/onoff,PTXCONF_QT6_DBUS) \
	-DFEATURE_debug=OFF \
	-DFEATURE_debug_and_release=OFF \
	-DFEATURE_desktopservices=ON \
	-DFEATURE_developer_build=OFF \
	-DFEATURE_directfb=OFF \
	-DFEATURE_dlopen=ON \
	-DFEATURE_dnslookup=ON \
	-DFEATURE_dom=ON \
	-DFEATURE_doubleconversion=ON \
	-DFEATURE_draganddrop=ON \
	-DFEATURE_drm_atomic=ON \
	-DFEATURE_dtls=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_dynamicgl=OFF \
	-DFEATURE_easingcurve=ON \
	-DFEATURE_egl=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_egl_x11=OFF \
	-DFEATURE_eglfs=$(call ptx/onoff,PTXCONF_QT6_PLATFORM_EGLFS) \
	-DFEATURE_eglfs_brcm=OFF \
	-DFEATURE_eglfs_egldevice=OFF \
	-DFEATURE_eglfs_gbm=$(call ptx/onoff,PTXCONF_QT6_PLATFORM_EGLFS) \
	-DFEATURE_eglfs_mali=OFF \
	-DFEATURE_eglfs_openwfd=OFF \
	-DFEATURE_eglfs_rcar=OFF \
	-DFEATURE_eglfs_viv=OFF \
	-DFEATURE_eglfs_viv_wl=OFF \
	-DFEATURE_eglfs_vsp2=OFF \
	-DFEATURE_eglfs_x11=OFF \
	-DFEATURE_enable_gdb_index=OFF \
	-DFEATURE_etw=OFF \
	-DFEATURE_evdev=$(call ptx/onoff,PTXCONF_QT6_INPUT_EVDEV) \
	-DFEATURE_f16c=OFF \
	-DFEATURE_filesystemiterator=ON \
	-DFEATURE_filesystemmodel=ON \
	-DFEATURE_filesystemwatcher=ON \
	-DFEATURE_fontconfig=$(call ptx/onoff,PTXCONF_QT6_GUI) \
	-DFEATURE_force_asserts=OFF \
	-DFEATURE_force_debug_info=OFF \
	-DFEATURE_framework=OFF \
	-DFEATURE_freetype=$(call ptx/onoff,PTXCONF_QT6_GUI) \
	-DFEATURE_future=ON \
	-DFEATURE_gbm=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_gc_binaries=OFF \
	-DFEATURE_gestures=ON \
	-DFEATURE_gif=$(call ptx/onoff,PTXCONF_QT6_GIF) \
	-DFEATURE_glib=$(call ptx/onoff,PTXCONF_QT6_GLIB) \
	-DFEATURE_glibc=ON \
	-DFEATURE_gssapi=OFF \
	-DFEATURE_gui=$(call ptx/onoff,PTXCONF_QT6_GUI) \
	-DFEATURE_harfbuzz=$(call ptx/onoff,PTXCONF_QT6_GUI) \
	-DFEATURE_headersclean=OFF \
	-DFEATURE_highdpiscaling=ON \
	-DFEATURE_hijricalendar=ON \
	-DFEATURE_http=ON \
	-DFEATURE_ico=ON \
	-DFEATURE_icu=$(call ptx/onoff,PTXCONF_QT6_ICU) \
	-DFEATURE_identityproxymodel=ON \
	-DFEATURE_im=ON \
	-DFEATURE_image_heuristic_mask=ON \
	-DFEATURE_image_text=ON \
	-DFEATURE_imageformat_bmp=ON \
	-DFEATURE_imageformat_jpeg=$(call ptx/onoff,PTXCONF_QT6_LIBJPEG) \
	-DFEATURE_imageformat_png=$(call ptx/onoff,PTXCONF_QT6_LIBPNG) \
	-DFEATURE_imageformat_ppm=ON \
	-DFEATURE_imageformat_xbm=ON \
	-DFEATURE_imageformat_xpm=ON \
	-DFEATURE_imageformatplugin=ON \
	-DFEATURE_imageio_text_loading=ON \
	-DFEATURE_inotify=ON \
	-DFEATURE_integrityfb=OFF \
	-DFEATURE_integrityhid=OFF \
	-DFEATURE_islamiccivilcalendar=ON \
	-DFEATURE_itemmodel=ON \
	-DFEATURE_itemmodeltester=OFF \
	-DFEATURE_jalalicalendar=ON \
	-DFEATURE_journald=$(call ptx/onoff,PTXCONF_QT6_JOURNALD) \
	-DFEATURE_jpeg=$(call ptx/onoff,PTXCONF_QT6_LIBJPEG) \
	-DFEATURE_kms=ON \
	-DFEATURE_largefile=$(call ptx/onoff,PTXCONF_GLOBAL_LARGE_FILE) \
	-DFEATURE_libinput=$(call ptx/onoff,PTXCONF_QT6_INPUT_LIBINPUT) \
	-DFEATURE_libproxy=OFF \
	-DFEATURE_library=ON \
	-DFEATURE_libudev=$(call ptx/onoff,PTXCONF_QT6_LIBUDEV) \
	-DFEATURE_linux_netlink=ON \
	-DFEATURE_linuxfb=$(call ptx/onoff,PTXCONF_QT6_PLATFORM_LINUXFB) \
	-DFEATURE_localserver=ON \
	-DFEATURE_lttng=OFF \
	-DFEATURE_macdeployqt=OFF \
	-DFEATURE_mimetype=ON \
	-DFEATURE_mimetype_database=ON \
	-DFEATURE_movie=ON \
	-DFEATURE_msvc_obj_debug_info=OFF \
	-DFEATURE_mtdev=OFF \
	-DFEATURE_multiprocess=ON \
	-DFEATURE_network=ON \
	-DFEATURE_networkdiskcache=ON \
	-DFEATURE_networkinterface=ON \
	-DFEATURE_networklistmanager=OFF \
	-DFEATURE_networkproxy=ON \
	-DFEATURE_no_prefix=OFF \
	-DFEATURE_ocsp=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_opengl=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_opengl_desktop=OFF \
	-DFEATURE_opengl_dynamic=OFF \
	-DFEATURE_opengles2=ON \
	-DFEATURE_opengles3=OFF \
	-DFEATURE_opengles31=OFF \
	-DFEATURE_opengles32=OFF \
	-DFEATURE_openssl=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_openssl_hash=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_openssl_linked=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_openssl_runtime=OFF \
	-DFEATURE_opensslv11=OFF \
	-DFEATURE_opensslv30=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_openvg=OFF \
	-DFEATURE_optimize_debug=OFF \
	-DFEATURE_optimize_full=OFF \
	-DFEATURE_optimize_size=OFF \
	-DFEATURE_pcre2=ON \
	-DFEATURE_pdf=ON \
	-DFEATURE_permissions=OFF \
	-DFEATURE_picture=ON \
	-DFEATURE_pkg_config=ON \
	-DFEATURE_png=$(call ptx/onoff,PTXCONF_QT6_LIBPNG) \
	-DFEATURE_printsupport=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTBASE_PRINT) \
	-DFEATURE_private_tests=OFF \
	-DFEATURE_process=ON \
	-DFEATURE_processenvironment=ON \
	-DFEATURE_proxymodel=ON \
	-DFEATURE_publicsuffix_qt=ON \
	-DFEATURE_publicsuffix_system=ON \
	-DFEATURE_qmake=ON \
	-DFEATURE_qreal=OFF \
	-DFEATURE_raster_64bit=ON \
	-DFEATURE_raster_fp=ON \
	-DFEATURE_reduce_exports=ON \
	-DFEATURE_regularexpression=ON \
	-DFEATURE_relocatable=OFF \
	-DFEATURE_rpath=OFF \
	-DFEATURE_sanitize_address=OFF \
	-DFEATURE_sanitize_fuzzer_no_link=OFF \
	-DFEATURE_sanitize_memory=OFF \
	-DFEATURE_sanitize_thread=OFF \
	-DFEATURE_sanitize_undefined=OFF \
	-DFEATURE_sanitizer=OFF \
	-DFEATURE_schannel=OFF \
	-DFEATURE_sctp=OFF \
	-DFEATURE_securetransport=OFF \
	-DFEATURE_separate_debug_info=OFF \
	-DFEATURE_sessionmanager=OFF \
	-DFEATURE_settings=ON \
	-DFEATURE_shared=ON \
	-DFEATURE_sharedmemory=ON \
	-DFEATURE_shortcut=ON \
	-DFEATURE_signaling_nan=ON \
	-DFEATURE_simulator_and_device=OFF \
	-DFEATURE_slog2=OFF \
	-DFEATURE_socks5=ON \
	-DFEATURE_sortfilterproxymodel=ON \
	-DFEATURE_sql=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTBASE_SQL) \
	-DFEATURE_sql_db2=OFF \
	-DFEATURE_sql_ibase=OFF \
	-DFEATURE_sql_mimer=OFF \
	-DFEATURE_sql_mysql=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTBASE_SQL_MYSQL) \
	-DFEATURE_sql_oci=OFF \
	-DFEATURE_sql_odbc=OFF \
	-DFEATURE_sql_psql=OFF \
	-DFEATURE_sql_sqlite=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTBASE_SQL_SQLITE) \
	-DFEATURE_sqlmodel=ON \
	-DFEATURE_ssl=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_sspi=OFF \
	-DFEATURE_stack_protector_strong=OFF \
	-DFEATURE_standarditemmodel=ON \
	-DFEATURE_static=OFF \
	-DFEATURE_stdlib_libcpp=OFF \
	-DFEATURE_stringlistmodel=ON \
	-DFEATURE_syslog=OFF \
	-DFEATURE_system_doubleconversion=OFF \
	-DFEATURE_system_freetype=$(call ptx/onoff,PTXCONF_QT6_GUI) \
	-DFEATURE_system_harfbuzz=$(call ptx/onoff,PTXCONF_QT6_GUI) \
	-DFEATURE_system_jpeg=$(call ptx/onoff,PTXCONF_QT6_LIBJPEG) \
	-DFEATURE_system_libb2=OFF \
	-DFEATURE_system_pcre2=ON \
	-DFEATURE_system_png=$(call ptx/onoff,PTXCONF_QT6_LIBPNG) \
	-DFEATURE_system_proxies=ON \
	-DFEATURE_system_sqlite=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTBASE_SQL_SQLITE) \
	-DFEATURE_system_textmarkdownreader=OFF \
	-DFEATURE_system_zlib=ON \
	-DFEATURE_systemtrayicon=ON \
	-DFEATURE_tabletevent=ON \
	-DFEATURE_temporaryfile=ON \
	-DFEATURE_testcocoon=OFF \
	-DFEATURE_testlib=$(call ptx/onoff,PTXCONF_QT6_TEST) \
	-DFEATURE_testlib_selfcover=OFF \
	-DFEATURE_textdate=ON \
	-DFEATURE_texthtmlparser=ON \
	-DFEATURE_textmarkdownreader=OFF \
	-DFEATURE_textmarkdownwriter=OFF \
	-DFEATURE_textodfwriter=ON \
	-DFEATURE_thread=ON \
	-DFEATURE_timezone=ON \
	-DFEATURE_topleveldomain=ON \
	-DFEATURE_translation=ON \
	-DFEATURE_transposeproxymodel=ON \
	-DFEATURE_tslib=OFF \
	-DFEATURE_tuiotouch=ON \
	-DFEATURE_udpsocket=ON \
	-DFEATURE_undocommand=ON \
	-DFEATURE_undogroup=ON \
	-DFEATURE_undostack=ON \
	-DFEATURE_valgrind=OFF \
	-DFEATURE_validator=ON \
	-DFEATURE_vkgen=OFF \
	-DFEATURE_vkkhrdisplay=OFF \
	-DFEATURE_vnc=OFF \
	-DFEATURE_vsp2=OFF \
	-DFEATURE_vulkan=OFF \
	-DFEATURE_whatsthis=ON \
	-DFEATURE_wheelevent=ON \
	-DFEATURE_widgets=$(call ptx/onoff,PTXCONF_QT6_WIDGETS) \
	-DFEATURE_windeployqt=OFF \
	-DFEATURE_xcb=OFF \
	-DFEATURE_xcb_xlib=OFF \
	-DFEATURE_xkbcommon=$(call ptx/onoff,PTXCONF_QT6_LIBXKBCOMMON) \
	-DFEATURE_xkbcommon_x11=OFF \
	-DFEATURE_xlib=OFF \
	-DFEATURE_xml=ON \
	-DFEATURE_xmlstream=ON \
	-DFEATURE_xmlstreamreader=ON \
	-DFEATURE_xmlstreamwriter=ON \
	-DFEATURE_zstd=OFF \
	-DQT_ALLOW_DOWNLOAD=OFF \
	-DQT_BUILD_BENCHMARKS=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_EXAMPLES_AS_EXTERNAL=OFF \
	-DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF \
	-DQT_BUILD_MANUAL_TESTS=OFF \
	-DQT_BUILD_MINIMAL_STATIC_TESTS=OFF \
	-DQT_BUILD_TESTS=OFF \
	-DQT_BUILD_TESTS_BY_DEFAULT=OFF \
	-DQT_BUILD_TOOLS_BY_DEFAULT=OFF \
	-DQT_CMAKE_DEBUG_EXTEND_TARGET=OFF \
	-DQT_CREATE_VERSIONED_HARD_LINK=OFF \
	-DQT_QPA_DEFAULT_EGLFS_INTEGRATION=eglfs_kms \
	-DQT_QPA_DEFAULT_PLATFORM=$(PTXCONF_QT6_PLATFORM_DEFAULT) \
	-DQT_USE_CCACHE=OFF \
	-DQT_WILL_INSTALL=ON \
	-DWARNINGS_ARE_ERRORS=OFF

ifdef PTXCONF_QT6_WIDGETS
QT6_CONF_OPT += \
	-DFEATURE_abstractbutton=ON \
	-DFEATURE_abstractslider=ON \
	-DFEATURE_buttongroup=ON \
	-DFEATURE_calendarwidget=ON \
	-DFEATURE_checkbox=ON \
	-DFEATURE_colordialog=ON \
	-DFEATURE_columnview=ON \
	-DFEATURE_combobox=ON \
	-DFEATURE_commandlinkbutton=ON \
	-DFEATURE_completer=ON \
	-DFEATURE_contextmenu=ON \
	-DFEATURE_cups=OFF \
	-DFEATURE_cupsjobwidget=OFF \
	-DFEATURE_cupspassworddialog=OFF \
	-DFEATURE_datawidgetmapper=ON \
	-DFEATURE_datetimeedit=ON \
	-DFEATURE_dial=ON \
	-DFEATURE_dialog=ON \
	-DFEATURE_dialogbuttonbox=ON \
	-DFEATURE_dockwidget=ON \
	-DFEATURE_effects=OFF \
	-DFEATURE_errormessage=ON \
	-DFEATURE_filedialog=ON \
	-DFEATURE_fontcombobox=ON \
	-DFEATURE_fontdialog=ON \
	-DFEATURE_formlayout=ON \
	-DFEATURE_fscompleter=ON \
	-DFEATURE_graphicseffect=ON \
	-DFEATURE_graphicsview=ON \
	-DFEATURE_groupbox=ON \
	-DFEATURE_gtk3=OFF \
	-DFEATURE_inputdialog=ON \
	-DFEATURE_itemviews=ON \
	-DFEATURE_keysequenceedit=ON \
	-DFEATURE_label=ON \
	-DFEATURE_lcdnumber=ON \
	-DFEATURE_lineedit=ON \
	-DFEATURE_listview=ON \
	-DFEATURE_listwidget=ON \
	-DFEATURE_mainwindow=ON \
	-DFEATURE_mdiarea=ON \
	-DFEATURE_menu=ON \
	-DFEATURE_menubar=ON \
	-DFEATURE_messagebox=ON \
	-DFEATURE_printdialog=ON \
	-DFEATURE_printer=ON \
	-DFEATURE_printpreviewdialog=ON \
	-DFEATURE_printpreviewwidget=ON \
	-DFEATURE_progressbar=ON \
	-DFEATURE_progressdialog=ON \
	-DFEATURE_pushbutton=ON \
	-DFEATURE_radiobutton=ON \
	-DFEATURE_resizehandler=ON \
	-DFEATURE_rubberband=ON \
	-DFEATURE_scrollarea=ON \
	-DFEATURE_scrollbar=ON \
	-DFEATURE_scroller=ON \
	-DFEATURE_sizegrip=ON \
	-DFEATURE_slider=ON \
	-DFEATURE_spinbox=ON \
	-DFEATURE_splashscreen=ON \
	-DFEATURE_splitter=ON \
	-DFEATURE_stackedwidget=ON \
	-DFEATURE_statusbar=ON \
	-DFEATURE_statustip=ON \
	-DFEATURE_style_android=OFF \
	-DFEATURE_style_fusion=ON \
	-DFEATURE_style_mac=OFF \
	-DFEATURE_style_stylesheet=ON \
	-DFEATURE_style_windows=ON \
	-DFEATURE_style_windowsvista=OFF \
	-DFEATURE_syntaxhighlighter=ON \
	-DFEATURE_tabbar=ON \
	-DFEATURE_tableview=ON \
	-DFEATURE_tablewidget=ON \
	-DFEATURE_tabwidget=ON \
	-DFEATURE_textbrowser=ON \
	-DFEATURE_textedit=ON \
	-DFEATURE_toolbar=ON \
	-DFEATURE_toolbox=ON \
	-DFEATURE_toolbutton=ON \
	-DFEATURE_tooltip=ON \
	-DFEATURE_treeview=ON \
	-DFEATURE_treewidget=ON \
	-DFEATURE_undoview=ON \
	-DFEATURE_widgettextcontrol=ON \
	-DFEATURE_wizard=ON
endif
endif

ifdef PTXCONF_QT6_MODULE_QT3D
QT6_CONF_OPT += \
	-DFEATURE_qt3d_animation=ON \
	-DFEATURE_qt3d_assimp=ON \
	-DFEATURE_qt3d_extras=ON \
	-DFEATURE_qt3d_fbxsdk=OFF \
	-DFEATURE_qt3d_input=ON \
	-DFEATURE_qt3d_logic=ON \
	-DFEATURE_qt3d_opengl_renderer=ON \
	-DFEATURE_qt3d_render=ON \
	-DFEATURE_qt3d_rhi_renderer=ON \
	-DFEATURE_qt3d_system_assimp=OFF \
	-DFEATURE_qt3d_vulkan=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTCHARTS
QT6_CONF_OPT += \
	-DFEATURE_charts_area_chart=ON \
	-DFEATURE_charts_bar_chart=ON \
	-DFEATURE_charts_boxplot_chart=ON \
	-DFEATURE_charts_candlestick_chart=ON \
	-DFEATURE_charts_datetime_axis=ON \
	-DFEATURE_charts_line_chart=ON \
	-DFEATURE_charts_pie_chart=ON \
	-DFEATURE_charts_scatter_chart=ON \
	-DFEATURE_charts_spline_chart=ON
endif

ifdef PTXCONF_QT6_MODULE_QT5COMPAT
QT6_CONF_OPT += \
	-DFEATURE_big_codecs=ON \
	-DFEATURE_codecs=ON \
	-DFEATURE_iconv=OFF \
	-DFEATURE_textcodec=ON
endif

ifdef PTXCONF_QT6_MODULE_QTCONNECTIVITY
QT6_CONF_OPT += \
	-DFEATURE_bluez=ON \
	-DFEATURE_bluez_le=ON \
	-DFEATURE_pcsclite=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTDECLARATIVE
QT6_QML_JIT := ON
ifdef PTXCONF_ARCH_ARM
ifndef PTXCONF_ARCH_ARM_V7
QT6_QML_JIT := OFF
endif
endif
ifdef PTXCONF_ARCH_PPC
QT6_QML_JIT := OFF
endif

QT6_CONF_OPT += \
	-DFEATURE_qml_animation=ON \
	-DFEATURE_qml_debug=ON \
	-DFEATURE_qml_delegate_model=ON \
	-DFEATURE_qml_itemmodel=ON \
	-DFEATURE_qml_jit=$(QT6_QML_JIT) \
	-DFEATURE_qml_list_model=ON \
	-DFEATURE_qml_locale=ON \
	-DFEATURE_qml_network=ON \
	-DFEATURE_qml_object_model=ON \
	-DFEATURE_qml_preview=ON \
	-DFEATURE_qml_profiler=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG) \
	-DFEATURE_qml_python=ON \
	-DFEATURE_qml_table_model=ON \
	-DFEATURE_qml_worker_script=ON \
	-DFEATURE_qml_xml_http_request=ON \
	-DFEATURE_qml_xmllistmodel=ON

# not documented but prevents broken rpaths in qml plugins
QT6_CONF_OPT += \
	-DQT_NO_QML_PLUGIN_RPATH=ON

ifdef PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK
QT6_CONF_OPT += \
	-DFEATURE_quick_animatedimage=ON \
	-DFEATURE_quick_canvas=ON \
	-DFEATURE_quick_designer=ON \
	-DFEATURE_quick_draganddrop=ON \
	-DFEATURE_quick_flipable=ON \
	-DFEATURE_quick_gridview=ON \
	-DFEATURE_quick_itemview=ON \
	-DFEATURE_quick_listview=ON \
	-DFEATURE_quick_particles=ON \
	-DFEATURE_quick_path=ON \
	-DFEATURE_quick_pathview=ON \
	-DFEATURE_quick_pixmap_cache_threaded_download=ON \
	-DFEATURE_quick_positioners=ON \
	-DFEATURE_quick_repeater=ON \
	-DFEATURE_quick_shadereffect=ON \
	-DFEATURE_quick_sprite=ON \
	-DFEATURE_quick_tableview=ON \
	-DFEATURE_quick_treeview=ON \
	-DFEATURE_quick_viewtransitions=ON \
	-DFEATURE_quickcontrols2_basic=ON \
	-DFEATURE_quickcontrols2_fusion=ON \
	-DFEATURE_quickcontrols2_imagine=ON \
	-DFEATURE_quickcontrols2_ios=OFF \
	-DFEATURE_quickcontrols2_macos=OFF \
	-DFEATURE_quickcontrols2_material=ON \
	-DFEATURE_quickcontrols2_universal=ON \
	-DFEATURE_quickcontrols2_windows=OFF \
	-DFEATURE_quicktemplates2_calendar=ON \
	-DFEATURE_quicktemplates2_hover=ON \
	-DFEATURE_quicktemplates2_multitouch=ON
endif
endif

ifdef PTXCONF_QT6_MODULE_QTIMAGEFORMATS
QT6_CONF_OPT += \
	-DFEATURE_jasper=OFF \
	-DFEATURE_mng=$(call ptx/onoff,PTXCONF_QT6_LIBMNG) \
	-DFEATURE_system_tiff=ON \
	-DFEATURE_system_webp=ON \
	-DFEATURE_tiff=ON \
	-DFEATURE_webp=ON
endif

ifdef PTXCONF_QT6_MODULE_QTMULTIMEDIA
ifdef PTXCONF_QT6_MODULE_QTMULTIMEDIA_GST
QT6_MODULE_QTMULTIMEDIA_GST_GL := $(PTXCONF_QT6_OPENGL)
endif
QT6_CONF_OPT += \
	-DFEATURE_alsa=OFF \
	-DFEATURE_avfoundation=OFF \
	-DFEATURE_evr=OFF \
	-DFEATURE_ffmpeg=OFF \
	-DFEATURE_gpu_vivante=OFF \
	-DFEATURE_gstreamer=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTMULTIMEDIA_GST) \
	-DFEATURE_gstreamer_1_0=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTMULTIMEDIA_GST) \
	-DFEATURE_gstreamer_app=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTMULTIMEDIA_GST) \
	-DFEATURE_gstreamer_gl=$(call ptx/onoff,QT6_MODULE_QTMULTIMEDIA_GST_GL) \
	-DFEATURE_gstreamer_photography=OFF \
	-DFEATURE_linux_dmabuf=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_linux_v4l=ON \
	-DFEATURE_pulseaudio=OFF \
	-DFEATURE_spatialaudio=OFF \
	-DFEATURE_spatialaudio_quick3d=OFF \
	-DFEATURE_vaapi=OFF \
	-DFEATURE_videotoolbox=OFF \
	-DFEATURE_wasm=OFF \
	-DFEATURE_wmf=OFF \
	-DFEATURE_wmsdk=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTOPCUA
QT6_CONF_OPT += \
	-DFEATURE_gds=$(call ptx/onoff,PTXCONF_QT6_OPENSSL) \
	-DFEATURE_ns0idgenerator=OFF \
	-DFEATURE_ns0idnames=ON \
	-DFEATURE_open62541=OFF \
	-DFEATURE_open62541_security=OFF \
	-DFEATURE_system_open62541=OFF \
	-DFEATURE_uacpp=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTPOSITIONING
QT6_CONF_OPT += \
	-DFEATURE_gypsy=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTQUICK3D
QT6_CONF_OPT += \
	-DFEATURE_quick3d_assimp=ON \
	-DFEATURE_system_assimp=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTSERIALBUS
QT6_CONF_OPT += \
	-DFEATURE_modbus_serialport=ON \
	-DFEATURE_ntddmodm=OFF \
	-DFEATURE_socketcan=ON \
	-DFEATURE_socketcan_fd=ON
endif

ifdef PTXCONF_QT6_MODULE_QTSCXML
QT6_CONF_OPT += \
	-DFEATURE_qeventtransition=$(call ptx/onoff,PTXCONF_QT6_GUI) \
	-DFEATURE_scxml_ecmascriptdatamodel=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTSCXML_QUICK) \
	-DFEATURE_statemachine=ON
endif

ifdef PTXCONF_QT6_MODULE_QTSENSORS
QT6_CONF_OPT += \
	-DFEATURE_sensorfw=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTVIRTUALKEYBOARD
QT6_CONF_OPT += \
	-DFEATURE_3rdparty_hunspell=OFF \
	-DFEATURE_cangjie=OFF \
	-DFEATURE_cerence_hwr=OFF \
	-DFEATURE_cerence_hwr_alphabetic=OFF \
	-DFEATURE_cerence_hwr_cjk=OFF \
	-DFEATURE_cerence_sdk=OFF \
	-DFEATURE_cerence_xt9=OFF \
	-DFEATURE_example_hwr=OFF \
	-DFEATURE_hangul=ON \
	-DFEATURE_hunspell=OFF \
	-DFEATURE_myscript=OFF \
	-DFEATURE_openwnn=ON \
	-DFEATURE_pinyin=ON \
	-DFEATURE_system_hunspell=OFF \
	-DFEATURE_tcime=ON \
	-DFEATURE_thai=ON \
	-DFEATURE_vkb_layouts=ON \
	-DFEATURE_vkb_no_builtin_style=OFF \
	-DFEATURE_vkb_no_bundle_pinyin=OFF \
	-DFEATURE_vkb_no_bundle_tcime=OFF \
	-DFEATURE_vkb_record_trace_input=OFF \
	-DFEATURE_vkb_retro_style=OFF \
	-DFEATURE_vkb_sensitive_debug=OFF \
	-DFEATURE_zhuyin=ON
endif

ifdef PTXCONF_QT6_MODULE_QTWAYLAND
QT6_CONF_OPT += \
	-DFEATURE_egl_extension_platform_wayland=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_wayland_brcm=OFF \
	-DFEATURE_wayland_client=ON \
	-DFEATURE_wayland_client_fullscreen_shell_v1=ON \
	-DFEATURE_wayland_client_ivi_shell=ON \
	-DFEATURE_wayland_client_primary_selection=ON \
	-DFEATURE_wayland_client_qt_shell=ON \
	-DFEATURE_wayland_client_wl_shell=OFF \
	-DFEATURE_wayland_client_xdg_shell=ON \
	-DFEATURE_wayland_datadevice=ON \
	-DFEATURE_wayland_dmabuf_server_buffer=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_wayland_drm_egl_server_buffer=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_wayland_egl=$(call ptx/onoff,PTXCONF_QT6_OPENGL) \
	-DFEATURE_wayland_libhybris_egl_server_buffer=OFF \
	-DFEATURE_wayland_server=OFF \
	-DFEATURE_wayland_shm_emulation_server_buffer=OFF \
	-DFEATURE_wayland_text_input_v4_wip=OFF \
	-DFEATURE_wayland_vulkan_server_buffer=OFF
endif

ifdef PTXCONF_QT6_MODULE_QTWEBENGINE
QT6_CONF_OPT += \
	-DQT_HOST_GN_PATH=$(PTXDIST_SYSROOT_HOST)/usr/bin/gn \
	-DFEATURE_qtpdf_build=OFF \
	-DFEATURE_qtpdf_quick_build=OFF \
	-DFEATURE_qtpdf_widgets_build=OFF \
	-DFEATURE_qtwebengine_build=ON \
	-DFEATURE_qtwebengine_core_build=ON \
	-DFEATURE_qtwebengine_quick_build=ON \
	-DFEATURE_qtwebengine_widgets_build=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTWEBENGINE_WIDGETS) \
	-DFEATURE_webengine_build_gn=ON \
	-DFEATURE_webengine_build_ninja=OFF \
	-DFEATURE_webengine_developer_build=OFF \
	-DFEATURE_webengine_embedded_build=ON \
	-DFEATURE_webengine_extensions=OFF \
	-DFEATURE_webengine_geolocation=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTPOSITIONING) \
	-DFEATURE_webengine_jumbo_build=ON \
	-DFEATURE_webengine_kerberos=OFF \
	-DFEATURE_webengine_native_spellchecker=OFF \
	-DFEATURE_webengine_ozone_x11=OFF \
	-DFEATURE_webengine_pepper_plugins=OFF \
	-DFEATURE_webengine_printing_and_pdf=OFF \
	-DFEATURE_webengine_proprietary_codecs=OFF \
	-DFEATURE_webengine_qt_freetype=OFF \
	-DFEATURE_webengine_qt_harfbuzz=OFF \
	-DFEATURE_webengine_qt_libjpeg=OFF \
	-DFEATURE_webengine_qt_libpng=OFF \
	-DFEATURE_webengine_qt_zlib=OFF \
	-DFEATURE_webengine_sanitizer=OFF \
	-DFEATURE_webengine_spellchecker=OFF \
	-DFEATURE_webengine_system_alsa=$(call ptx/onoff,PTXCONF_QT6_MODULE_QTWEBENGINE_MEDIA) \
	-DFEATURE_webengine_system_ffmpeg=OFF \
	-DFEATURE_webengine_system_freetype=ON \
	-DFEATURE_webengine_system_glib=ON \
	-DFEATURE_webengine_system_harfbuzz=OFF \
	-DFEATURE_webengine_system_icu=OFF \
	-DFEATURE_webengine_system_lcms2=OFF \
	-DFEATURE_webengine_system_libevent=OFF \
	-DFEATURE_webengine_system_libjpeg=ON \
	-DFEATURE_webengine_system_libopenjpeg2=OFF \
	-DFEATURE_webengine_system_libpci=OFF \
	-DFEATURE_webengine_system_libpng=ON \
	-DFEATURE_webengine_system_libtiff=ON \
	-DFEATURE_webengine_system_libvpx=OFF \
	-DFEATURE_webengine_system_libwebp=ON \
	-DFEATURE_webengine_system_libxml=OFF \
	-DFEATURE_webengine_system_minizip=OFF \
	-DFEATURE_webengine_system_opus=ON \
	-DFEATURE_webengine_system_poppler=OFF \
	-DFEATURE_webengine_system_pulseaudio=OFF \
	-DFEATURE_webengine_system_re2=OFF \
	-DFEATURE_webengine_system_snappy=OFF \
	-DFEATURE_webengine_system_zlib=ON \
	-DFEATURE_webengine_v8_context_snapshot=OFF \
	-DFEATURE_webengine_vaapi=OFF \
	-DFEATURE_webengine_vulkan=OFF \
	-DFEATURE_webengine_webchannel=ON \
	-DFEATURE_webengine_webrtc=OFF \
	-DFEATURE_webengine_webrtc_pipewire=OFF \
	-DFEATURE_webenginequick_ui_delegates=ON
endif

QT6_CONF_TOOL	:= cmake
QT6_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	--log-level=$(if $(filter 1,$(PTXDIST_VERBOSE)),TRACE,STATUS) \
	-DPython3_EXECUTABLE=$(PTXDIST_SYSROOT_HOST)/usr/lib/wrapper/$(SYSTEMPYTHON3) \
	$(sort $(QT6_CONF_OPT))

ifdef PTXCONF_QT6_GUI
ifndef PTXCONF_QT6_PLATFORM_DEFAULT
$(call ptx/error, Qt6: select at least one GUI platform!)
endif
endif

# change default C++ standard
# the detected standard is not used for configure and examples
QT6_CXXFLAGS := -std=c++11

$(STATEDIR)/qt6.prepare:
	@$(call targetinfo)
	@rm -rf "$(QT6_DIR)/qtbase/mkspecs/linux-ptx-g++"
	@mkdir "$(QT6_DIR)/qtbase/mkspecs/linux-ptx-g++"
	@$(foreach file, $(wildcard $(QT6_MKSPECS)/*), \
		$(QT6_CONF_ENV) ptxd_replace_magic "$(file)" > \
		"$(QT6_DIR)/qtbase/mkspecs/linux-ptx-g++/$(notdir $(file))"$(ptx/nl))

ifdef PTXCONF_QT6_MODULE_QTWEBENGINE
ifndef PTXCONF_ARCH_LP64
	@echo "Checking for 32bit g++ host compiler ..."
	@$(call world/execute, QT6, \
		echo -e '#include <list>\n int main() { std::list<int> a; return 0; }' | \
		g++ -x c++  - -o /dev/null -m32 &> /dev/null || \
		ptxd_bailout "32bit g++ host compiler is missing (needed for QtWebengine)." \
			"Please install g++-multilib (debian)")
endif
endif
	@+$(call world/prepare, QT6)
	@$(call touch)

# some macro magic fails with icecc remote cpp on ARM/ARM64
ifneq ($(PTXCONF_ARCH_ARM64)$(PTXCONF_ARCH_ARM),)
ifdef PTXCONF_QT6_MODULE_QTWEBENGINE
QT6_MAKE_ENV := \
	ICECC_REMOTE_CPP=0
endif
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qt6.install:
	@$(call targetinfo)
	@$(call world/install, QT6)
	@find $(QT6_PKGDIR) -name '*.qmltypes' | xargs -r rm
	@find $(QT6_PKGDIR) -name '*.pri' -o -name '*.cmake' | \
		xargs sed -i -e 's;$(PTXDIST_WORKSPACE);@WORKSPACE@;g' \
			-e 's;$(shell readlink -f $(PTXDIST_WORKSPACE));@WORKSPACE@;g'
	@$(call touch)

QT6_QT_CONF := $(PTXDIST_SYSROOT_TARGET)/usr/bin/target_qt.conf

QT6_CROSS_TOOLS := \
	qmake \
	qt-cmake \
	qt-cmake-private \
	qt-cmake-standalone-test \
	qt-configure-module \
	qtpaths

QT6_BUILD_TOOLS := \
	moc \
	rcc \
	uic

$(STATEDIR)/qt6.install.post:
	@$(call targetinfo)
	@find $(QT6_PKGDIR) -name '*.pri' -o -name '*.cmake' | \
		xargs sed -i 's;@WORKSPACE@;$(PTXDIST_WORKSPACE);g'
	@$(call world/install.post, QT6)
	@echo "[Paths]"							>  $(QT6_QT_CONF)
	@echo "Prefix=/usr"						>> $(QT6_QT_CONF)
	@echo "HostPrefix=$(PTXDIST_SYSROOT_HOST)/usr"			>> $(QT6_QT_CONF)
	@echo "HostBinaries=$(PTXDIST_SYSROOT_CROSS)/usr/bin/qt6"	>> $(QT6_QT_CONF)
	@echo "HostLibraryExecutables=lib/qt6/libexec"			>> $(QT6_QT_CONF)
	@echo "HostData=$(SYSROOT)/usr/lib/qt6"				>> $(QT6_QT_CONF)
	@echo "Sysroot="						>> $(QT6_QT_CONF)
	@echo "SysrootifyPrefix=false"					>> $(QT6_QT_CONF)
	@echo "TargetSpec=linux-ptx-g++"				>> $(QT6_QT_CONF)
	@echo "HostSpec="						>> $(QT6_QT_CONF)
	@echo "Headers=$(SYSROOT)/usr/include/qt6"			>> $(QT6_QT_CONF)
	@echo "Libraries=$(SYSROOT)/usr/lib"				>> $(QT6_QT_CONF)
	@echo "Imports=/usr/lib/qt6/imports"				>> $(QT6_QT_CONF)
	@echo "Qml2Imports=/usr/lib/qt6/qml"				>> $(QT6_QT_CONF)
	@echo ""							>> $(QT6_QT_CONF)
#	# qmake is found in sysroot-cross (via PATH) and sysroot target (via cmake)
	@rm -rf $(PTXDIST_SYSROOT_CROSS)/bin/qt6
	@mkdir $(PTXDIST_SYSROOT_CROSS)/bin/qt6
	@$(foreach tool,$(QT6_CROSS_TOOLS), \
		echo -e '#!/bin/sh\nexec $(PTXDIST_SYSROOT_TARGET)/usr/bin/$(tool) "$${@}"' > \
			$(PTXDIST_SYSROOT_CROSS)/bin/qt6/$(tool)$(ptx/nl) \
		chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/qt6/$(tool)$(ptx/nl))
	@$(foreach tool, $(QT6_BUILD_TOOLS), \
		$(if $(wildcard $(PTXDIST_SYSROOT_HOST)/usr/lib/qt6/libexec/$(tool)), \
		ln -vsf ../../../sysroot-host/lib/qt6/libexec/$(tool) $(PTXDIST_SYSROOT_CROSS)/usr/bin/$(tool)6$(ptx/nl)))
	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

QT6_LIBS-y							:=
QT6_QML-y							:=

### Qt3d ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QT3D)				+= Qt63DAnimation Qt63DCore Qt63DExtras Qt63DInput Qt63DLogic Qt63DRender
QT6_LIBS-$(PTXCONF_QT6_MODULE_QT3D_QUICK)			+= Qt63DQuick Qt63DQuickAnimation Qt63DQuickExtras Qt63DQuickInput Qt63DQuickRender Qt63DQuickScene2D
QT6_QML-$(PTXCONF_QT6_MODULE_QT3D_QUICK)			+= Qt3D
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QT3D)				+= geometryloaders/libdefaultgeometryloader
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QT3D)				+= geometryloaders/libgltfgeometryloader
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QT3D)				+= sceneparsers/libgltfsceneexport
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QT3D)				+= sceneparsers/libgltfsceneimport
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QT3D)				+= renderers/libopenglrenderer
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QT3D)				+= renderers/librhirenderer
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QT3D_QUICK)			+= renderplugins/libscene2d

### Qt5Compat ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QT5COMPAT)			+= Qt6Core5Compat
QT6_QML-$(PTXCONF_QT6_MODULE_QT5COMPAT_QUICK)			+= Qt5Compat

### QtBase ###
QT6_LIBS-y							+= Qt6Core
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE)				+= Qt6Concurrent
QT6_LIBS-$(PTXCONF_QT6_DBUS)					+= Qt6DBus
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE_GUI)			+= Qt6Gui
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE)				+= Qt6Network
QT6_LIBS-$(PTXCONF_QT6_OPENGL)					+= Qt6OpenGL
ifdef PTXCONF_QT6_OPENGL
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE_WIDGETS)			+= Qt6OpenGLWidgets
endif
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE_PRINT)			+= Qt6PrintSupport
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE_SQL)			+= Qt6Sql
ifdef PTXCONF_QT6_TEST
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE_WIDGETS)			+= Qt6Test
endif
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE_WIDGETS)			+= Qt6Widgets
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTBASE)				+= Qt6Xml
QT6_LIBS-$(PTXCONF_QT6_PLATFORM_EGLFS)				+= Qt6EglFSDeviceIntegration
QT6_LIBS-$(PTXCONF_QT6_PLATFORM_EGLFS)				+= Qt6EglFsKmsGbmSupport
QT6_LIBS-$(PTXCONF_QT6_PLATFORM_EGLFS)				+= Qt6EglFsKmsSupport
QT6_PLUGINS-$(PTXCONF_QT6_INPUT_EVDEV)				+= generic/libqevdevkeyboardplugin
QT6_PLUGINS-$(PTXCONF_QT6_INPUT_EVDEV)				+= generic/libqevdevmouseplugin
QT6_PLUGINS-$(PTXCONF_QT6_INPUT_EVDEV)				+= generic/libqevdevtabletplugin
QT6_PLUGINS-$(PTXCONF_QT6_INPUT_EVDEV)				+= generic/libqevdevtouchplugin
QT6_PLUGINS-$(PTXCONF_QT6_INPUT_LIBINPUT)			+= generic/libqlibinputplugin
QT6_PLUGINS-$(PTXCONF_QT6_GIF)					+= imageformats/libqgif
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTBASE_GUI)			+= imageformats/libqico
QT6_PLUGINS-$(PTXCONF_QT6_LIBJPEG)				+= imageformats/libqjpeg
QT6_PLUGINS-$(PTXCONF_QT6_PLATFORM_EGLFS)			+= platforms/libqeglfs
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTBASE_GUI)			+= platforms/libqminimal
QT6_PLUGINS-$(PTXCONF_QT6_PLATFORM_EGLFS)			+= platforms/libqminimalegl
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTBASE_GUI)			+= platforms/libqoffscreen
QT6_PLUGINS-$(PTXCONF_QT6_PLATFORM_LINUXFB)			+= platforms/libqlinuxfb
QT6_PLUGINS-$(PTXCONF_QT6_PLATFORM_EGLFS)			+= egldeviceintegrations/libqeglfs-kms-integration
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTBASE_SQL_MYSQL)		+= sqldrivers/libqsqlmysql
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTBASE_SQL_SQLITE)		+= sqldrivers/libqsqlite
QT6_PLUGINS-$(PTXCONF_QT6_GLIB)					+= networkinformation/libqglib
QT6_PLUGINS-$(PTXCONF_QT6_DBUS)					+= networkinformation/libqnetworkmanager
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTBASE)			+= tls/libqcertonlybackend
QT6_PLUGINS-$(PTXCONF_QT6_OPENSSL)				+= tls/libqopensslbackend

### QtCharts ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTCHARTS)				+= Qt6Charts
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTCHARTS_QUICK)			+= Qt6ChartsQml
QT6_QML-$(PTXCONF_QT6_MODULE_QTCHARTS_QUICK)			+= QtCharts

### QtCoap ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTCOAP)				+= Qt6Coap

### QtConnectivity ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTCONNECTIVITY)			+= Qt6Bluetooth
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTCONNECTIVITY)			+= Qt6Nfc

### QtDataVisualization ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDATAVIS3D)			+= Qt6DataVisualization
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDATAVIS3D)			+= Qt6DataVisualizationQml
QT6_QML-$(PTXCONF_QT6_MODULE_QTDATAVIS3D)			+= QtDataVisualization

### QtDeclarative ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= Qt6Qml
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= Qt6QmlCore
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= Qt6QmlLocalStorage
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= Qt6QmlXmlListModel
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QmlModels
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QmlWorkerScript
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6Quick
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickControls2
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickControls2Impl
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickDialogs2
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickDialogs2Utils
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickDialogs2QuickImpl
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickEffects
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickLayouts
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickShapes
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickTemplates2
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK_WIDGETS)	+= Qt6QuickWidgets
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK_PARTICLES)	+= Qt6QuickParticles
ifdef PTXCONF_QT6_TEST
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= Qt6QuickTest
endif
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_debugger
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_local
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_messages
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_native
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_nativedebugger
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_preview
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_profiler
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK_DEBUG)	+= qmltooling/libqmldbg_quickprofiler
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_server
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_tcp
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK_DEBUG)	+= qmltooling/libqmldbg_inspector
QT6_QML-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= Qt
QT6_QML-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= QtCore
QT6_QML-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= QtQml
QT6_QML-$(PTXCONF_QT6_MODULE_QTDECLARATIVE)			+= QtQuick
ifdef PTXCONF_QT6_TEST
QT6_QML-$(PTXCONF_QT6_MODULE_QTDECLARATIVE_QUICK)		+= QtTest
endif

### QtGraphs ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTGRAPHS)				+= Qt6Graphs
QT6_QML-$(PTXCONF_QT6_MODULE_QTGRAPHS)				+= QtGraphs

### QtHttpServer ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTHTTPSERVER)			+= Qt6HttpServer

### QtImageFormats ###
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTIMAGEFORMATS)		+= imageformats/libqicns
QT6_PLUGINS-$(PTXCONF_QT6_LIBMNG)				+= imageformats/libqmng
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTIMAGEFORMATS)		+= imageformats/libqtga
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTIMAGEFORMATS)		+= imageformats/libqtiff
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTIMAGEFORMATS)		+= imageformats/libqwbmp
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTIMAGEFORMATS)		+= imageformats/libqwebp

### QtLottie ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTLOTTIE)				+= Qt6Bodymovin

### QtMqtt ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTMQTT)				+= Qt6Mqtt

### QtMultimedia ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTMULTIMEDIA)			+= Qt6Multimedia
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTMULTIMEDIA_QUICK)		+= Qt6MultimediaQuick
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTMULTIMEDIA_WIDGETS)		+= Qt6MultimediaWidgets
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTMULTIMEDIA_GST)		+= multimedia/libgstreamermediaplugin
QT6_QML-$(PTXCONF_QT6_MODULE_QTMULTIMEDIA_QUICK)		+= QtMultimedia

### QtNetworkAuth ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTNETWORKAUTH)			+= Qt6NetworkAuth

### QtOpcua ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTOPCUA)				+= Qt6OpcUa
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTOPCUA_QUICK)			+= Qt6DeclarativeOpcua
QT6_QML-$(PTXCONF_QT6_MODULE_QTOPCUA_QUICK)			+= QtOpcUa

### QtPositioning ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTPOSITIONING)			+= Qt6Positioning
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTPOSITIONING_QUICK)		+= Qt6PositioningQuick
QT6_QML-$(PTXCONF_QT6_MODULE_QTPOSITIONING_QUICK)		+= QtPositioning

### QtQuick3D ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3D
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DAssetImport
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DAssetUtils
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DEffects
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DGlslParser
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DHelpers
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DHelpersImpl
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DIblBaker
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DParticleEffects
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DParticles
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DRuntimeRender
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3D)			+= Qt6Quick3DUtils
QT6_QML-$(PTXCONF_QT6_MODULE_QTQUICK3D)				+= QtQuick3D

### QtQuick3DPhysics ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3DPHYSICS)			+= Qt6Quick3DPhysics
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICK3DPHYSICS)			+= Qt6Quick3DPhysicsHelpers

### QtQuickTimeline ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTQUICKTIMELINE)			+= Qt6QuickTimeline

### QtRemoteObjects ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTREMOTEOBJECTS)			+= Qt6RemoteObjects
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTREMOTEOBJECTS_QUICK)		+= Qt6RemoteObjectsQml
QT6_QML-$(PTXCONF_QT6_MODULE_QTREMOTEOBJECTS_QUICK)		+= QtRemoteObjects

### QtShaderTools ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSHADERTOOLS)			+= Qt6ShaderTools

### QtScxml ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSCXML)				+= Qt6Scxml
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSCXML)				+= Qt6StateMachine
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSCXML_QUICK)			+= Qt6StateMachineQml
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSCXML_QUICK)			+= Qt6ScxmlQml
QT6_QML-$(PTXCONF_QT6_MODULE_QTSCXML_QUICK)			+= QtScxml
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTSCXML_QUICK)			+= scxmldatamodel/libqscxmlecmascriptdatamodel

### QtSensors ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSENSORS)			+= Qt6Sensors
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSENSORS_QUICK)			+= Qt6SensorsQuick
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTSENSORS)			+= sensors/libqtsensors_generic
ifdef PTXCONF_QT6_DBUS
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTSENSORS)			+= sensors/libqtsensors_iio-sensor-proxy
endif
QT6_QML-$(PTXCONF_QT6_MODULE_QTSENSORS_QUICK)			+= QtSensors

### QtSerialBus ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSERIALBUS)			+= Qt6SerialBus
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTSERIALBUS)			+= canbus/libqtsocketcanbus

### QtSerialPort ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSERIALPORT)			+= Qt6SerialPort

### QtSvg ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSVG)				+= Qt6Svg
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTSVG_WIDGETS)			+= Qt6SvgWidgets
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTSVG_WIDGETS)			+= iconengines/libqsvgicon
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTSVG)				+= imageformats/libqsvg

### QtVirtualKeyboard ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTVIRTUALKEYBOARD)		+= Qt6VirtualKeyboard
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTVIRTUALKEYBOARD)		+= platforminputcontexts/libqtvirtualkeyboardplugin

### QtWayland ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWAYLAND)			+= Qt6WaylandClient
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND)			+= platforms/libqwayland-generic
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWAYLAND_MESA)			+= Qt6WaylandEglClientHwIntegration
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND_MESA)		+= platforms/libqwayland-egl
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND_MESA)		+= wayland-graphics-integration-client/libqt-plugin-wayland-egl
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND_MESA)		+= wayland-graphics-integration-client/libdmabuf-server
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND_MESA)		+= wayland-graphics-integration-client/libdrm-egl-server

QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND)			+= wayland-shell-integration/libfullscreen-shell-v1
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND)			+= wayland-shell-integration/libivi-shell
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND)			+= wayland-shell-integration/libqt-shell
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND)			+= wayland-shell-integration/libxdg-shell
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWAYLAND)			+= wayland-decoration-client/libbradient

### QtWebChannel ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBCHANNEL)			+= Qt6WebChannel
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBCHANNEL_QUICK)		+= Qt6WebChannelQuick
QT6_QML-$(PTXCONF_QT6_MODULE_QTWEBCHANNEL_QUICK)		+= QtWebChannel

### QtWebEngine ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBENGINE)			+= Qt6WebEngineCore
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBENGINE)			+= Qt6WebEngineQuick
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBENGINE)			+= Qt6WebEngineQuickDelegatesQml
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBENGINE_WIDGETS)		+= Qt6WebEngineWidgets
QT6_QML-$(PTXCONF_QT6_MODULE_QTWEBENGINE)			+= QtWebEngine

### QtWebSockets ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBSOCKETS)			+= Qt6WebSockets
QT6_QML-$(PTXCONF_QT6_MODULE_QTWEBSOCKETS_QUICK)		+= QtWebSockets

### QtWebView ###
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBVIEW)			+= Qt6WebView
QT6_LIBS-$(PTXCONF_QT6_MODULE_QTWEBVIEW)			+= Qt6WebViewQuick
QT6_QML-$(PTXCONF_QT6_MODULE_QTWEBVIEW)				+= QtWebView
QT6_PLUGINS-$(PTXCONF_QT6_MODULE_QTWEBVIEW)			+= webview/libqtwebview_webengine


$(STATEDIR)/qt6.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qt6)
	@$(call install_fixup, qt6,PRIORITY,optional)
	@$(call install_fixup, qt6,SECTION,base)
	@$(call install_fixup, qt6,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, qt6,DESCRIPTION,missing)

	@$(foreach lib, $(QT6_LIBS-y), \
		$(call install_lib, qt6, 0, 0, 0644, lib$(lib))$(ptx/nl))

ifdef PTXCONF_QT6_MODULE_QTWEBENGINE
	@$(call install_copy, qt6, 0, 0, 0755, -, \
		/usr/lib/qt6/libexec/QtWebEngineProcess)
	@$(call install_copy, qt6, 0, 0, 0644, -, \
		/usr/share/qt6/resources/icudtl.dat)
	@$(call install_copy, qt6, 0, 0, 0644, -, \
		/usr/share/qt6/resources/qtwebengine_devtools_resources.pak)
	@$(call install_copy, qt6, 0, 0, 0644, -, \
		/usr/share/qt6/resources/qtwebengine_resources.pak)
	@$(call install_copy, qt6, 0, 0, 0644, -, \
		/usr/share/qt6/resources/qtwebengine_resources_100p.pak)
	@$(call install_copy, qt6, 0, 0, 0644, -, \
		/usr/share/qt6/resources/qtwebengine_resources_200p.pak)
endif

	@$(foreach plugin, $(QT6_PLUGINS-y), \
		$(call install_copy, qt6, 0, 0, 0644, -, \
			/usr/lib/qt6/plugins/$(plugin).so)$(ptx/nl))

	@$(foreach import, $(QT6_IMPORTS-y), \
		$(call install_tree, qt6, 0, 0, -, \
		/usr/lib/qt6/imports/$(import))$(ptx/nl))

	@$(foreach qml, $(QT6_QML-y), \
		$(call install_glob, qt6, 0, 0, -, \
		/usr/lib/qt6/qml/$(qml),,*/labs */test)$(ptx/nl))

ifdef PTXCONF_QT6_MODULE_QTDECLARATIVE_QML
	@$(call install_copy, qt6, 0, 0, 0755, -, /usr/bin/qml)
endif
ifdef PTXCONF_QT6_MODULE_QTDECLARATIVE_QMLSCENE
	@$(call install_copy, qt6, 0, 0, 0755, -, /usr/bin/qmlscene)
endif

	@$(call install_finish, qt6)

	@$(call touch)

# vim: syntax=make
