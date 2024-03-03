# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QT6) += host-qt6

HOST_QT6_DIR		 = $(realpath $(HOST_BUILDDIR))/$(HOST_QT6)
HOST_QT6_BUILD_OOT	:= YES

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_QT6_MODULES-y					:= qtbase
HOST_QT6_MODULES-					:=
HOST_QT6_MODULES-$(PTXCONF_HOST_QT6_QTTOOLS)		+= qttools
HOST_QT6_MODULES-$(PTXCONF_HOST_QT6_QTDECLARATIVE)	+= qtdeclarative
HOST_QT6_MODULES-					+= qtimageformats
HOST_QT6_MODULES-					+= qtlanguageserver
HOST_QT6_MODULES-$(PTXCONF_HOST_QT6_QTQUICK3D)		+= qtquick3d
HOST_QT6_MODULES-					+= qtquicktimeline
HOST_QT6_MODULES-$(PTXCONF_HOST_QT6_QTREMOTEOBJECTS)	+= qtremoteobjects
HOST_QT6_MODULES-$(PTXCONF_HOST_QT6_QTSCXML)		+= qtscxml
HOST_QT6_MODULES-$(PTXCONF_HOST_QT6_QTSHADERTOOLS)	+= qtshadertools
HOST_QT6_MODULES-					+= qtsvg
HOST_QT6_MODULES-$(PTXCONF_HOST_QT6_QTWAYLAND)		+= qtwayland

#
# cmake
#
HOST_QT6_CONF_TOOL	:= cmake
HOST_QT6_CONF_OPT	:= \
	-DBUILD_SHARED_LIBS=ON \
	$(foreach module,$(HOST_QT6_MODULES-y),-DBUILD_$(module)=ON) \
	$(foreach module,$(HOST_QT6_MODULES-),-DBUILD_$(module)=OFF) \

