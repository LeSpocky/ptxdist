.. _adding_new_packages:

Adding New Packages
-------------------

PTXdist provides a huge amount of applications sufficient for the most
embedded use cases. But there is still need for some fancy new packages.
This section describes the steps and the background on how to integrate
new packages into the project.

At first a summary about possible application types which PTXdist can
handle:

-  **host type**: This kind of package is built to run on the build
   host. Most of the time such a package is needed if another
   target-relevant package needs to generate some data. For example the
   *glib* package depends on its own to create some data. But if it is
   compiled for the target, it can’t do so. That’s why a host glib
   package is required to provide these utilities runnable on the build
   host. It sounds strange to build a host package, even if on the build
   host such utilities are already installed. But this way ensures that
   there are no dependencies regarding the build host system.

-  **target type**: This kind of package is built for the target.

-  **cross type**: This kind of package is built for the build host, but
   creates architecture specific data for the target.

-  **src-autoconf-prog**: This kind of package is built for the target.
   It is intended for development, as it does not handle a released
   archive but a plain source project instead. Creating such a package
   will also create a small autotools based source template project on
   demand to give the developer an easy point to start. This template is
   prepared to build a single executable program. For further details refer
   section :ref:`adding_src_autoconf_exec`.

-  **src-autoconf-lib**: This kind of package is built for the target.
   It is intended for development, as it does not handle a released
   archive but a plain source project instead. Creating such a package
   will also create a small autotools/libtool based source template
   project on demand to give the developer an easy point to start. This
   template is prepared to build a single shared library. For further
   details refer section :ref:`adding_src_autoconf_lib`.

-  **src-autoconf-proglib**: This kind of package is built for the
   target. It is intended for development, as it does not handle a
   released archive but a plain source project instead. Creating such a
   package will also create a small autotools/libtool based template
   project on demand to give the developer an easy point to start. This
   template is prepared to build a single shared library and a single
   executable program. The program will be linked against the shared
   library. For further details refer section :ref:`adding_src_autoconf_exec_lib`.

-  **file**: This kind of package is intended to add a few simple files
   into the build process. We assume these files do not need any
   processing, they are ready to use and must only be present in the
   build process or at run-time (HTML files for example). Refer to the
   section :ref:`adding_files` for further details on how to use
   it.

-  **src-make-prog**: This kind of package is built for the target. It’s
   intended for development, as it does not handle a released archive
   but a plain source project instead. Creating such a package will also
   create a simple makefile-based template project the developer can use
   as a starting point for development.

-  **src-cmake-prog**: This kind of package is built for the target.
   It’s intended for developments based on the *cmake* buildsystem.
   Various projects are using *cmake* instead of *make* and can be built
   with this package type. PTXdist will prepare it to compile sources in
   accordance to the target libraries and their settings. Creating such
   a package will also create a simple template project to be used as a
   starting point for development.

-  **src-qmake-prog**: This kind of package is built for the target.
   It’s intended for developments based on the *qmake* buildsystem. If
   the developer is going to develop a QT based application, this rule
   is prepared to compile sources in accordance to the target libraries
   and their settings. Creating such a package will also create a simple
   template project to be used as a starting point for development.

-  **src-meson-prog**: This kind of package is built for the target.
   It’s intended for developments based on the *meson* buildsystem.
   Various projects are using *meson* today and can be built
   with this package type. PTXdist will prepare it to compile sources in
   accordance to the target libraries and their settings. Creating such
   a package will also create a simple template project to be used as a
   starting point for development.

-  **font**: This package is a helper to add X font files to the root
   filesystem. This package does not create an additional IPKG, instead
   it adds the font to the existing font IPKG. This includes the
   generation of the directory index files, required by the Xorg
   framework to recognize the font file.

-  **src-linux-driver**: This kind of package builds an out of tree
   kernel driver. It also creates a driver template to give the
   developer an easy point to start.

-  **kernel**: PTXdist comes with the ability to handle one kernel in its
   platform. This type of package enables us to handle more than one kernel in
   the project.

-  **barebox**: PTXdist comes with the ability to handle one bootloader in its
   platform. This type of package enables us to handle more than one bootloader
   in the project.

-  **image-tgz**: This kind of package creates a tar ball from a list of
   packages. It is often uses as an input for other image packages.

-  **image-genimage**: This kind of package can handle all kind of image
   generation for almost every target independent of its complexity.

