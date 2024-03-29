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

OPENCV_VERSION	:= 4.4.0
OPENCV_MD5	:= 4b00f5cdb1cf393c4a84696362c5a72a
OPENCV		:= opencv-$(OPENCV_VERSION)
OPENCV_SUFFIX	:= zip
OPENCV_URL	:= \
	$(call ptx/mirror, SF, opencvlibrary/opencv-unix/$(OPENCV_VERSION)/$(OPENCV).$(OPENCV_SUFFIX)) \
	https://github.com/opencv/opencv/archive/$(OPENCV_VERSION).$(OPENCV_SUFFIX)
OPENCV_SOURCE	:= $(SRCDIR)/$(OPENCV).$(OPENCV_SUFFIX)
OPENCV_DIR	:= $(BUILDDIR)/$(OPENCV)
OPENCV_LICENSE	:= BSD
OPENCV_BUILD_DIR := $(OPENCV_DIR)-build

ifdef PTXCONF_OPENCV_EXAMPLES
# the examples are installed from the build tree
OPENCV_DEVPKG	:= NO
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# set PKG_CONFIG_LIBDIR to something, otherwise opencv will not use
# pkg-config when cross-compiling. The value does not matter, the wrapper
# overwrites it anyways.
OPENCV_CONF_ENV		:= \
	$(CROSS_ENV) \
	PKG_CONFIG_LIBDIR=not-empty

OPENCV_CONF_TOOL	:= cmake