HOST_QT6_CONF_OPT	+= \
	-DFEATURE_animation=ON \
	-DFEATURE_appstore_compliant=OFF \
	-DFEATURE_backtrace=OFF \
	-DFEATURE_cborstreamreader=ON \
	-DFEATURE_cborstreamwriter=ON \
	-DFEATURE_ccache=OFF \
	-DFEATURE_commandlineparser=ON \
	-DFEATURE_concatenatetablesproxymodel=OFF \
	-DFEATURE_concurrent=OFF \
	-DFEATURE_cross_compile=OFF \
	-DFEATURE_datestring=ON \
	-DFEATURE_datetimeparser=ON \
	-DFEATURE_dbus=$(call ptx/onoff,PTXCONF_HOST_QT6_DBUS) \
	-DFEATURE_dbus_linked=OFF \
	-DFEATURE_debug=OFF \
	-DFEATURE_debug_and_release=OFF \
	-DFEATURE_developer_build=OFF \
	-DFEATURE_dlopen=ON \
	-DFEATURE_dom=OFF \
	-DFEATURE_doubleconversion=ON \
	-DFEATURE_easingcurve=ON \
	-DFEATURE_enable_gdb_index=OFF \
	-DFEATURE_etw=OFF \
	-DFEATURE_f16c=OFF \
	-DFEATURE_filesystemiterator=ON \
	-DFEATURE_filesystemwatcher=OFF \
	-DFEATURE_force_asserts=OFF \
	-DFEATURE_force_debug_info=OFF \
	-DFEATURE_framework=OFF \
	-DFEATURE_gc_binaries=OFF \
	-DFEATURE_gestures=OFF \
	-DFEATURE_glib=OFF \
	-DFEATURE_glibc=ON \
	-DFEATURE_gui=$(call ptx/onoff,PTXCONF_HOST_QT6_GUI) \
	-DFEATURE_headersclean=OFF \
	-DFEATURE_hijricalendar=OFF \
	-DFEATURE_icu=OFF \
	-DFEATURE_identityproxymodel=OFF \
	-DFEATURE_inotify=OFF \
	-DFEATURE_islamiccivilcalendar=OFF \
	-DFEATURE_itemmodel=ON \
	-DFEATURE_itemmodeltester=OFF \
	-DFEATURE_jalalicalendar=OFF \
	-DFEATURE_journald=OFF \
	-DFEATURE_library=ON \
	-DFEATURE_libudev=OFF \
	-DFEATURE_lttng=OFF \
	-DFEATURE_macdeployqt=OFF \
	-DFEATURE_mimetype=ON \
	-DFEATURE_mimetype_database=ON \
	-DFEATURE_network=$(call ptx/onoff,PTXCONF_HOST_QT6_NETWORK) \
	-DFEATURE_no_prefix=OFF \
	-DFEATURE_optimize_debug=OFF \
	-DFEATURE_optimize_full=OFF \
	-DFEATURE_optimize_size=OFF \
	-DFEATURE_pcre2=ON \
	-DFEATURE_pkg_config=ON \
	-DFEATURE_printsupport=OFF \
	-DFEATURE_private_tests=OFF \
	-DFEATURE_process=ON \
	-DFEATURE_processenvironment=ON \
	-DFEATURE_properties=ON \
	-DFEATURE_proxymodel=ON \
	-DFEATURE_qmake=ON \
	-DFEATURE_qreal=OFF \
	-DFEATURE_reduce_exports=ON \
	-DFEATURE_regularexpression=ON \
	-DFEATURE_relocatable=ON \
	-DFEATURE_rpath=ON \
	-DFEATURE_sanitize_address=OFF \
	-DFEATURE_sanitize_fuzzer_no_link=OFF \
	-DFEATURE_sanitize_memory=OFF \
	-DFEATURE_sanitize_thread=OFF \
	-DFEATURE_sanitize_undefined=OFF \
	-DFEATURE_sanitizer=OFF \
	-DFEATURE_separate_debug_info=OFF \
	-DFEATURE_settings=ON \
	-DFEATURE_shared=ON \
	-DFEATURE_sharedmemory=ON \
	-DFEATURE_shortcut=ON \
	-DFEATURE_signaling_nan=ON \
	-DFEATURE_simulator_and_device=OFF \
	-DFEATURE_slog2=OFF \
	-DFEATURE_sortfilterproxymodel=OFF \
	-DFEATURE_sql=OFF \
	-DFEATURE_stack_protector_strong=OFF \
	-DFEATURE_static=OFF \
	-DFEATURE_stdlib_libcpp=OFF \
	-DFEATURE_stringlistmodel=ON \
	-DFEATURE_syslog=OFF \
	-DFEATURE_system_doubleconversion=OFF \
	-DFEATURE_system_libb2=OFF \
	-DFEATURE_system_pcre2=ON \
	-DFEATURE_system_zlib=ON \
	-DFEATURE_temporaryfile=ON \
	-DFEATURE_testcocoon=OFF \
	-DFEATURE_testlib=ON \
	-DFEATURE_testlib_selfcover=OFF \
	-DFEATURE_textdate=ON \
	-DFEATURE_thread=ON \
	-DFEATURE_timezone=ON \
	-DFEATURE_translation=$(call ptx/onoff,PTXCONF_HOST_QT6_QTTOOLS)  \
	-DFEATURE_transposeproxymodel=ON \
	-DFEATURE_valgrind=OFF \
	-DFEATURE_widgets=OFF \
	-DFEATURE_windeployqt=OFF \
	-DFEATURE_xml=ON \
	-DFEATURE_xmlstream=ON \
	-DFEATURE_xmlstreamreader=ON \
	-DFEATURE_xmlstreamwriter=ON \
	-DFEATURE_zstd=OFF \
	-DINSTALL_ARCHDATADIR=/lib/qt6 \
	-DINSTALL_BINDIR=/bin/qt6 \
	-DINSTALL_DATADIR=/share/qt6 \
	-DINSTALL_INCLUDEDIR=/include/qt6 \
	-DINSTALL_MKSPECSDIR=/lib/qt6/mkspecs \
	-DQT_BUILD_BENCHMARKS=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_EXAMPLES_AS_EXTERNAL=OFF \
	-DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF \
	-DQT_BUILD_MANUAL_TESTS=OFF \
	-DQT_BUILD_MINIMAL_STATIC_TESTS=OFF \
	-DQT_BUILD_SUBMODULES='$(subst $(space),;,$(HOST_QT6_MODULES-) $(HOST_QT6_MODULES-y))' \
	-DQT_BUILD_TESTS=OFF \
	-DQT_BUILD_TESTS_BY_DEFAULT=OFF \
	-DQT_BUILD_TOOLS_BY_DEFAULT=ON \
	-DQT_CMAKE_DEBUG_EXTEND_TARGET=OFF \
	-DQT_CREATE_VERSIONED_HARD_LINK=OFF \
	-DQT_USE_CCACHE=OFF \
	-DQT_WILL_INSTALL=ON \
	-DWARNINGS_ARE_ERRORS=OFF \