-  **blspec-entry**: PTXdist comes with the ability to handle one bootspec in its
   platform. This type of package enables us to handle more than one bootspec
   in the project.

.. _foo_example:

Rule File Creation
~~~~~~~~~~~~~~~~~~

To create such a new package, we create a project local ``rules/``
directory first. Then we run

.. code-block:: text

    $ ptxdist newpackage <package type>

If we omit the <``package type``\ >, PTXdist will list all available
package types.

In our first example, we want to add a new target type archive package.
When running the

.. code-block:: text

    $ ptxdist newpackage target

command, PTXdist asks a few questions about this package. This
information is the basic data PTXdist must know about the package.

.. code-block:: text

    ptxdist: creating a new 'target' package:

    ptxdist: enter package name.......: foo
    ptxdist: enter version number.....: 1.1.0
    ptxdist: enter URL of basedir.....: http://www.foo.com/download/src
    ptxdist: enter suffix.............: tar.gz
    ptxdist: enter package author.....: My Name <me@my-org.com>
    ptxdist: enter package section....: project_specific

What we have to answer:

-  **package name**: As this kind of package handles a source archive,
   the correct answer here is the basename of the archive’s file name.
   If its full name is ``foo-1.1.0.tar.gz``, then ``foo`` is the
   basename to enter here.

-  **version number**: Most source archives are using a release or
   version number in their file name. If its full name is
   ``foo-1.1.0.tar.gz``, then ``1.1.0`` is the version number to enter
   here.

-  **URL of basedir**: This URL tells PTXdist where to download the
   source archive from the web (if not already done). If the full URL to
   download the archive is
   ``http://www.foo.com/download/src/foo-1.1.0.tar.gz``, the basedir
   part ``http://www.foo.com/download/src`` is to be entered here.

-  **suffix**: Archives are using various formats for distribution.
   PTXdist uses the *suffix* entry to select the matching extraction
   tool. If the archive’s full name is ``foo-1.1.0.tar.gz``, then
   ``tar.gz`` is the suffix to enter here.

-  **package author**: If we intend to contribute this new package to
   PTXdist mainline, we should add our name here. This name will be used
   in the copyright note of the rule file and will also be added to the
   generated ipkg. When you run ``ptxdist setup`` prior to this call,
   you can enter your name and your email address, so PTXdist will use
   it as the default (very handy if you intend to add many new
   packages).

-  **package section**: We can enter here the menu section name where
   our new package menu entry should be listed. In the first step we can
   leave the default name unchanged. It’s a string in the menu file
   only, so changing it later on is still possible.

Make it Work
~~~~~~~~~~~~

Generating the rule file is only one of the required steps to get a new
package. The next steps to make it work are to check if all stages are
working as expected and to select the required parts to get them
installed in the target root filesystem. Also we must find a reasonable
location where to add our new menu entry to configure the package.

The generated skeleton starts to add the new menu entry in the main
configure menu (if we left the section name unchanged). Running
``ptxdist menuconfig`` will show it on top of all other menus entries.

.. important:: 
  To be able to implement and test all the other required steps for adding
  a new package, we first must enable the package for building. (Fine
  tuning the menu can happen later on.)


The rule file skeleton still lacks some important information. Let’s
take a look into some of the top lines of the generated rule file
``./rules/foo.make``:

.. code-block:: make

    FOO_VERSION	:= 1.1.0
    FOO_MD5	:=
    FOO		:= foo-$(FOO_VERSION)
    FOO_SUFFIX	:= tar.gz
    FOO_URL	:= http://www.foo.com/download/src/$(FOO).$(FOO_SUFFIX)
    FOO_SOURCE	:= $(SRCDIR)/$(FOO).$(FOO_SUFFIX)
    FOO_DIR	:= $(BUILDDIR)/$(FOO)
    FOO_LICENSE	:= unknown

We can find these lines with different content in most or all of the
other rule files PTXdist comes with. Up to the underline character is
always the package name and after the underline character is always
PTXdist specific. What does it mean:

-  ``*_VERSION`` brings in the version number of the release and is used
   for the download and IPKG/OPKG package generation.

-  ``*_MD5`` to be sure the correct package has been downloaded, PTXdist
   checks the given MD5 sum against the archive content. If both sums do
   not match, PTXdist rejects the archive and fails the currently
   running build.