# Note: configure_helper.py does not show some options that are only
# valid on other architectures. Run is for ARM and x86_64 and mix the results.
# Variables that are not shown by configure_helper.py are added at the end.
OPENCV_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DANT_EXECUTABLE= \
	-DBUILD_CUDA_STUBS=OFF \
	-DBUILD_DOCS=OFF \
	-DBUILD_EXAMPLES=$(call ptx/onoff, PTXCONF_OPENCV_EXAMPLES) \
	-DBUILD_IPP_IW=ON \
	-DBUILD_ITT=ON \
	-DBUILD_JASPER=OFF \
	-DBUILD_JAVA=OFF \
	-DBUILD_JPEG=OFF \
	-DBUILD_LIST= \
	-DBUILD_OPENEXR=OFF \
	-DBUILD_PACKAGE=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DBUILD_PNG=OFF \
	-DBUILD_PROTOBUF=ON \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TBB=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_TIFF=OFF \
	-DBUILD_USE_SYMLINKS=OFF \
	-DBUILD_WEBP=OFF \
	-DBUILD_WITH_DEBUG_INFO=OFF \
	-DBUILD_WITH_DYNAMIC_IPP=OFF \
	-DBUILD_ZLIB=OFF \
	-DBUILD_opencv_apps=OFF \
	-DBUILD_opencv_calib3d=$(call ptx/onoff,PTXCONF_OPENCV_CALIB3D) \
	-DBUILD_opencv_core=ON \
	-DBUILD_opencv_dnn=$(call ptx/onoff,PTXCONF_OPENCV_DNN) \
	-DBUILD_opencv_features2d=$(call ptx/onoff,PTXCONF_OPENCV_FEATURES2D) \
	-DBUILD_opencv_flann=$(call ptx/onoff,PTXCONF_OPENCV_FLANN) \
	-DBUILD_opencv_highgui=$(call ptx/onoff,PTXCONF_OPENCV_HIGHGUI)  \
	-DBUILD_opencv_imgcodecs=$(call ptx/onoff,PTXCONF_OPENCV_IMGCODECS) \
	-DBUILD_opencv_imgproc=$(call ptx/onoff,PTXCONF_OPENCV_IMGPROC) \
	-DBUILD_opencv_java_bindings_generator=ON \
	-DBUILD_opencv_js=OFF \
	-DBUILD_opencv_ml=$(call ptx/onoff,PTXCONF_OPENCV_ML) \
	-DBUILD_opencv_objdetect=$(call ptx/onoff,PTXCONF_OPENCV_OBJDETECT) \
	-DBUILD_opencv_photo=$(call ptx/onoff,PTXCONF_OPENCV_PHOTO) \
	-DBUILD_opencv_python3=$(call ptx/onoff,PTXCONF_OPENCV_PYTHON) \
	-DBUILD_opencv_python_bindings_generator=$(call ptx/onoff,PTXCONF_OPENCV_PYTHON) \
	-DBUILD_opencv_python_tests=ON \
	-DBUILD_opencv_stitching=$(call ptx/onoff,PTXCONF_OPENCV_STITCHING) \
	-DBUILD_opencv_ts=OFF \
	-DBUILD_opencv_video=$(call ptx/onoff,PTXCONF_OPENCV_VIDEO) \
	-DBUILD_opencv_videoio=$(call ptx/onoff,PTXCONF_OPENCV_VIDEOIO) \
	-DBUILD_opencv_world=OFF \
	-DCPU_BASELINE=DETECT \
	-DCPU_DISPATCH= \
	-DCV_DISABLE_OPTIMIZATION=OFF \
	-DCV_ENABLE_INTRINSICS=ON \
	-DCV_TRACE=ON \
	-DENABLE_BUILD_HARDENING=OFF \
	-DENABLE_CCACHE=OFF \
	-DENABLE_CONFIG_VERIFICATION=OFF \
	-DENABLE_COVERAGE=OFF \
	-DENABLE_FAST_MATH=ON \
	-DENABLE_GNU_STL_DEBUG=OFF \
	-DENABLE_IMPL_COLLECTION=OFF \
	-DENABLE_INSTRUMENTATION=OFF \
	-DENABLE_LTO=OFF \
	-DENABLE_NEON=$(call ptx/onoff,PTXCONF_ARCH_ARM_NEON) \
	-DENABLE_NOISY_WARNINGS=OFF \
	-DENABLE_OMIT_FRAME_POINTER=ON \
	-DENABLE_PIC=ON \
	-DENABLE_PROFILING=OFF \
	-DENABLE_SOLUTION_FOLDERS=OFF \
	-DENABLE_VFPV3=OFF \
	-DEXECUTABLE_OUTPUT_PATH=$(OPENCV_BUILD_DIR)/bin \
	-DGENERATE_ABI_DESCRIPTOR=OFF \
	-DINSTALL_CREATE_DISTRIB=OFF \
	-DINSTALL_C_EXAMPLES=$(call ptx/onoff,PTXCONF_OPENCV_EXAMPLES) \
	-DINSTALL_PYTHON_EXAMPLES=OFF \
	-DINSTALL_TESTS=OFF \
	-DINSTALL_TO_MANGLED_PATHS=OFF \
	-DMKL_WITH_OPENMP=OFF \
	-DMKL_WITH_TBB=OFF \
	-DOPENCV_DNN_CUDA=OFF \
	-DOPENCV_DNN_OPENCL=ON \
	-DOPENCV_DOWNLOAD_PATH=$(OPENCV_DIR)/.cache \
	-DOPENCV_DUMP_HOOKS_FLOW=OFF \
	-DOPENCV_ENABLE_ALLOCATOR_STATS=ON \
	-DOPENCV_ENABLE_ATOMIC_LONG_LONG=ON \
	-DOPENCV_ENABLE_MEMALIGN=ON \
	-DOPENCV_ENABLE_MEMORY_SANITIZER=OFF \
	-DOPENCV_ENABLE_NONFREE=OFF \
	-DOPENCV_EXTRA_MODULES_PATH= \
	-DOPENCV_FORCE_3RDPARTY_BUILD=OFF \
	-DOPENCV_GENERATE_PKGCONFIG=ON \
	-DOPENCV_GENERATE_SETUPVARS=ON \
	-DOPENCV_IPP_GAUSSIAN_BLUR=OFF \
	-DOPENCV_MATHJAX_RELPATH=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0 \
	-DOPENCV_PYTHON3_VERSION=$(PYTHON3_MAJORMINOR) \
	-DOPENCV_WARNINGS_ARE_ERRORS=OFF \
	-DPROTOBUF_UPDATE_FILES=OFF \
	-DPYTHON3_EXECUTABLE=$(PTXDIST_SYSROOT_CROSS)/usr/bin/python$(PYTHON3_MAJORMINOR) \
	-DPYTHON3_NUMPY_INCLUDE_DIRS=$(PTXDIST_SYSROOT_TARGET)$(PYTHON3_SITEPACKAGES)/numpy/core/include/ \
	-DWITH_1394=OFF \
	-DWITH_ADE=OFF \
	-DWITH_ARAVIS=OFF \
	-DWITH_CAROTENE=OFF \
	-DWITH_CLP=OFF \
	-DWITH_CUBLAS=OFF \
	-DWITH_CUDA=OFF \
	-DWITH_CUFFT=OFF \
	-DWITH_EIGEN=OFF \
	-DWITH_FFMPEG=OFF \
	-DWITH_FREETYPE=OFF \
	-DWITH_GDAL=OFF \
	-DWITH_GDCM=OFF \
	-DWITH_GIGEAPI=OFF \
	-DWITH_GPHOTO2=OFF \
	-DWITH_GSTREAMER=$(call ptx/onoff,PTXCONF_OPENCV_GSTREAMER) \
	-DWITH_GTK=OFF \
	-DWITH_GTK_2_X=OFF \
	-DWITH_HALIDE=OFF \
	-DWITH_HPX=OFF \
	-DWITH_IMGCODEC_HDR=ON \
	-DWITH_IMGCODEC_PFM=ON \
	-DWITH_IMGCODEC_PXM=ON \
	-DWITH_IMGCODEC_SUNRASTER=ON \
	-DWITH_INF_ENGINE=OFF \
	-DWITH_IPP=OFF \
	-DWITH_IPP_A=OFF \
	-DWITH_ITT=ON \
	-DWITH_JASPER=OFF \
	-DWITH_JPEG=ON \
	-DWITH_LAPACK=ON \
	-DWITH_LIBREALSENSE=OFF \
	-DWITH_LIBV4L=$(call ptx/onoff,PTXCONF_OPENCV_V4L_LIBV4L2) \
	-DWITH_MFX=OFF \
	-DWITH_NGRAPH=OFF \
	-DWITH_NVCUVID=OFF \
	-DWITH_OPENCL=ON \
	-DWITH_OPENCLAMDBLAS=OFF \
	-DWITH_OPENCLAMDFFT=OFF \
	-DWITH_OPENCL_SVM=OFF \
	-DWITH_OPENEXR=OFF \
	-DWITH_OPENGL=OFF \
	-DWITH_OPENJPEG=OFF \
	-DWITH_OPENMP=OFF \
	-DWITH_OPENNI=OFF \
	-DWITH_OPENNI2=OFF \
	-DWITH_OPENVX=OFF \
	-DWITH_PLAIDML=OFF \
	-DWITH_PNG=ON \
	-DWITH_PROTOBUF=ON \
	-DWITH_PTHREADS_PF=OFF \
	-DWITH_PVAPI=OFF \
	-DWITH_QT=$(call ptx/ifdef,PTXCONF_OPENCV_QT,5,OFF) \
	-DWITH_QUIRC=ON \
	-DWITH_TBB=OFF \
	-DWITH_TENGINE=OFF \
	-DWITH_TIFF=OFF \
	-DWITH_UNICAP=OFF \
	-DWITH_V4L=$(call ptx/onoff,PTXCONF_OPENCV_V4L) \
	-DWITH_VA=OFF \
	-DWITH_VA_INTEL=OFF \
	-DWITH_VULKAN=OFF \
	-DWITH_WEBP=OFF \
	-DWITH_XIMEA=OFF \
	-DWITH_XINE=OFF \
	-Dopencv_dnn_PERF_CAFFE=OFF \
	-Dopencv_dnn_PERF_CLCAFFE=OFF \
	\
	-DCMAKE_SKIP_RPATH=ON \
	-DBUILD_opencv_python2=OFF \
	-DPYTHON_INCLUDE_DIR=$(PTXDIST_SYSROOT_TARGET)/usr/include/python$(PYTHON3_MAJORMINOR) \
	-DPYTHON_LIBRARY=$(PTXDIST_SYSROOT_TARGET)/bin/python$(PYTHON3_MAJORMINOR) \
	-DOPENCV_PYTHON3_INSTALL_PATH=$(PYTHON3_SITEPACKAGES) \
	-DOPENCV_SKIP_PYTHON_LOADER=ON \
	-DOPENCV_LAPACK_FIND_PACKAGE_ONLY=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LAPACK=ON