ifdef PTXCONF_HOST_QT6_GUI
HOST_QT6_CONF_OPT	+= \
	-DFEATURE_accessibility=OFF \
	-DFEATURE_accessibility_atspi_bridge=OFF \
	-DFEATURE_action=OFF \
	-DFEATURE_clipboard=OFF \
	-DFEATURE_colornames=OFF \
	-DFEATURE_cssparser=OFF \
	-DFEATURE_cursor=ON \
	-DFEATURE_desktopservices=OFF \
	-DFEATURE_directfb=OFF \
	-DFEATURE_draganddrop=ON \
	-DFEATURE_drm_atomic=OFF \
	-DFEATURE_dynamicgl=OFF \
	-DFEATURE_egl=OFF \
	-DFEATURE_egl_x11=OFF \
	-DFEATURE_eglfs=OFF \
	-DFEATURE_eglfs_brcm=OFF \
	-DFEATURE_eglfs_egldevice=OFF \
	-DFEATURE_eglfs_gbm=OFF \
	-DFEATURE_eglfs_mali=OFF \
	-DFEATURE_eglfs_openwfd=OFF \
	-DFEATURE_eglfs_rcar=OFF \
	-DFEATURE_eglfs_viv=OFF \
	-DFEATURE_eglfs_viv_wl=OFF \
	-DFEATURE_eglfs_vsp2=OFF \
	-DFEATURE_eglfs_x11=OFF \
	-DFEATURE_filesystemmodel=OFF \
	-DFEATURE_fontconfig=OFF \
	-DFEATURE_freetype=OFF \
	-DFEATURE_gbm=OFF \
	-DFEATURE_gif=OFF \
	-DFEATURE_harfbuzz=OFF \
	-DFEATURE_highdpiscaling=OFF \
	-DFEATURE_ico=OFF \
	-DFEATURE_im=OFF \
	-DFEATURE_image_heuristic_mask=OFF \
	-DFEATURE_image_text=OFF \
	-DFEATURE_imageformat_bmp=OFF \
	-DFEATURE_imageformat_jpeg=OFF \
	-DFEATURE_imageformat_png=OFF \
	-DFEATURE_imageformat_ppm=OFF \
	-DFEATURE_imageformat_xbm=OFF \
	-DFEATURE_imageformat_xpm=ON \
	-DFEATURE_imageformatplugin=OFF \
	-DFEATURE_imageio_text_loading=OFF \
	-DFEATURE_integrityfb=OFF \
	-DFEATURE_integrityhid=OFF \
	-DFEATURE_jpeg=OFF \
	-DFEATURE_kms=OFF \
	-DFEATURE_libinput=OFF \
	-DFEATURE_libinput_axis_api=OFF \
	-DFEATURE_libinput_hires_wheel_support=OFF \
	-DFEATURE_linuxfb=OFF \
	-DFEATURE_movie=OFF \
	-DFEATURE_mtdev=OFF \
	-DFEATURE_multiprocess=OFF \
	-DFEATURE_opengl=OFF \
	-DFEATURE_opengl_desktop=OFF \
	-DFEATURE_opengl_dynamic=OFF \
	-DFEATURE_opengles2=OFF \
	-DFEATURE_opengles31=OFF \
	-DFEATURE_opengles32=OFF \
	-DFEATURE_opengles3=OFF \
	-DFEATURE_openvg=OFF \
	-DFEATURE_pdf=OFF \
	-DFEATURE_picture=OFF \
	-DFEATURE_png=OFF \
	-DFEATURE_raster_64bit=OFF \
	-DFEATURE_raster_fp=OFF \
	-DFEATURE_sessionmanager=OFF \
	-DFEATURE_standarditemmodel=OFF \
	-DFEATURE_system_freetype=OFF \
	-DFEATURE_system_harfbuzz=OFF \
	-DFEATURE_system_jpeg=OFF \
	-DFEATURE_system_png=OFF \
	-DFEATURE_system_textmarkdownreader=OFF \
	-DFEATURE_systemtrayicon=ON \
	-DFEATURE_tabletevent=OFF \
	-DFEATURE_texthtmlparser=ON \
	-DFEATURE_textmarkdownreader=OFF \
	-DFEATURE_textmarkdownwriter=OFF \
	-DFEATURE_textodfwriter=OFF \
	-DFEATURE_tslib=OFF \
	-DFEATURE_tuiotouch=OFF \
	-DFEATURE_undocommand=OFF \
	-DFEATURE_undogroup=OFF \
	-DFEATURE_undostack=OFF \
	-DFEATURE_validator=ON \
	-DFEATURE_vkgen=OFF \
	-DFEATURE_vkkhrdisplay=OFF \
	-DFEATURE_vnc=OFF \
	-DFEATURE_vsp2=OFF \
	-DFEATURE_vulkan=OFF \
	-DFEATURE_whatsthis=OFF \
	-DFEATURE_wheelevent=OFF \
	-DFEATURE_xcb=OFF \
	-DFEATURE_xcb_xlib=OFF \
	-DFEATURE_xkbcommon=OFF \
	-DFEATURE_xkbcommon_x11=OFF \
	-DFEATURE_xlib=OFF
