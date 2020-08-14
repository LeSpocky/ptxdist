.. _ptxdist_parameter_reference:

PTXdist parameter reference
---------------------------

PTXdist is a command line tool, which is basically called as:

.. code-block:: bash

    $  ptxdist <action [args]> [options]

Setup and Project Actions
~~~~~~~~~~~~~~~~~~~~~~~~~

``menu``
  this starts a dialog based frontend for those who do not like typing
  commands. It will gain us access to the most common parameters to
  configure and build a PTXdist project. This menu handles the
  actions *menuconfig*, *platformconfig*, *kernelconfig*, *select*,
  *platform*, *boardsetup*, *setup*, *go* and *images*.

``select <config>``
  this action will select a user land
  configuration. This step is only required in projects where no
  ``selected_ptxconfig`` file is present. The <config> argument must point
  to a valid userland configuration file. PTXdist provides this feature
  to enable the user to maintain more than one userland configuration in
  the same project. The default location for the configuration file is
  ``configs/ptxconfig``. PTXdist will use this if no other configuration is
  selected.

``platform <config>``
  this action will select a platform
  configuration. This step is only required in projects where no
  ``selected_platform`` file is present. The <config> argument must point
  to a valid platform configuration file. PTXdist provides this feature to
  enable the user to maintain more than one platform in one project.
  The default location for the configuration file is
  ``configs/*/platformconfig``. PTXdist will use that if the pattern matches
  exactly one file and no other configuration is selected.

``toolchain [<path>]``
  this action will select the toolchain to use. If no path is specified
  then PTXdist will guess which toolchain to use based on the settings in
  the platformconfig. Setting the toolchain is only required if PTXdist
  cannot find the toolchain automatically or if a different toolchain
  should be used.

``collection <config>``
  this action will select a collection configuration. This step is
  optional. The <config> argument must point to a valid collection
  configuration file.

``setup``
  PTXdist uses some global settings, independent from the
  project it is working on. These settings belong to users preferences or
  simply some network settings to permit PTXdist to download required
  packages.

``boardsetup``
  PTXdist based projects can provide information to
  setup and configure the target automatically. This action lets the user
  setup the environment specific settings like the network IP address and
  so on.

``menuconfig``
  start the menu to configure the project’s root
  filesystem. This is in respect to userland only. It’s the main menu to
  select which applications and libraries should be built into the target’s
  root filesystem.

``menuconfig platform``
  this action starts the menu to configure the currently selected
  platform. As these are architecture and target specific
  settings, it configures the toolchain, the kernel and a bootloader (but
  no userland components).
  The short form for this action is ``platformconfig``.

``menuconfig kernel``
  start the menu to configure the platform’s
  kernel. As a project can support more than one platform, this will
  configure the currently selected platform. The short form for this
  action is ``kernelconfig``.

``menuconfig barebox``
  this action starts the configure menu for
  the selected bootloader. It depends on the platform settings which
  bootloader is enabled and to be used as an argument to the
  ``menuconfig`` action parameter. As a project can support more than
  one platform, this will configure the bootloader of the currently
  selected platform.

``nconfig [<component>]``
  this action provides a slightly different user experience with the same
  functionality as ``menuconfig``. It can be used instead of ``menuconfig``
  for all the component described above.

``oldconfig [<component>]``, ``allmodconfig [<component>]``, ``allyesconfig [<component>]``, ``allnoconfig [<component>]``, ``alldefconfig [<component>]``, ``randconfig [<component>]``
  this action will run the corresponding kconfig action for the specified
  component. ``oldconfig`` will prompt for all new options.
  ``allmodconfig``, ``allyesconfig``, ``allnoconfig`` or ``alldefconfig``
  will set all options to 'm', 'y', 'n', or their default values respectively.
  ``randconfig`` will randomize the options.
  The ``KCONFIG_ALLCONFIG`` and ``KCONFIG_SEED`` environment
  variables can be used as described in the Linux kernel documentation.

``migrate``
  migrate the configuration files from a previous PTXdist version. This
  will run ``oldconfig`` and ``oldconfig platform`` to prompt for all new
  options.

Build Actions
~~~~~~~~~~~~~

``go``
  this action will build all enabled packages in the current
  project configurations (platform and userland). It will also rebuild
  reconfigured packages (if any) or build additional packages if they were
  enabled meanwhile. If enabled, this step also builds the kernel and
  bootloader images.

``get``
  this action will download the sources for all packages. This is useful to
  download everything at once. Afterwards the packages can be built without
  internet access.

``getdev``
  if using pre-built archives is enabled, this action will make sure that all
  of them exist locally, possibly by downloading them from the configured
  mirror server.

``urlcheck [<package>]``
  this action will check if the URL for the package (or all packages) still
  works. It does not download the whole file, so this is relatively fast,
  but may not be 100% correct in all cases.

``get <package>``, ``extract <package>``, ``prepare <package>``, ``compile <package>``, ``install <package>``, ``targetinstall <package>``
  these actions will build the corresponding stage for the specified package
  including all previous stages and other dependencies. Multiple packages
  can be specified.

``drop <package>.<stage>``
  this action will 'drop' the specified stage without removing any other
  files. Subsequent actions depending on this stage will rebuild it.
  This is useful during
  development to rebuild a package without deleting the sources. Use
  ``clean <package>`` for a full rebuild of the package.

``images``
  most of the time this is the last step to get the
  required files and/or images for the target. It creates filesystems or
  device images to be used in conjunction with the target’s filesystem
  media. The result can be found in the ``images/`` directory of the
  project or the platform directory.

  If necessary, ``images`` also builds all required stages first, so it can be
  used instead of ``go``.

``image <image>``
  build the specified image. The file name in ``images/`` is used to
  identify the image. This is basically the same as ``images`` but builds
  just one image.

Clean Actions
~~~~~~~~~~~~~

``clean``
  the ``clean`` action will remove all generated files:
  all build, packages and root filesystem
  directories. Only the selected configuration files are left untouched.
  This is a way to start a fresh build cycle.

``clean root``
  this action will only clean the image packages and the root filesystem
  directories. All the build directories are left untouched.
  After using this action, the next ``go`` action  will regenerate all opkg
  archives from the already built packages as well as the root filesystem
  directories.
  The ``clean root`` and ``go`` action is useful if the
  *targetinstall* stage for all packages should run again.

``clean target``
  this action will call the ``clean`` action for each target package,
  and also clean the root file system afterwards.
  This can be useful if you want to rebuild the target file system from
  scratch, without throwing away the already built host and cross packages.

``clean <package>``
  this action will only clean the dedicated
  <package>. It will remove its build directory and all installed files
  from the corresponding sysroot directory. Multiple packages can be
  specified.

``distclean``
  the ``distclean`` action will remove all files that
  are not part of the main project. It removes all generated files and
  directories like the ``clean`` action, and also the created links in any
  ``platform`` and/or ``select`` action.

Misc Actions
~~~~~~~~~~~~

``version``
  print out the PTXdist version.

``test <testname>``
  run tests

``newpackage <type>``
  create a new PTXdist package. For most package types, this will create
  <pkg>.make and <pkg>.in files in ``rules/``. Use ``newpackage help`` for a
  list of available package types.

``nfsroot``
  run a userspace NFS server and export the nfsroot (refer to section
  :ref:`nfsroot` for further details).

``gdb``
  run the cross gdb from the toolchain. The sysroot and other search paths
  are configured to ensure that gdb finds all available debug files.

``bsp-info``
  show some basic information about the BSP. The currently used configs,
  all layers, the images that are build, etc.

``package-info <pkg>``
  show some basic information about the package. This includes the version,
  URL and various paths and directories. The paths for menu and rule file
  are shown as well, so this can be used to verify that the correct version
  of these files are used.

.. _command_print:

``print <var>``
  print the contents of a variable. It will first look for a shell variable
  with the given name. If none exists, it will run make on all selected package
  rules, determine if a variable with the given name is known to make, and if
  so, print it.
  For make variables, <var> can contain '%'. In this case, all variables
  that match the pattern are printed.
  If the <var> is undefined, then an error will be generated unless '-k' is
  used. In that case an empty value is returned.

``printnext <var>``
  assume that the contents of <var> is another variable and print the
  contents of this variable. Shell variables are currently not checked here.
  All other rules for ``print`` apply.

``licensecheck [<package>]``
  For the specified package (or all selected packages), check the MD5 sums
  of license files.

``list-packages``
  print a list of all selected packages. This list does not include the
  host and cross tools.

``local-src <pkg> [<directory>]``
  overwrite a package source with a locally provided directory containing
  the source code. Not specifying the directory will undo the change.
  Relative paths are converted to absolute paths relative to the workspace.

``bash``
  enter a PTXdist environment bash shell.

``bash <cmd> [args...]``
  execute ``<cmd>`` in PTXdist environment.

``make <target>``
  build specified make target in PTXdist.

``export_src <target-dir>``
  export all source archives needed for this project to ``<target-dir>``.

``docs-html``
  build HTML documentation for a BSP. The output is written to
  Documentation/html/index.html

Overwrite defaults
~~~~~~~~~~~~~~~~~~

These options can be used to overwrite default settings. They can be useful
when working with multiple configurations or platforms in a single project.

``--ptxconfig=<config>``
  use the specified ptxconfig file instead of the selected default
  configuration file.

``--platformconfig=<config>``
  use specified platformconfig file instead of the selected default
  configuration file.

``--collectionconfig=<config>``
  use specified collectionconfig file instead of the selected configuration
  file.

``--toolchain=<toolchain>``
  use specified toolchain instead of the selected or default toolchain.

``--force-download``
  allow downloading, even if disabled by ``setup``

Options
~~~~~~~

``--force``, ``-f``
  use this option to overwrite various sanity checks. Only use this option
  if you really know what you are doing!

``--debug``, ``-d``
  print out additional info (like make decisions)

``--quiet``, ``-q``
  suppress output, show only stderr

``--verbose``, ``-v``
  be more verbose, print command before execute them

``--output-sync``, ``--no-output-sync``
  enable or disable output synchronization. By default output
  synchronization is only enabled for quiet builds. Output synchronization
  is implemented by the ``make`` ``--output-sync`` option. For building
  packages in parallel, ``--output-sync=recurse`` is used. For individual
  ``make`` commands in the build stages ``--output-sync=target`` is used.
  This means that the output for each individual make target and each
  build stage is grouped together.

  Note: If output synchronization is enabled, then the output for each build
  stage is collected by make and won't be visible until the build stage is
  completed. As a result, there will be long periods of time with no
  visible progress.

``--progress``
  show some progress information in the form of completed/total build
  stages. This is only shown if ``--quiet`` is enabled as well. Note that this
  adds some extra overhead at the beginning, so it will take some time
  until the first build stage starts.

``--j-intern=<n>``, ``-ji<n>``
  set number of parallel jobs within packages. PTXdist will use this
  number for example when calling ``make`` during the compile stage.
  The default is 2x the number of CPUs.

``--j-extern=<n>``, ``-je<n>``
  set number of packages to be built in parallel. The default is 1.
  Use ``-j`` instead of this. It has the same goal and performs better.

``-j[<n>]``
  set the global number of parallel jobs. This is basically a more
  intelligent combination of ``-je`` and ``-ji``. A single package rarely
  uses all the available CPUs. Usually only the compile stage can use more than
  one CPU and even then there are often idle CPUs. With the global job
  pool, tasks from multiple packages can be executed in parallel without
  overloading the system.

  Note: Because of the parallel execution, the output is chaotic and not
  very useful. Use this in combination with ``-q`` and only to speed up
  building for projects that are known to build without errors.

``--load-average=<n>``, ``-l<n>``
  try to limit load to <n>. This is used for the equivalent ``make``
  option.

``--nice=<n>``, ``-n<n>``
  run with reduced scheduling priority (i.e. nice). The default is 10.

``--dirty``
  avoid rebuilding packages. By default, if a package is rebuilt, then all
  packages that depend on it are also rebuilt. This happens because
  PTXdist cannot know if rebuilding is functionally necessary for the depending
  packages. By specifying ``--dirty``, depending packages will not be rebuilt
  if their dependencies were rebuilt. Also, changes to config options,
  rule and menu file or changed patches will not trigger a rebuild either.

  To trigger a rebuild, the relevant stage of a package must be dropped.

``--keep-going``, ``-k``
  keep going. Continue to build as much as possible after an error.

``--git``
  use git to apply patches

``--auto-version``
  automatically switch to the correct PTXdist version. This will look for
  the correct PTXdist version in the ptxconfig file and execute it if it
  does not match the current version.

``--virtualenv=<dir>``
  include a Python Virtual Environment. The given path must contain a
  ``bin/activate`` shell script.
