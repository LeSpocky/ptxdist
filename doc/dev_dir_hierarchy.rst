.. _directory_hierarchy:

PTXdist’s Directory Hierarchy
-----------------------------

.. note:: Referenced directories are meant relative to the PTXdist main
  installation location (if not otherwise stated). If not configured
  differently, this main path is ``/usr/local/lib/ptxdist-|ptxdistVendorVersion|``

Rule Files
~~~~~~~~~~

When building a single package, PTXdist needs the information on how to
handle the package, i.e. on how to get it from the source up to what the
target needs at run-time. This information is provided by a rule file per
package.

PTXdist collects all rule files in its ``rules/`` directory. Whenever
PTXdist builds something, all these rule files are scanned at once.
These rule files are global rule files, valid for all projects. PTXdist
uses a mechanism to be able to add or replace specific rule files on a
per project base. If a ``rules/`` directory exists in the current
project, its content is scanned too. These project local rule files are
used in addition to the global rule files or – if they are using the
same name as a global rule file – **replacing** the global rule file.

The replacing mechanism can be used to extend or adapt packages for
specific project requirements. Or it can be used for bug fixing by
backporting rule files from more recent PTXdist revisions to projects
that are stuck to an older PTXdist revision for maintenance only.

Patch Series
~~~~~~~~~~~~

There are many packages in the wild that are not cross build aware. They
fail compiling some files, use wrong include paths or try to link
against host libraries. To be successful in the embedded world, these
types of failures must be fixed. If required, PTXdist provides such
fixes per package. They are organized in *patch series* and can be found
in a ``patches/`` directory within a subdirectory using the same name
as the package itself.

PTXdist uses the utility ``patch`` or ``quilt`` (or ``git`` on demand) to apply
an existing patch series after extracting the archive. So, every patch series
contains a set of patches and one ``series`` file to define the order in
which the patches must be applied.

.. note:: Patches can be compressed.

Patches are looked for at several locations:

1.  the ``patches/`` folder in your BSP (``${PTXDIST_WORKSPACE}/patches``)

2.  the folder ``patches/`` folder relative to your selected platformconfig
    file (``${PTXDIST_PLATFORMCONFIGDIR}/patches``). If your platformconfig
    file is at ``configs/|ptxdistPlatformConfigDir|/platformconfig``, this
    patch folder will be ``configs/|ptxdistPlatformConfigDir|/patches/``.

3.  the ``patches/`` folder in PTXdist's main installation directory
    (``${PTXDIST_TOPDIR}/patches``)

The list is tried from first to last.
If no patches were found in one of the locations, the next location is tried.
When all locations have been tried unsuccessfully, the package is not patched.

This search order can be used to use specific patch series for specific
cases.

-  platform specific

-  project specific

-  common case

-  bug fixing

The *bug fixing* case is used in accordance to a replacement of a rule
file. If this was done due to a backport, and the more recent PTXdist
revision does not only exchange the rule file but also the patch series,
this mechanism ensures that both relevant parts can be updated in the
project.

Runtime Configuration
~~~~~~~~~~~~~~~~~~~~~

Many packages are using run-time configuration files along with their
executables and libraries. PTXdist provides default configuration files
for the most common cases. These files can be found in the
``projectroot/etc`` directory and they are using the same names as the ones
at run-time (and their install directory on the target side will also be
``/etc``).

But some of these default configuration files are empty, due to the
absence of a common case. The project must provide replacements of these
files with a more useful content in every case where the (empty) default
one does not meet the target’s requirements.

PTXdist first searches in the local project directory for a specific
configuration file and falls back to use the default one if none exists
locally. Refer section :ref:`install_alternative` for further
details in which order and locations PTXdist searches for these kind of files.

A popular example is the configuration file ``/etc/fstab``. The default
one coming with PTXdist works for the most common cases. But if our
project requires a special setup, we can just copy the default one to
the local ``./projectroot/etc/fstab``, modify it and we are done. The
next time PTXdist builds the root filesystem it will use the local
``fstab`` instead of the global (default) one.