endif

ifdef PTXCONF_HOST_QT6_NETWORK
HOST_QT6_CONF_OPT	+= \
	-DFEATURE_brotli=OFF \
	-DFEATURE_dnslookup=OFF \
	-DFEATURE_dtls=OFF \
	-DFEATURE_gssapi=OFF \
	-DFEATURE_http=OFF \
	-DFEATURE_libproxy=OFF \
	-DFEATURE_linux_netlink=OFF \
	-DFEATURE_localserver=ON \
	-DFEATURE_networkdiskcache=OFF \
	-DFEATURE_networkinterface=OFF \
	-DFEATURE_networklistmanager=OFF \
	-DFEATURE_networkproxy=OFF \
	-DFEATURE_ocsp=OFF \
	-DFEATURE_openssl=OFF \
	-DFEATURE_schannel=OFF \
	-DFEATURE_sctp=OFF \
	-DFEATURE_securetransport=OFF \
	-DFEATURE_socks5=OFF \
	-DFEATURE_ssl=OFF \
	-DFEATURE_system_proxies=ON \
	-DFEATURE_topleveldomain=OFF \
	-DFEATURE_udpsocket=OFF
endif

ifdef PTXCONF_HOST_QT6_QTTOOLS
HOST_QT6_CONF_OPT	+= \
	-DFEATURE_assistant=OFF \
	-DFEATURE_clang=OFF \
	-DFEATURE_clangcpp=OFF \
	-DFEATURE_designer=OFF \
	-DFEATURE_distancefieldgenerator=OFF \
	-DFEATURE_kmap2qmap=OFF \
	-DFEATURE_linguist=ON \
	-DFEATURE_pixeltool=OFF \
	-DFEATURE_qdbus=OFF \
	-DFEATURE_qev=OFF \
	-DFEATURE_qtattributionsscanner=OFF \
	-DFEATURE_qtdiag=OFF \
	-DFEATURE_qtplugininfo=OFF \
	\
	-DCMAKE_DISABLE_FIND_PACKAGE_Clang=ON
