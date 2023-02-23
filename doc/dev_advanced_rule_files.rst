*******************
Advanced Rule Files
*******************

The previous example on how to create a rule file sometimes works as
shown above. But most of the time source archives are not that simple.
In this section we want to give the user a more detailed selection how
the package will be built.

Adding Static Configure Parameters
==================================

The ``configure`` scripts of various source archives provide additional
parameters to enable or disable features, or to configure them in a
specific way.

We assume the ``configure`` script of our ``foo`` example (refer to
section :ref:`foo_example`) supports two additional parameters:

-  **--enable-debug**: Make the program more noisy. It’s disabled by
   default.

-  **--with-bar**: Also build the special executable **bar**. Building
   this executable is also disabled by default.

We now want to forward these options to the ``configure`` script when it
runs in the *prepare* stage. To do so, we must again open the rule file
with our favourite editor and navigate to the *prepare* stage entry.

PTXdist uses the variable ``FOO_CONF_OPT`` as the list of parameters to
be given to ``configure``.

Currently this variable is commented out and defined to:

.. code-block:: make

    # FOO_CONF_OPT := $(CROSS_AUTOCONF_USR)

The variable ``CROSS_AUTOCONF_USR`` is predefined by PTXdist and
contains all basic parameters to instruct ``configure`` to prepare for a
**cross** compile environment.

To use the two additional mentioned ``configure`` parameters, we comment
in this line and supplement this expression as follows:

.. code-block:: make

    FOO_CONF_OPT := \
        $(CROSS_AUTOCONF_USR) \
        --enable-debug \
        --with-bar

.. note:: We recommend to use this format with each parameter on a line of
 its own. This format is easier to read and a diff shows more exactly any
 change.

To do a fast check if this addition was successful, we run:

.. code-block:: text

    $ ptxdist print FOO_CONF_OPT
    --prefix=/usr --sysconfdir=/etc --host=|ptxdistCompilerName| --build=i686-host-linux-gnu --enable-debug --with-bar

.. note:: It depends on the currently selected platform and its architecture
 what content this variable will have. The content shown above is an
 example for a target.

Or re-build the package with the new settings:

.. code-block:: text

    $ ptxdist drop foo prepare
    $ ptxdist targetinstall foo

Adding Dynamic Configure Parameters
===================================

Sometimes it makes sense to add this kind of parameters on demand only;
especially a parameter like ``--enable-debug``. To let the user decide
if this parameter is to be used or not, we must add a menu entry. So,
let’s expand our menu. Here is its current content:

.. code-block:: kconfig

    ## SECTION=project_specific

    config FOO
            tristate
            prompt "foo"
            help
              FIXME

We’ll add two menu entries, one for each optional parameter we want to
add on demand to the ``configure`` parameters:

.. code-block:: kconfig

    ## SECTION=project_specific

    config FOO
           tristate
           prompt "foo"
           help
             FIXME

    if FOO
    config FOO_DEBUG
           bool
           prompt "add debug noise"

    config FOO_BAR
           bool
           prompt "build bar"

    endif

.. important:: Always follow the rule to extend the base name by a suboption
  name as the trailing part of the variable name. This gives PTXdist the ability
  to detect a change in the package’s settings (via menuconfig) to force its
  rebuild on demand.

To make usage of the new menu entries, we must check them in the rule
file and add the correct parameters:

.. code-block:: make

    #
    # autoconf
    #
    FOO_CONF_OPT := \
        $(CROSS_AUTOCONF_USR) \
        --$(call ptx/endis, PTXCONF_FOO_DEBUG)-debug \
        --$(call ptx/wwo, PTXCONF_FOO_BAR)-bar

.. important:: Please note the leading ``PTXCONF_`` for each define. While Kconfig is
  using ``FOO_BAR``, the rule file must use ``PTXCONF_FOO_BAR`` instead.

.. note:: Refer :ref:`Rule File Macro Reference <param_macros>` for further
   details about these special kind of option macros (e.g. ``ptx/...``).

It is a good practice to always add both settings, e.g. ``--disable-debug``
even if this is the default case. Sometimes ``configure`` tries to guess
something and the binary result might differ depending on the build
order. For example some kind of package would also build some X related
tools, if X libraries are found. In this case it depends on the build
order, if the X related tools are built or not. All the autocheck
features are problematic here. So, if we do not want ``configure`` to
guess its settings we **must disable everything we do not want**.

To support this process, PTXdist supplies a helper script, located at
``/path/to/ptxdist/scripts/configure-helper.py`` that compares the configure
output with the settings from ``FOO_CONF_OPT``:

