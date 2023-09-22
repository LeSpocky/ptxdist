# -*-makefile-*-
#
# Copyright (C) 2019 by Marian Cichy <m.cichy@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LLVM) += host-llvm

#
# Paths and names
#

HOST_LLVM_CMAKE_MD5		 = $(LLVM_CMAKE_MD5)
HOST_LLVM_CMAKE_URL		 = $(LLVM_CMAKE_URL)
HOST_LLVM_CMAKE_SOURCE		 = $(LLVM_CMAKE_SOURCE)
HOST_LLVM_CMAKE_DIR		 = $(HOST_BUILDDIR)/$(HOST_LLVM)/cmake

HOST_LLVM_SOURCES		:= $(HOST_LLVM_SOURCE) $(HOST_LLVM_CMAKE_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-llvm.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_LLVM_DIR))
	@$(call extract, HOST_LLVM)
	@$(call extract, HOST_LLVM_CMAKE)
	@$(call patchin, HOST_LLVM)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_LLVM_CONF_TOOL	:= cmake
HOST_LLVM_CONF_OPT	 = \
        $(HOST_CMAKE_OPT) \
	-DCMAKE_INSTALL_PREFIX=/ \
	-G Ninja \
	-DLLVM_BUILD_BENCHMARKS=OFF \
	-DLLVM_BUILD_DOCS=OFF \
	-DLLVM_BUILD_EXAMPLES=OFF \
	-DLLVM_BUILD_EXTERNAL_COMPILER_RT=OFF \
	-DLLVM_BUILD_LLVM_C_DYLIB=OFF \
	-DLLVM_BUILD_LLVM_DYLIB=ON \
	-DLLVM_BUILD_RUNTIME=OFF \
	-DLLVM_BUILD_RUNTIMES=OFF \
	-DLLVM_BUILD_TESTS=OFF \
	-DLLVM_BUILD_TOOLS=ON \
	-DLLVM_BUILD_UTILS=OFF \
	-DLLVM_CCACHE_BUILD=OFF \
	-DLLVM_CODESIGNING_IDENTITY= \
	-DLLVM_DEFAULT_TARGET_TRIPLE= \
	-DLLVM_DEPENDENCY_DEBUGGING=OFF \
	-DLLVM_ENABLE_ASSERTIONS=OFF \
	-DLLVM_ENABLE_BACKTRACES=ON \
	-DLLVM_ENABLE_BINDINGS=OFF \
	-DLLVM_ENABLE_CRASH_DUMPS=OFF \
	-DLLVM_ENABLE_CRASH_OVERRIDES=ON \
	-DLLVM_ENABLE_CURL=OFF \
	-DLLVM_ENABLE_DAGISEL_COV=OFF \
	-DLLVM_ENABLE_DOXYGEN=OFF \
	-DLLVM_ENABLE_DUMP=OFF \
	-DLLVM_ENABLE_EH=OFF \
	-DLLVM_ENABLE_EXPENSIVE_CHECKS=OFF \
	-DLLVM_ENABLE_FFI=OFF \
	-DLLVM_ENABLE_GISEL_COV=OFF \
	-DLLVM_ENABLE_HTTPLIB=OFF \
	-DLLVM_ENABLE_IDE=OFF \
	-DLLVM_ENABLE_LIBCXX=OFF \
	-DLLVM_ENABLE_LIBEDIT=OFF \
	-DLLVM_ENABLE_LIBPFM=OFF \
	-DLLVM_ENABLE_LIBXML2=OFF \
	-DLLVM_ENABLE_LLD=OFF \
	-DLLVM_ENABLE_LOCAL_SUBMODULE_VISIBILITY=ON \
	-DLLVM_ENABLE_LTO=OFF \
	-DLLVM_ENABLE_MODULES=OFF \
	-DLLVM_ENABLE_MODULE_DEBUGGING=OFF \
	-DLLVM_ENABLE_NEW_PASS_MANAGER=TRUE \
	-DLLVM_ENABLE_OCAMLDOC=OFF \
	-DLLVM_ENABLE_PEDANTIC=ON \
	-DLLVM_ENABLE_PIC=ON \
	-DLLVM_ENABLE_PLUGINS=ON \
	-DLLVM_ENABLE_PROJECTS=\
	-DLLVM_ENABLE_RTTI=ON \
	-DLLVM_ENABLE_RUNTIMES= \
	-DLLVM_ENABLE_SPHINX=OFF \
	-DLLVM_ENABLE_STRICT_FIXED_SIZE_VECTORS=OFF \
	-DLLVM_ENABLE_TERMINFO=OFF \
	-DLLVM_ENABLE_THREADS=ON \
	-DLLVM_ENABLE_UNWIND_TABLES=ON \
	-DLLVM_ENABLE_WARNINGS=ON \
	-DLLVM_ENABLE_WERROR=OFF \
	-DLLVM_ENABLE_Z3_SOLVER=OFF \
	-DLLVM_ENABLE_ZLIB=ON \
	-DLLVM_ENABLE_ZSTD=OFF \
	-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD= \
	-DLLVM_EXPORT_SYMBOLS_FOR_PLUGINS=OFF \
	-DLLVM_EXTERNALIZE_DEBUGINFO=OFF \
	-DLLVM_FORCE_ENABLE_STATS=OFF \
	-DLLVM_FORCE_USE_OLD_TOOLCHAIN=OFF \
	-DLLVM_HAVE_TFLITE= \
	-DLLVM_INCLUDE_BENCHMARKS=OFF \
	-DLLVM_INCLUDE_DOCS=OFF \
	-DLLVM_INCLUDE_EXAMPLES=OFF \
	-DLLVM_INCLUDE_RUNTIMES=OFF \
	-DLLVM_INCLUDE_TESTS=OFF \
	-DLLVM_INCLUDE_TOOLS=ON \
	-DLLVM_INCLUDE_UTILS=OFF \
	-DLLVM_INSTALL_BINUTILS_SYMLINKS=OFF \
	-DLLVM_INSTALL_CCTOOLS_SYMLINKS=OFF \
	-DLLVM_INSTALL_GTEST=OFF \
	-DLLVM_INSTALL_MODULEMAPS=OFF \
	-DLLVM_INSTALL_TOOLCHAIN_ONLY=OFF \
	-DLLVM_INSTALL_UTILS=OFF \
	-DLLVM_INTEGRATED_CRT_ALLOC= \
	-DLLVM_LIBDIR_SUFFIX= \
	-DLLVM_LIB_FUZZING_ENGINE= \
	-DLLVM_LINK_LLVM_DYLIB=ON \
	-DLLVM_LOCAL_RPATH= \
	-DLLVM_OMIT_DAGISEL_COMMENTS=ON \
	-DLLVM_OPTIMIZED_TABLEGEN=OFF \
	-DLLVM_OPTIMIZE_SANITIZED_BUILDS=ON \
	-DLLVM_PARALLEL_COMPILE_JOBS= \
	-DLLVM_PARALLEL_LINK_JOBS= \
	-DLLVM_PROFDATA_FILE= \
	-DLLVM_SOURCE_PREFIX= \
	-DLLVM_STATIC_LINK_CXX_STDLIB=OFF \
	-DLLVM_TARGETS_TO_BUILD="$(subst $(space),;,$(LLVM_TARGETS_TO_BUILD))" \
	-DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=OFF \
	-DLLVM_TOOL_BOLT_BUILD=OFF \
	-DLLVM_TOOL_CLANG_BUILD=OFF \
	-DLLVM_TOOL_COMPILER_RT_BUILD=OFF \
	-DLLVM_TOOL_DRAGONEGG_BUILD=OFF \
	-DLLVM_TOOL_FLANG_BUILD=OFF \
	-DLLVM_TOOL_LIBCXXABI_BUILD=OFF \
	-DLLVM_TOOL_LIBCXX_BUILD=OFF \
	-DLLVM_TOOL_LIBC_BUILD=OFF \
	-DLLVM_TOOL_LIBUNWIND_BUILD=OFF \
	-DLLVM_TOOL_LLDB_BUILD=OFF \
	-DLLVM_TOOL_LLD_BUILD=OFF \
	-DLLVM_TOOL_MLIR_BUILD=OFF \
	-DLLVM_TOOL_OPENMP_BUILD=OFF \
	-DLLVM_TOOL_POLLY_BUILD=OFF \
	-DLLVM_TOOL_PSTL_BUILD=OFF \
	-DLLVM_UNREACHABLE_OPTIMIZE=ON \
	-DLLVM_USE_FOLDERS=ON \
	-DLLVM_USE_INTEL_JITEVENTS=OFF \
	-DLLVM_USE_OPROFILE=OFF \
	-DLLVM_USE_PERF=ON \
	-DLLVM_USE_RELATIVE_PATHS_IN_DEBUG_INFO=OFF \
	-DLLVM_USE_RELATIVE_PATHS_IN_FILES=OFF \
	-DLLVM_USE_SANITIZER= \
	-DLLVM_USE_SPLIT_DWARF=OFF \
	-DLLVM_USE_STATIC_ZSTD=FALSE \
	-DLLVM_USE_SYMLINKS=ON \
	-DLLVM_VERSION_PRINTER_SHOW_HOST_TARGET_INFO=ON \
	-DLLVM_WINDOWS_PREFER_FORWARD_SLASH=OFF

HOST_LLVM_MAKE_OPT	:= \
	llvm-config \
	llvm-libraries \
	llvm-tblgen

HOST_LLVM_INSTALL_OPT	:= \
	install-llvm-libraries \
	install-llvm-config

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-llvm.install:
	@$(call targetinfo)
	@$(call world/install, HOST_LLVM)
	@install -vD -m755 $(HOST_LLVM_DIR)-build/bin/llvm-tblgen \
		$(HOST_LLVM_PKGDIR)/usr/bin/llvm-tblgen
	@$(call touch)

# vim: syntax=make
