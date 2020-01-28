# -*-makefile-*-
#
# Copyright (C) 2014 by Christoph Fritz <chf.fritz@googlemail.com>
# Copyright (C) 2013 by Jan Weitzel <J.Weitzel@phytec.de>
# loosely based on work by Roman Dosek <formatsh@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENCV) += opencv

#
# Paths and names
#

OPENCV_VERSION	:= 4.1.2
OPENCV_MD5	:= 6b390578d57131ae9d6c2a183257399d
OPENCV		:= opencv-$(OPENCV_VERSION)
OPENCV_SUFFIX	:= zip
OPENCV_URL	:= \
	$(call ptx/mirror, SF, opencvlibrary/opencv-unix/$(OPENCV_VERSION)/$(OPENCV).$(OPENCV_SUFFIX)) \
	https://github.com/opencv/opencv/archive/$(OPENCV_VERSION).$(OPENCV_SUFFIX)
OPENCV_SOURCE	:= $(SRCDIR)/$(OPENCV).$(OPENCV_SUFFIX)
OPENCV_DIR	:= $(BUILDDIR)/$(OPENCV)
OPENCV_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENCV_CONF_TOOL	:= cmake

OPENCV_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DANT_EXECUTABLE:FILEPATH= \
	-DPYTHON_EXECUTABLE= \
	-DBUILD_DOCS:BOOL=OFF \
	-DBUILD_EXAMPLES:BOOL=$(call ptx/onoff, PTXCONF_OPENCV_EXAMPLES) \
	-DBUILD_PACKAGE:BOOL=OFF \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DBUILD_TESTS=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DBUILD_WITH_DEBUG_INFO=OFF \
	-DBUILD_CUDA_STUBS:BOOL=OFF \
	-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=OFF \
	-DCMAKE_SKIP_RPATH=OFF \
	-DCMAKE_USE_RELATIVE_PATHS=OFF \
	-DENABLE_FAST_MATH=ON \
	-DENABLE_NOISY_WARNINGS=OFF \
	-DENABLE_OMIT_FRAME_POINTER=ON \
	-DENABLE_PRECOMPILED_HEADERS=OFF \
	-DENABLE_PROFILING=OFF \
	-DENABLE_SOLUTION_FOLDERS=OFF \
	-DWITH_GTK:BOOL=OFF \
	-DWITH_TBB:BOOL=OFF \
	-DWITH_TIFF:BOOL=OFF \
	-DWITH_CUDA:BOOL=OFF \
	-DWITH_EIGEN:BOOL=OFF \
	-DENABLE_NEON:BOOL=$(call ptx/ifdef,PTXCONF_ARCH_ARM_NEON,ON,OFF) \
	-DENABLE_VFPV3:BOOL=OFF \
	-DWITH_GIGEAPI:BOOL=OFF \
	-DINSTALL_CREATE_DISTRIB:BOOL=OFF \
	-DINSTALL_C_EXAMPLES:BOOL=OFF \
	-DINSTALL_PYTHON_EXAMPLES:BOOL=OFF \
	-DINSTALL_TO_MANGLED_PATHS:BOOL=OFF \
	-DOPENCV_EXTRA_MODULES_PATH:PATH= \
	-DOPENCV_WARNINGS_ARE_ERRORS:BOOL=OFF \
	-DWITH_OPENEXR:BOOL=OFF \
	-DWITH_PVAPI:BOOL=OFF \
	-DWITH_1394:BOOL=OFF \
	-DWITH_VTK:BOOL=OFF \
	-DWITH_CUBLAS:BOOL=OFF \
	-DWITH_CUDA:BOOL=OFF \
	-DWITH_CUFFT:BOOL=OFF \
	-DWITH_NVCUVID:BOOL=OFF \
	-DWITH_EIGEN:BOOL=OFF \
	-DWITH_FFMPEG:BOOL=OFF \
	-DWITH_JASPER:BOOL=OFF \
	-DWITH_JPEG:BOOL=ON \
	-DWITH_WEBP:BOOL=OFF \
	-DWITH_PNG:BOOL=ON \
	-DWITH_OPENCL:BOOL=ON \
	-DWITH_OPENCL_SVM:BOOL=OFF \
	-DWITH_OPENCLAMDBLAS:BOOL=OFF \
	-DWITH_OPENCLAMDFFT:BOOL=OFF \
	-DWITH_OPENEXR:BOOL=OFF \
	-DWITH_OPENMP:BOOL=OFF \
	-DWITH_PTHREADS_PF:BOOL=OFF \
	-DWITH_OPENNI:BOOL=OFF \
	-DWITH_OPENNI2:BOOL=OFF \
	-DWITH_PVAPI:BOOL=OFF \
	-DWITH_TBB:BOOL=OFF \
	-DWITH_UNICAP:BOOL=OFF \
	-DWITH_XIMEA:BOOL=OFF \
	-DWITH_XINE:BOOL=OFF \
	-DWITH_CLP:BOOL=OFF \
	-DWITH_IPP_A:BOOL=OFF \
	-DWITH_GDAL:BOOL=OFF \
	-DWITH_GPHOTO2:BOOL=OFF \
	-DBUILD_opencv_apps:BOOL=OFF \
	-DBUILD_opencv_calib3d:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_CALIB3D,ON,OFF) \
	-DBUILD_opencv_core:BOOL=ON \
	-DBUILD_opencv_features2d:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_FEATURES2D,ON,OFF) \
	-DBUILD_opencv_flann:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_FLANN,ON,OFF) \
	-DBUILD_opencv_highgui:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_HIGHGUI,ON,OFF) \
	-DBUILD_opencv_imgproc:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_IMGPROC,ON,OFF) \
	-DBUILD_opencv_ml:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_ML,ON,OFF) \
	-DBUILD_opencv_objdetect:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_OBJDETECT,ON,OFF) \
	-DBUILD_opencv_photo:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_PHOTO,ON,OFF) \
	-DBUILD_opencv_stitching:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_STITCHING,ON,OFF) \
	-DBUILD_opencv_ts:BOOL=OFF \
	-DBUILD_opencv_video:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_VIDEO,ON,OFF) \
	-DBUILD_opencv_world:BOOL=OFF \
	-DWITH_GSTREAMER:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_GSTREAMER,ON,OFF) \
	-DWITH_V4L:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_V4L,ON,OFF) \
	-DWITH_LIBV4L:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_V4L_LIBV4L2,ON,OFF) \
	-DWITH_OPENGL:BOOL=OFF \
	-DWITH_QT:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_QT,4,OFF)