.. code-block:: text

    $ /opt/ptxdist-2017.06.0/scripts/configure-helper.py -p libsigrok
    --- rules/libsigrok.make
    +++ libsigrok-0.5.0
    @@ -4,3 +4,74 @@
     	--libdir=/usr/lib
     	--build=x86_64-host-linux-gnu
     	--host=arm-v7a-linux-gnueabihf
    +	--enable-warnings=min|max|fatal|no
    +	--disable-largefile
    +	--enable-all-drivers
    +	--enable-agilent-dmm
    [...]
    +	--enable-ruby
    +	--enable-java
    +	--without-libserialport
    +	--without-libftdi
    +	--without-libusb
    +	--without-librevisa
    +	--without-libgpib
    +	--without-libieee1284
    +	--with-jni-include-path=DIR-LIST

In this example, many configure options from libsigrok (marked with ``+``)
are not yet present in ``LIBSIGROK_CONF_OPT`` and must be added, possibly also
by providing more dynamic options in the package definition.

If some parts of a package are built on demand only, they must also be
installed on demand only. Besides the *prepare* stage, we also must
modify our *targetinstall* stage:

.. code-block:: make

    	@$(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/foo, /usr/bin/foo)

    ifdef PTXCONF_FOO_BAR
    	@$(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/bar, /usr/bin/bar)
    endif

    	@$(call install_finish, foo)
    	@$(call touch)

Now we can play with our new menu entries and check if they are working
as expected:

.. code-block:: text

    $ ptxdist menuconfig
    $ ptxdist targetinstall foo

Whenever we change a *FOO* related menu entry, PTXdist should detect it
and re-build the package when a new build is started.

.. _external_dependencies:

Managing External Compile Time Dependencies
===========================================

While running the prepare stage, it could happen that it fails due to a
missing external dependency.

For example:

.. code-block:: text

    checking whether zlib exists....failed

In this example, our new package depends on the compression library
*zlib*. PTXdist comes with a target *zlib*. All we need to do in this
case is to declare that our new package *foo* depends on *zlib*. This
kind of dependency is managed in the menu file of our new package by
simply adding the ``select ZLIB`` line. After this addition our menu
file looks like:

.. code-block:: kconfig

    ## SECTION=project_specific

    config FOO
           tristate
           select ZLIB
           prompt "foo"
           help
             FIXME

    if FOO
    config FOO_DEBUG
           bool
           prompt "add debug noise"

    config FOO_BAR
           bool
           prompt "build bar"

    endif

PTXdist now builds the *zlib* first and our new package thereafter.

Refer :ref:`external_dependencies_variants` for more specific dependency
description.

Managing External Compile Time Dependencies on Demand
=====================================================

It is good practice to add only those dependencies that are really
required for the current configuration of the package. If the package
provides the features *foo* and *bar* and its ``configure`` provides
switches to enable/disable them independently, we can also add
dependencies on demand. Let’s assume feature *foo* needs the compression
library *libz* and *bar* needs the XML2 library *libxml2*. These
libraries are only required at run-time if the corresponding feature is
enabled. To add these dependencies on demand, the menu file looks like:

.. code-block:: kconfig

    ## SECTION=project_specific

    config FOO
           tristate
           select ZLIB if FOO_FOO
           select LIBXML2 if FOO_BAR
           prompt "foo"
           help
             FIXME

    if FOO
    config FOO_DEBUG
           bool
           prompt "add debug noise"

    config FOO_FOO
           bool
           prompt "build foo"

    config FOO_BAR
           bool
           prompt "build bar"

    endif

.. important:: Do not add these ``select`` statements to the corresponding menu entry.
  They must belong to the main menu entry of the package to ensure that
  the calculation of the dependencies between the packages is done in a
  correct manner.

Managing External Runtime Dependencies
======================================

Some packages are building all of their components and also installing
them into the target’s sysroot. But only their *targetinstall* stage
decides which parts are copied to the root filesystem. So, compiling and
linking of our package will work, because everything required is found
in the target’s sysroot.

In our example there is a hidden dependency to the math library
``libm``. Our new package was built successfully, because the linker was
able to link our binaries against the ``libm`` from the toolchain. But
in this case the ``libm`` must also be available in the target’s root
filesystem to fulfill the run-time dependency: We have to force PTXdist to
install ``libm``. ``libm`` is part of the *glibc* package, but is not
installed by default (to keep the root filesystem small). So, it **does
not** help to select the ``GLIBC`` symbol, to get a ``libm`` at run-time.

The correct solution here is to add a ``select LIBC_M`` to our menu
file. With all the additions above it now looks like:

.. code-block:: kconfig

    ## SECTION=project_specific

    config FOO
           tristate
           select ZLIB if FOO_FOO
           select LIBXML2 if FOO_BAR
           select LIBC_M
           prompt "foo"
           help
             FIXME

    if FOO
    config FOO_DEBUG
           bool
           prompt "add debug noise"

    config FOO_FOO
           bool
           prompt "build foo"

    config FOO_BAR
           bool
           prompt "build bar"

    endif