-  ``*_SUFFIX`` defines the archive type, to make PTXdist choosing the
   correct extracting tool.

-  ``*_URL`` defines the full qualified URL into the web for download. If
   alternative download locations are known, they can be listed in this
   variable, delimiter character is the space.

-  ``*_SOURCE`` tells PTXdist where to store the downloaded package.

-  ``*_DIR`` points to the directory this package will be built later on
   by PTXdist.

-  ``*_LICENSE`` enables the user to get a list of licenses she/he is
   using in her/his project (licenses of the enabled packages).

After enabling the menu entry, we can start to check the *get* and
*extract* stages, calling them manually one after another.

.. note:: The shown commands below expect that PTXdist downloads the
  archives to a global directory named ``global_src``. This is not the
  default setting, but we recommend to use a global directory to share all
  archives between PTXdist based projects. Advantage is every download
  happens only once. Refer to the ``setup`` command PTXdist provides.

.. code-block:: text

    $ ptxdist get foo

    ---------------------------
    target: foo-1.1.0.tar.gz
    ---------------------------

    --2009-12-21 10:54:45--  http://www.foo.com/download/src/foo-1.1.0.tar.gz
    Length: 291190 (284K) [application/x-gzip]
    Saving to: `/global_src/foo-1.1.0.tar.gz.XXXXOGncZA'

    100%[======================================>] 291,190      170K/s   in 1.7s

    2009-12-21 10:54:48 (170 KB/s) - `/global_src/foo-1.1.0.tar.gz' saved [291190/291190]

This command should start to download the source archive. If it fails,
we should check our network connection, proxy setup or if the given URL
in use is correct.

.. note:: Sometimes we do not know the content of all the other variables in
  the rule file. To get an idea what content a variable has, we can ask
  PTXdist about it:

.. code-block:: text

    $ ptxdist print FOO_URL
    http://www.foo.com/download/src/foo-1.1.0.tar.gz

The next step would be to extract the archive. But as PTXdist checks the
MD5 sum in this case, this step will fail, because the ``FOO_MD5``
variable is still empty. Let’s fill it:

.. code-block:: text

    $ md5sum /global_src/foo-1.1.0.tar.gz
    9a09840ab775a139ebb00f57a587b447

This string must be assigned to the FOO_MD5 in our new ``foo.make``
rule file:

.. code-block:: text

    FOO_MD5		:= 9a09840ab775a139ebb00f57a587b447

We are now prepared for the next step:

.. code-block:: text

    $ ptxdist extract foo

    -----------------------
    target: foo.extract
    -----------------------

    extract: archive=/global_src/foo-1.1.0.tar.gz
    extract: dest=/home/jbe/my_new_prj/build-target
    PATCHIN: packet=foo-1.1.0
    PATCHIN: dir=/home/jbe/my_new_prj/build-target/foo-1.1.0
    PATCHIN: no patches for foo-1.1.0 available
    Fixing up /home/jbe/my_new_prj/build-target/foo-1.1.0/configure
    finished target foo.extract

In this example we expect an autotoolized source package. E.g. to
prepare the build, the archive comes with a ``configure`` script. This
is the default case for PTXdist. So, there is no need to modify the rule
file and we can simply run:

.. code-block:: text

    $ ptxdist prepare foo

    -----------------------
    target: foo.prepare
    -----------------------

    [...]

    checking build system type... i686-host-linux-gnu
    checking host system type... |ptxdistCompilerName|
    checking whether to enable maintainer-specific portions of Makefiles... no
    checking for a BSD-compatible install... /usr/bin/install -c
    checking whether build environment is sane... yes
    checking for a thread-safe mkdir -p... /bin/mkdir -p
    checking for gawk... gawk
    checking whether make sets $(MAKE)... yes
    checking for |ptxdistCompilerName|-strip... |ptxdistCompilerName|-strip
    checking for |ptxdistCompilerName|-gcc... |ptxdistCompilerName|-gcc
    checking for C compiler default output file name... a.out

    [...]

    configure: creating ./config.status
    config.status: creating Makefile
    config.status: creating ppa_protocol/Makefile
    config.status: creating config.h
    config.status: executing depfiles commands
    finished target foo.prepare

At this stage things can fail:

-  A wrong or no MD5 sum was given

-  The ``configure`` script is not cross compile aware

-  The package depends on external components (libraries for example)