OPENCV_BUILD_DIR := $(OPENCV_DIR)-build

$(STATEDIR)/opencv.install:
	@$(call targetinfo)
	@$(call world/install, OPENCV)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

OPENCV_LIBS-$(PTXCONF_OPENCV)			:= libopencv_core
OPENCV_LIBS-$(PTXCONF_OPENCV_CALIB3D)		+= libopencv_calib3d
OPENCV_LIBS-$(PTXCONF_OPENCV_FEATURES2D)	+= libopencv_features2d
OPENCV_LIBS-$(PTXCONF_OPENCV_FLANN)		+= libopencv_flann
OPENCV_LIBS-$(PTXCONF_OPENCV_HIGHGUI)		+= libopencv_highgui
OPENCV_LIBS-$(PTXCONF_OPENCV_IMGCODECS)		+= libopencv_imgcodecs
OPENCV_LIBS-$(PTXCONF_OPENCV_IMGPROC)		+= libopencv_imgproc
OPENCV_LIBS-$(PTXCONF_OPENCV_LEGACY)		+= libopencv_legacy
OPENCV_LIBS-$(PTXCONF_OPENCV_ML)		+= libopencv_ml
OPENCV_LIBS-$(PTXCONF_OPENCV_OBJDETECT)		+= libopencv_objdetect
OPENCV_LIBS-$(PTXCONF_OPENCV_PHOTO)		+= libopencv_photo
OPENCV_LIBS-$(PTXCONF_OPENCV_STITCHING)		+= libopencv_stitching
OPENCV_LIBS-$(PTXCONF_OPENCV_SHAPE)		+= libopencv_shape
OPENCV_LIBS-$(PTXCONF_OPENCV_VIDEO)		+= libopencv_video
OPENCV_LIBS-$(PTXCONF_OPENCV_VIDEOIO)		+= libopencv_videoio

$(STATEDIR)/opencv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, opencv)
	@$(call install_fixup, opencv, PRIORITY, optional)
	@$(call install_fixup, opencv, SECTION, base)
	@$(call install_fixup, opencv, AUTHOR, "Christoph Fritz <chf.fritz@googlemail.com>")
	@$(call install_fixup, opencv, DESCRIPTION, missing)

	@$(foreach lib, $(OPENCV_LIBS-y), \
		$(call install_lib, opencv, 0, 0, 0644, $(lib));)
	@$(call install_tree, opencv, 0, 0, $(OPENCV_BUILD_DIR)/bin, /bin)
	@$(call install_finish, opencv)
	@$(call touch)

# vim: syntax=make