.. note:: There are other packages around, that do not install everything by
  default. If our new package needs something special, we must take a look
  into the menu of the other package how to force the required components
  to be installed and add the corresponding ``selects`` to our own menu
  file. In this case it does not help to enable the required parts in our
  project configuration, because this has no effect on the build order!

Managing Plain Makefile Packages
================================

Many packages are still coming with a plain ``Makefile``. The user has
to adapt it to make it work in a cross compile environment as well.
PTXdist can also handle this kind of packages. We only have to specify
a special *prepare* and *compile* stage.

Such packages often have no special need for any kind of preparation. In
this we must instruct PTXdist to do nothing in the *prepare* stage:

.. code-block:: make

    FOO_CONF_TOOL := NO

To compile the package, we can use ``make``\ ’s feature to overwrite
variables used in the ``Makefile``. With this feature we can still use
the original ``Makefile`` but with our own (cross compile) settings.

Most of the time the generic compile rule can be used, only a few
settings are required. For a well defined ``Makefile`` it is sufficient to
set up the correct cross compile environment for the *compile* stage:

.. code-block:: make

    FOO_MAKE_ENV := $(CROSS_ENV)

``make`` will be called in this case with:

``$(FOO_MAKE_ENV) $(MAKE) -C $(FOO_DIR) $(FOO_MAKE_OPT)``

So, in the rule file only the two variables ``FOO_MAKE_ENV`` and
``FOO_MAKE_OPT`` must be set, to forward the required settings to the
package’s buildsystem. If the package cannot be built in parallel, we
can also add the ``FOO_MAKE_PAR := NO``. ``YES`` is the default.

Managing CMake/QMake/Meson Packages
===================================

Building packages that use ``cmake``, ``qmake`` or ``meson`` is much like
building packages with an autotools based buildsystem. We need to specify
the configuration tool:

.. code-block:: make

    FOO_CONF_TOOL := cmake

or

.. code-block:: make

    FOO_CONF_TOOL := qmake

or respectively

.. code-block:: make

    FOO_CONF_TOOL := meson

And provide the correct configuration options. The syntax is different so
PTXdist provides additional macros to simplify configurable features.
For ``cmake`` the configuration options typically look like this:

.. code-block:: make

    FOO_CONF_OPT := \
    	$(CROSS_CMAKE_USR) \
    	-DBUILD_TESTS:BOOL=OFF \
    	-DENABLE_BAR:BOOL=$(call ptx/onoff, PTXCONF_FOO_BAR)

For ``qmake`` the configuration options typically look like this:

.. code-block:: make

    FOO_CONF_OPT := \
    	$(CROSS_QMAKE_OPT) \
    	PREFIX=/usr

And for ``meson`` the configuration options typically look like this:

.. code-block:: make

    FOO_CONF_OPT := \
    	$(CROSS_MESON_USR) \
    	-Dbar=$(call ptx/truefalse,PTXCONF_FOO_BAR)

Please note that currently only host and target ``cmake``\/``meson`` packages
and only target ``qmake`` packages are supported.

Managing Python Packages
========================

As with any other package, the correct configuration tool must be selected
for Python packages:

.. code-block:: make

    FOO_CONF_TOOL := python

.. note:: For Python3 packages the value must be ``python3``.

No Makefiles are used when building Python packages so the usual ``make``
and ``make install`` for the *compile* and *install* stages cannot be used.
PTXdist will call ``python setup.py build`` and ``python setup.py install``
instead.

.. note:: *FOO* is still the name of our example package. It must be
  replaced by the real package name.

Managing Cargo Packages
=======================

As with any other package, the correct configuration tool must be selected
for Cargo packages:

.. code-block:: make

    FOO_CONF_TOOL := cargo

Additional *cargo* options can be added to the compile options like this:

.. code-block:: make

    FOO_MAKE_OPT := \
    	$(CROSS_CARGO_OPT) \
    	--features ...

Cargo wants to manage its own dependencies. PTXdist wants to manage all
downloads. To make this work, PTXdist must be aware of all cargo
dependencies. To make this possible, the package must contain a
``Cargo.lock`` file.
For new packages or whenever the ``Cargo.lock`` file changes, ``ptxdist
cargosync foo`` must be called. This creates (or updates)
``foo.cargo.make``. It is placed in the same directory as ``foo.make``.
This introduces all dependencies from ``Cargo.lock`` as additional sources
for the package.
Finally, PTXdist builds all cargo packages with ``--frozen`` to ensure that
the exact same versions are used and nothing is downloaded in the compile
stage.