If the ``configure`` script is not cross compile aware, we are out of
luck. We must patch the source archive in this case to make it work.
Refer to the section :ref:`configure_rebuild` on how to use
PTXdist’s features to simplify this task.
If the package depends on external components, these components might
be already part of PTXdist. In this case we just have to add this
dependency into the menu file and we are done. But if PTXdist cannot
fulfill this dependency, we also must add it as a separate package
first.

If the *prepare* stage has finished successfully, the next step is to
compile the package.

.. code-block:: text

    $ ptxdist compile foo

    -----------------------
    target: foo.compile
    -----------------------

    make[1]: Entering directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make  all-recursive
    make[2]: Entering directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make[3]: Entering directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'

    [...]

    make[3]: Leaving directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make[2]: Leaving directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make[1]: Leaving directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    finished target foo.compile

At this stage things can fail:

-  The build system is not cross compile aware (it tries to execute just
   created target binaries for example)

-  The package depends on external components (libraries for example)
   not detected by ``configure``

-  Sources are ignoring the endianness of some architectures or using
   header files from the build host system (from ``/usr/include`` for
   example)

-  The linker uses libraries from the build host system (from
   ``/usr/lib`` for example) by accident

In all of these cases we must patch the sources to make them work. Refer
to section :ref:`patching_packages` on how to use PTXdist’s
features to simplify this task.

In this example we expect the best case: everything went fine, even for
cross compiling. So, we can continue with the next stage: *install*

