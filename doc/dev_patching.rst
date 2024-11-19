.. _patching_packages:

*****************
Patching Packages
*****************

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
=====================================

To create a patch series for the first time, we can run the following
steps. We are still using our *foo-1.1.0* example package here:

Using Quilt
-----------

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
---------

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

Recovering from merge conflicts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When updating packages, it can happen that older patches no longer apply.
In this case, the *extract* stage will throw errors like this::

   -----------------------------
   target: ima-evm-utils.extract
   -----------------------------

   extract: pkg_src=/ptx/src/ima-evm-utils-1.3.2.tar.gz
   extract: pkg_dir=DistroKit/platform-v7a/build-target/ima-evm-utils-1.3.2
   patchin: git: initializing repository
   patchin: git: done

   pkg_patch_dir:     'ptxdist/patches/ima-evm-utils-1.3.2'
   pkg_patch_series:  'ptxdist/patches/ima-evm-utils-1.3.2/series'

   patchin: git: apply 'ptxdist/patches/ima-evm-utils-1.3.2/series'
   tagging -> base
   0001-INSTALL-remove-file-at-it-s-autogenerated-by-autotoo.patch
   0002-Makefile.am-rename-INCLUDES-AM_CPPFLAGS.patch
   error: patch failed: src/Makefile.am:1
   error: src/Makefile.am: patch does not apply
   make: *** […/ptxdist/rules/post/ptxd_make_world_extract.make:41: …/DistroKit/platform-v7a/state/ima-evm-utils.extract] Error 4

In the example above, the first patch was applied cleanly, but the second one
was not because src/Makefile.am contained different lines than expected.
If this happens, you have to clean up the merge conflict,
and apply the remaining patches manually.

First, change into the package's build directory, and abort the current patch::

   …/distrokit/master (master) $  cd platform-v7a/build-target/ima-evm-utils-1.3.2/

   …/build-target/ima-evm-utils-1.3.2 (master|AM/REBASE) $  git log --oneline --graph
   * 6687ab46087c (HEAD -> master) INSTALL: remove file, as it's autogenerated by autotools
   * 01a52624237f (tag: ima-evm-utils-1.3.2, tag: base) initial commit

   …/build-target/ima-evm-utils-1.3.2 (master|AM/REBASE) $  git am --abort

   …/build-target/ima-evm-utils-1.3.2 (master) $

(Notice how the Git integration in the shell prompt still shows ``AM/REBASE``
before the cleanup, signaling the ongoing conflict resolution.)

The remaining patches are still available in the ``./patches`` directory
relative to your current location.
Try to apply each of them in turn using ``git am``.
If a patch fails to apply, Git will not change any files, but will still
remember the patch's author and commit message, and prompt you to resolve
the conflicts::

   …/build-target/ima-evm-utils-1.3.2 (master) $  git am patches/0005-evmctl-add-fallback-definitions-for-XATTR_NAME_IMA.patch

   Applying: evmctl: add fallback definitions for XATTR_NAME_IMA
   Patch failed at 0005 evmctl: add fallback definitions for XATTR_NAME_IMA
   hint: Use 'git am --show-current-patch=diff' to see the failed patch
   When you have resolved this problem, run "git am --continue".
   If you prefer to skip this patch, run "git am --skip" instead.
   To restore the original branch and stop patching, run "git am --abort".

* If you find that the patch is no longer necessary (e.g. because it was
  already merged upstream in the new package version), skip it with
  ``git am --skip``.
* Otherwise, apply the same patch again manually via ``patch --merge -p1 <
  patches/filename.patch``, and resolve any resulting conflicts using your
  favourite editor.
* Finally, ``git am --continue`` commits your conflict resolution with the
  patch's original author and log message.

After porting all patches, update the package's patch queue with ``git ptx-patches``.

Adding More Patches to a Package
================================

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
===============================

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
