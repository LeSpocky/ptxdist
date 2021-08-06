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
   See :ref:`licensing_in_packages` below for detailed information.

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