$(STATEDIR)/opencv.install:
	@$(call targetinfo)
	@$(call world/install, OPENCV)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

OPENCV_LIBS-y					:= libopencv_core
OPENCV_LIBS-$(PTXCONF_OPENCV_CALIB3D)		+= libopencv_calib3d
OPENCV_LIBS-$(PTXCONF_OPENCV_DNN)		+= libopencv_dnn
OPENCV_LIBS-$(PTXCONF_OPENCV_FEATURES2D)	+= libopencv_features2d
OPENCV_LIBS-$(PTXCONF_OPENCV_FLANN)		+= libopencv_flann
OPENCV_LIBS-$(PTXCONF_OPENCV_HIGHGUI)		+= libopencv_highgui
OPENCV_LIBS-$(PTXCONF_OPENCV_IMGCODECS)		+= libopencv_imgcodecs
OPENCV_LIBS-$(PTXCONF_OPENCV_IMGPROC)		+= libopencv_imgproc
OPENCV_LIBS-$(PTXCONF_OPENCV_ML)		+= libopencv_ml
OPENCV_LIBS-$(PTXCONF_OPENCV_OBJDETECT)		+= libopencv_objdetect
OPENCV_LIBS-$(PTXCONF_OPENCV_PHOTO)		+= libopencv_photo
OPENCV_LIBS-$(PTXCONF_OPENCV_STITCHING)		+= libopencv_stitching
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
		$(call install_lib, opencv, 0, 0, 0644, $(lib))$(ptx/nl))
ifdef PTXCONF_OPENCV_EXAMPLES
	@$(call install_tree, opencv, 0, 0, $(OPENCV_BUILD_DIR)/bin, /bin)
endif
ifdef PTXCONF_OPENCV_PYTHON
	@$(call install_tree, opencv, 0, 0, -, $(PYTHON3_SITEPACKAGES))
endif
	@$(call install_finish, opencv)
	@$(call touch)

# vim: syntax=make