.. code-block:: text

    $ ptxdist install foo

    -----------------------
    target: foo.install
    -----------------------

    make[1]: Entering directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make[2]: Entering directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make[3]: Entering directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    test -z "/usr/bin" || /bin/mkdir -p "/home/jbe/my_new_prj/build-target/foo-1.1.0/usr/bin"
      /usr/bin/install -c 'foo' '/home/jbe/my_new_prj/build-target/foo-1.1.0/usr/bin/foo'
    make[3]: Leaving directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make[2]: Leaving directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    make[1]: Leaving directory `/home/jbe/my_new_prj/build-target/foo-1.1.0'
    finished target foo.install

    ----------------------------
    target: foo.install.post
    ----------------------------

    finished target foo.install.post

This *install* stage does not install anything to the target root
filesystem. It is mostly intended to install libraries and header files
other programs should link against later on.

The last stage – *targetinstall* – is the one that defines the package’s
components to be forwarded to the target’s root filesystem. Due to the
absence of a generic way, this is the task of the developer. So, at this
point of time we must run our favourite editor again and modify our new
rule file ``./rules/foo.make``.

The skeleton for the *targetinstall* stage looks like this:

.. code-block:: make

    # ----------------------------------------------------------------------------
    # Target-Install
    # ----------------------------------------------------------------------------

    $(STATEDIR)/foo.targetinstall:
    	@$(call targetinfo)

    	@$(call install_init,  foo)
    	@$(call install_fixup, foo,PACKAGE,foo)
    	@$(call install_fixup, foo,PRIORITY,optional)
    	@$(call install_fixup, foo,VERSION,$(FOO_VERSION))
    	@$(call install_fixup, foo,SECTION,base)
    	@$(call install_fixup, foo,AUTHOR,"My Name <me@my-org.com>")
    	@$(call install_fixup, foo,DEPENDS,)
    	@$(call install_fixup, foo,DESCRIPTION,missing)

    	@$(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/foobar, /dev/null)

    	@$(call install_finish, foo)
    	@$(call touch)

The “header” of this stage defines some information IPKG needs. The
important part that we must modify is the call to the ``install_copy``
macro (refer to section :ref:`reference_macros` for more details
about this kind of macros). This call instructs PTXdist to include the
given file (with UID, GID and permissions) into the IPKG, which means to
install this file to the target’s root filesystem.

From the previous *install* stage we know this package installs an
executable called ``foo`` to location ``/usr/bin``. We can do the same
for our target by changing the *install\_copy* line to:

.. code-block:: none

    @$(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/foo, /usr/bin/foo)

To check it, we just run:

.. code-block:: text

    $ ptxdist targetinstall foo

    -----------------------------
    target: foo.targetinstall
    -----------------------------

    install_init:   preparing for image creation...
    install_init:   @ARCH@ -> i386 ... done
    install_init:   preinst not available
    install_init:   postinst not available
    install_init:   prerm not available
    install_init:   postrm not available
    install_fixup:  @PACKAGE@ -> foo ... done.
    install_fixup:  @PRIORITY@ -> optional ... done.
    install_fixup:  @VERSION@ -> 1.1.0 ... done.
    install_fixup:  @SECTION@ -> base ... done.
    install_fixup:  @AUTHOR@ -> "My Name <me\@my-org.com>" ... done.
    install_fixup:  @DESCRIPTION@ -> missing ... done.
    install_copy:
      src=/home/jbe/my_new_prj/build-target/foo-1.1.0/foo
      dst=/usr/bin/foo
      owner=0
      group=0
      permissions=0755
    xpkg_finish:    collecting license (unknown) ... done.
    xpkg_finish:    creating ipkg package ... done.
    finished target foo.targetinstall

    ----------------------------------
    target: foo.targetinstall.post
    ----------------------------------

    finished target foo.targetinstall.post

After this command, the target’s root filesystem contains a file called
``/usr/bin/foo`` owned by root, its group is also root and everyone has
execution permissions, but only the user root has write permissions.

One last task of this port is still open: A reasonable location for
the new menu entry in PTXdist’s menu hierarchy. PTXdist arranges its
menus on the meaning of each package. Is it a network related tool? Or
a scripting language? Or a graphical application?
Each of these global meanings has its own submenu, where we can add
our new entry to. We just have to edit the head of our new menu file
``./rules/foo.in`` to add it to a specific global menu. If our new
package is a network related tool, the head of the menu file should
look like:

.. code-block:: kconfig

    ## SECTION=networking

We can grep through the other menu files from the PTXdist main
installation ``rules/`` directory to get an idea what section names are
available:

.. code-block:: text

    rules/ $ find . -name \*.in | xargs grep "## SECTION"
    ./acpid.in:## SECTION=shell_and_console
    ./alsa-lib.in:## SECTION=system_libraries
    ./alsa-utils.in:## SECTION=multimedia_sound
    ./apache2.in:## SECTION=networking
    ./apache2_mod_python.in:## SECTION=networking
    [...]
    ./xkeyboard-config.in:## SECTION=multimedia_xorg_data
    ./xorg-app-xev.in:## SECTION=multimedia_xorg_app
    ./xorg-app-xrandr.in:## SECTION=multimedia_xorg_app
    ./host-eggdbus.in:## SECTION=hosttools_noprompt
    ./libssh2.in:## SECTION=networking

Porting a new package to PTXdist is (almost) finished now.

To check it right away, we simply run these two commands:

.. code-block:: text

    $ ptxdist clean foo
    rm -rf /home/jbe/my_new_prj/state/foo.*
    rm -rf /home/jbe/my_new_prj/packages/foo_*
    rm -rf /home/jbe/my_new_prj/build-target/foo-1.1.0
    $ ptxdist targetinstall foo

    [...]

.. important:: Discover somehow hidden dependencies with one more last check!

Up to this point all the development of the new package was done in an already
built BSP. Doing so sometimes somehow hidden dependencies cannot be seen:
everything seems fine, the new package builds always successfully and the
results are working on the target.

So to check for this kind of dependencies there is still one more final check
to do (even if its boring and takes time):

.. code-block:: text

    $ ptxdist clean
    [...]
    $ ptxdist targetinstall foo
    [...]

This will re-start with a **clean** BSP and builds exactly the new package and
its (known) dependencies. If this builds successfully as well we are really done
with the new package.

Some Notes about Licenses
~~~~~~~~~~~~~~~~~~~~~~~~~

The already mentioned rule variable ``*_LICENSE`` (e.g. ``FOO_LICENSE`` in our
example) is very important and must be filled by the developer of the package.
Many licenses bring in obligations using the corresponding package (*attribution*
for example). To make life easier for everybody the license for a package must
be provided. *SPDX* license identifiers unify the license names and are used
in PTXdist to identify license types and obligations.

If a package comes with more than one license, all of their SPDX identifiers
must be listed and connected with the keyword ``AND``. If your package comes
with GPL-2.0 and LGPL-2.1 licenses, the definition should look like this:

.. code-block:: make

   FOO_LICENSE := GPL-2.0 AND LGPL-2.1

One specific obligation cannot be detected examining the SPDX license identifiers
by PTXdist: *the license choice*. In this case all licenses of choice must be
listed and connected by the keyword ``OR``.

If, for example, your obligation is to select one of the licenses *GPL-2.0* **or**
*GPL-3.0*, the ``*_LICENSE`` variable should look like this:

.. code-block:: make

   FOO_LICENSE := GPL-2.0 OR GPL-3.0

SPDX License Identifiers
^^^^^^^^^^^^^^^^^^^^^^^^

A list of SPDX license identifiers can be found here:

   https://spdx.org/licenses/

Help to Detect the Correct License
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

License identification isn't trivial. A help in doing so can be the following
repository and its content. It contains a list of known licenses based on their
SPDX identifier. The content is without formatting to simplify text search.

   https://github.com/spdx/license-list-data/tree/master/text

Advanced Rule Files
~~~~~~~~~~~~~~~~~~~

The previous example on how to create a rule file sometimes works as
shown above. But most of the time source archives are not that simple.
In this section we want to give the user a more detailed selection how
the package will be built.

Adding Static Configure Parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Some packages are building all of their components and also installing
them into the target’s sysroot. But only their *targetinstall* stage
decides which parts are copied to the root filesystem. So, compiling and
linking of our package will work, because everything required is found
in the target’s sysroot.

In our example there is a hidden dependency to the math library
``libm``. Our new package was built successfully, because the linker was
able to link our binaries against the ``libm`` from the toolchain. But
in this case the ``libm`` must also be available in the target’s root
filesystem to fulfil the run-time dependency: We have to force PTXdist to
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^

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


.. _patching_packages:

Patching Packages
~~~~~~~~~~~~~~~~~

There can be various reasons why a package must be patched:

-  Package is broken for cross compile environments

-  Package is broken within a specific feature

-  Package is vulnerable and needs some fixes

-  or anything else (this case is the most common one)

Ideally, those problems should be addressed in the original project,
so any patches you add to your BSP or to PTXdist should also be submitted upstream.
The upstream project can often provide better feedback, they can integrate your
patch into a new release, and also maintain your changes as part of the project.
This way we make sure that all advantages of the open source idea work for us;
and your patch can be removed again later when a new release of the project is
integrated into your BSP or into PTXdist.

PTXdist handles patching automatically.
After extracting the archive of a package, PTXdist checks for the existence of
a patch directory named like its ``<PKG>_PATCHES`` variable, or, if this variable
is not set, like its ``<PKG>`` variable.
The patch directory is then searched in all locations listed by the
``PTXDIST_PATH_PATCHES`` variable, and the first one found is used.
Take an exemplary package ``foo`` with version ``1.1.0``:
The variable ``FOO`` will have the value ``foo-1.1.0``, so PTXdist will look for
a patch directory named ``foo-1.1.0`` in the following locations:

#. the current layer:

   a. project (``./patches/foo-1.1.0``)
   b. platform (``./configs/|ptxdistPlatformConfigDir|/patches/foo-1.1.0``)

#. any :ref:`base layers <layers-in-ptxdist>`,
   applying the same search order as above for each layer recursively

#. ptxdist (``<ptxdist/installation/path>/patches/foo-1.1.0``)

The patches from the first location found are used. Note: Due to this
search order, a PTXdist project can replace global patches from the
PTXdist installation. This can be useful if a project sticks to a
specific PTXdist revision but fixes from a more recent revision of
PTXdist should be used.

PTXdist uses the utilities *git*, *patch* or *quilt* to work with
patches or patch series. We recommend *git*, as it can manage patch
series in a very easy way.

Creating a Patch Series for a Package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To create a patch series for the first time, we can run the following
steps. We are still using our *foo-1.1.0* example package here:

Using Quilt
"""""""""""

We create a special directory for the patch series in the local project
directory:

.. code-block:: text

    $ mkdir -p patches/foo-1.1.0

PTXdist expects a ``series`` file in the patch directory and at least
one patch. Otherwise it fails. Due to the fact that we do not have any
patch content yet, we’ll start with a dummy entry in the ``series`` file
and an empty ``patch`` file.

.. code-block:: text

    $ touch patches/foo-1.1.0/dummy
    $ echo dummy > patches/foo-1.1.0/series

Next is to extract the package (if already done, we must remove it
first):

.. code-block:: text

    $ ptxdist extract foo

This will extract the archive and create a symbolic link in the build
directory pointing to our local patch directory. Working this way will
ensure that we do not lose our created patches if we enter
``ptxdist clean foo`` by accident. In our case the patches are still
present in ``patches/foo-1.1.0`` and can be used the next time we
extract the package again.

All we have to do now is to do the modification we need to make the
package work. We change into the build directory and use quilt_ to
create new patches, add files to respective patches, modify these files
and refresh the patches to save our changes.
See the *quilt* documentation (``man 1 quilt``) for more information.

.. note:: For patches that are intended for PTXdist upstream use the git
  workflow described below to get proper patch headers.

.. _quilt: http://savannah.nongnu.org/projects/quilt

Using Git
"""""""""

Create the patch directory like above for *quilt*,
but only add an empty series file:

.. code-block:: text

    $ mkdir -p patches/foo-1.1.0
    $ touch patches/foo-1.1.0/series

Then extract the package with an additional command line switch:

.. code-block:: text

    $ ptxdist --git extract foo

The empty series file makes PTXdist create a Git repository in the
respective package build directory,
and import the package source as the first commit.

.. note:: Optionally, you can enable the setting *Developer Options →
  use git to apply patches* in `ptxdist setup` to get this behaviour
  as a default for every package.
  However, note that this setting is meant for development only, and can lead
  to failures – some packages try to determine if they are being compiled from
  a Git source tree, and behave differently in that case.

Then you can change into the package build directory
(``platform-<name>/build-target/foo-1.1.0``),
patch the required source files,
and make Git commits on the way.
The Git history should now look something like this:

.. code-block:: text

    $ git log --oneline --decorate
    * df343e821851 (HEAD -> master) Makefile: don't build the tests
    * 65a360c2bd60 strfry.c: frobnicate the excusator
    * fdc315f6844c (tag: foobar-1.1.0, tag: base) initial commit

Finally, call ``git ptx-patches`` to transform those Git commits into the patch
series in the ``patches/foo-1.1.0`` folder.
This way they don't get lost when cleaning the package.

.. note:: PTXdist will only create a Git repository for packages with
  patches.  To use Git to generate the first patch, create an empty series
  file ``patches/foobar-1.1.0/series`` before extracting the packages. This
  will tell PTXdist to use Git anyways and ``git ptx-patches`` will put the
  patches there.

Both approaches (Git and quilt) are not suitable for modifying files
that are autogenerated in autotools-based buildsystems.
Refer to the section :ref:`configure_rebuild` on how PTXdist can
handle this special task.

Adding More Patches to a Package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If we want to add more patches to an already patched package, we can use
nearly the same way as creating patches for the first time. But if the
patch series comes from the PTXdist main installation, we do not have
write permissions to these directories (do NEVER work on the main
installation directories, NEVER, NEVER, NEVER). Due to the search order
in which PTXdist searches for patches for a specific package, we can
copy the global patch series to our local project directory. Now we have
the permissions to add more patches or modify the existing ones. Also
*quilt* and *git* are our friends here to manage the patch series.

If we think that our new patches are valuable also for others, or they
fix an error, it could be a good idea to send these patches to PTXdist
mainline, and to the upstream project too.


.. _configure_rebuild:

Modifying Autotoolized Packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Autotoolized packages are very picky when automatically generated files
get patched. The patch order is very important in this case and
sometimes it even fails and nobody knows why.

To improve a package’s autotools-based build system, PTXdist comes with
its own project local autotools to regenerate the autotools template
files, instead of patching them. With this feature, only the template
files must be patched, the required ``configure`` script and the
``Makefile.in`` files are regenerated in the final stages of the
*prepare* step.

This feature works like the regular patching mechanism. The only
difference is the additional ``autogen.sh`` file in the patch directory.
If it exists and has execution permissions, it will be called after the
package was patched (while the *extract* stage is running).

Its content depends on developer needs; for the most simple case the
content can be:

.. code-block:: bash

    #!/bin/bash

    aclocal $ACLOCAL_FLAGS

    libtoolize \
            --force \
            --copy

    autoreconf \
            --force \
            --install \
            --warnings=cross \
            --warnings=syntax \
            --warnings=obsolete \
            --warnings=unsupported

.. note:: In this way not yet autotoolized package can be autotoolized. We
  just have to add the common autotool template files (``configure.ac``
  and ``Makefile.am`` for example) via a patch series to the package
  source and the ``autogen.sh`` to the patch directory.