endif

ifdef PTXCONF_HOST_QT6_QTDECLARATIVE
HOST_QT6_CONF_OPT	+= \
	-DFEATURE_qml_animation=OFF \
	-DFEATURE_qml_debug=ON \
	-DFEATURE_qml_delegate_model=ON \
	-DFEATURE_qml_devtools=ON \
	-DFEATURE_qml_itemmodel=ON \
	-DFEATURE_qml_jit=OFF \
	-DFEATURE_qml_list_model=OFF \
	-DFEATURE_qml_locale=ON \
	-DFEATURE_qml_network=ON \
	-DFEATURE_qml_object_model=ON \
	-DFEATURE_qml_preview=OFF \
	-DFEATURE_qml_profiler=ON \
	-DFEATURE_qml_python=ON \
	-DFEATURE_qml_sequence_object=OFF \
	-DFEATURE_qml_table_model=ON \
	-DFEATURE_qml_worker_script=OFF \
	-DFEATURE_qml_xml_http_request=OFF \
	-DFEATURE_qml_xmllistmodel=OFF \
	-DFEATURE_quick_animatedimage=OFF \
	-DFEATURE_quick_canvas=OFF \
	-DFEATURE_quick_designer=OFF \
	-DFEATURE_quick_draganddrop=OFF \
	-DFEATURE_quick_flipable=OFF \
	-DFEATURE_quick_gridview=ON \
	-DFEATURE_quick_itemview=ON \
	-DFEATURE_quick_listview=ON \
	-DFEATURE_quick_particles=OFF \
	-DFEATURE_quick_path=OFF \
	-DFEATURE_quick_pathview=OFF \
	-DFEATURE_quick_positioners=OFF \
	-DFEATURE_quick_repeater=OFF \
	-DFEATURE_quick_shadereffect=ON \
	-DFEATURE_quick_sprite=OFF \
	-DFEATURE_quick_tableview=ON \
	-DFEATURE_quick_treeview=ON \
	-DFEATURE_quick_viewtransitions=ON \
	-DFEATURE_quickcontrols2_basic=OFF \
	-DFEATURE_quickcontrols2_fusion=OFF \
	-DFEATURE_quickcontrols2_imagine=OFF \
	-DFEATURE_quickcontrols2_macos=OFF \
	-DFEATURE_quickcontrols2_material=OFF \
	-DFEATURE_quickcontrols2_universal=OFF \
	-DFEATURE_quickcontrols2_windows=OFF \
	-DFEATURE_quicktemplates2_calendar=OFF \
	-DFEATURE_quicktemplates2_hover=OFF \
	-DFEATURE_quicktemplates2_multitouch=OFF
endif

ifdef PTXCONF_HOST_QT6_QTQUICK3D
HOST_QT6_CONF_OPT	+= \
	-DFEATURE_quick3d_assimp=OFF \
	-DFEATURE_system_assimp=OFF
endif

ifdef PTXCONF_HOST_QT6_QTSCXML
HOST_QT6_CONF_OPT	+= \
	-DFEATURE_qeventtransition=OFF \
	-DFEATURE_scxml_ecmascriptdatamodel=OFF
endif

ifdef PTXCONF_HOST_QT6_QTWAYLAND
HOST_QT6_CONF_OPT	+= \
	-DFEATURE_wayland_brcm=OFF \
	-DFEATURE_wayland_client=OFF \
	-DFEATURE_wayland_datadevice=OFF \
	-DFEATURE_wayland_dmabuf_server_buffer=OFF \
	-DFEATURE_wayland_drm_egl_server_buffer=OFF \
	-DFEATURE_wayland_egl=OFF \
	-DFEATURE_wayland_libhybris_egl_server_buffer=OFF \
	-DFEATURE_wayland_server=OFF \
	-DFEATURE_wayland_shm_emulation_server_buffer=OFF \
	-DFEATURE_wayland_text_input_v4_wip=OFF \
	-DFEATURE_wayland_vulkan_server_buffer=OFF
endif

HOST_QT6_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-G Ninja \
	-DCMAKE_INSTALL_PREFIX=/ \
	-DINPUT_opengl=no \
	-DPYTHON_EXECUTABLE=$(SYSTEMPYTHON3) \
	$(sort $(HOST_QT6_CONF_OPT))

HOST_QT6_MAKE_ENV := \
	ICECC_REMOTE_CPP=0

$(STATEDIR)/host-qt6.prepare:
	@$(call targetinfo)
	@$(call world/prepare, HOST_QT6)
ifdef PTXCONF_HOST_QT6_QTWEBENGINE
	@$(call execute, HOST_QT6, \
		$(SYSTEMPYTHON3) \
		$(HOST_QT6_DIR)/qtwebengine/src/3rdparty/gn/build/gen.py \
		--allow-warnings \
		--no-last-commit-position \
		--no-static-libstdc++ \
		--out-path $(HOST_QT6_DIR)-build/qtwebengine/gn \
		--cxx $(HOSTCXX) \
		--cc $(HOSTCC) \
		--ld $(HOSTCXX) \
		--qt-version $(HOST_QT6_VERSION))
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-qt6.compile:
	@$(call targetinfo)
	@$(call world/compile, HOST_QT6)
ifdef PTXCONF_HOST_QT6_QTWEBENGINE
	@$(call compile, HOST_QT6, \
		-C $(HOST_QT6_DIR)-build/qtwebengine/gn)
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_QT6_QT_CONF := $(HOST_QT6_PKGDIR)/usr/bin/qt6/qt.conf

HOST_QT6_TOOLS := \
	lconvert \
	lrelease \
	lupdate \
	qdbuscpp2xml \
	qdbusxml2cpp \
	qmake \
	qmldom \
	qmlformat \
	qmllint \
	qmltc \
	qsb

$(STATEDIR)/host-qt6.install:
	@$(call targetinfo)
	@$(call world/install, HOST_QT6)
	@$(foreach tool, $(HOST_QT6_TOOLS), \
		ln -vsf qt6/$(tool) $(HOST_QT6_PKGDIR)/usr/bin/$(tool)-qt6$(ptx/nl))
ifdef PTXCONF_HOST_QT6_QTWEBENGINE
	@install -vD -m755 $(HOST_QT6_DIR)-build/qtwebengine/gn/gn \
		$(HOST_QT6_PKGDIR)/usr/lib/qt6/libexec/gn
endif
	@echo "[Paths]"					>  $(HOST_QT6_QT_CONF)
	@echo "HostPrefix=../.."			>> $(HOST_QT6_QT_CONF)
	@echo "HostArchData=lib/qt6"			>> $(HOST_QT6_QT_CONF)
	@echo "HostData=lib/qt6"			>> $(HOST_QT6_QT_CONF)
	@echo "HostBinaries=bin/qt6"			>> $(HOST_QT6_QT_CONF)
	@echo "HostLibraryExecutables=lib/qt6/libexec"	>> $(HOST_QT6_QT_CONF)
	@echo "Prefix=../.."				>> $(HOST_QT6_QT_CONF)
	@echo "ArchData=lib/qt6"			>> $(HOST_QT6_QT_CONF)
	@echo "Headers=include/qt6"			>> $(HOST_QT6_QT_CONF)
	@echo "Data=share/qt6"				>> $(HOST_QT6_QT_CONF)
	@echo "Binaries=bin/qt6"			>> $(HOST_QT6_QT_CONF)
	@echo "LibraryExecutables=lib/qt6/libexec"	>> $(HOST_QT6_QT_CONF)
	@echo ""					>> $(HOST_QT6_QT_CONF)
	@$(call touch)

# vim: syntax=make
