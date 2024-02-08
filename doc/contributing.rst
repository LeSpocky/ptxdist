Contributing to PTXdist
=======================

Development Tree
----------------

PTXdist uses Git for version control.
The master repository is available at::

   git://git.pengutronix.de/ptxdist

A `Git web interface <https://git.pengutronix.de/cgit/ptxdist/>`_ is also available.

How to Contribute
-----------------

Patches for PTXdist are always welcome.
Contributions should be sent to the :ref:`mailing_list`.
This is usually done with ``git send-email``.
If you're unfamiliar with this workflow, have a look at the intro at
`git-send-email.io <https://git-send-email.io/>`_.

All patches must contain a descriptive subject and should, for all
non-obvious changes, contain a commit message describing what has changed
and why this is necessary.

Each patch accepted into the master repository must be certified to be
compatible with PTXdist's license (GPLv2, see `COPYING`_).
To do this you have to sign your patches (or the ones you forward).
If you can certify the below::

   Developer's Certificate of Origin 1.1
   
   By making a contribution to this project, I certify that:
   
   (a) The contribution was created in whole or in part by me and I
       have the right to submit it under the open source license
       indicated in the file; or
   
   (b) The contribution is based upon previous work that, to the best
       of my knowledge, is covered under an appropriate open source
       license and I have the right under that license to submit that
       work with modifications, whether created in whole or in part
       by me, under the same open source license (unless I am
       permitted to submit under a different license), as indicated
       in the file; or
   
   (c) The contribution was provided directly to me by some other
       person who certified (a), (b) or (c) and I have not modified
       it.
   
   (d) I understand and agree that this project and the contribution
       are public and that a record of the contribution (including all
       personal information I submit with it, including my sign-off) is
       maintained indefinitely and may be redistributed consistent with
       this project or the open source license(s) involved.

then you just add a line saying::

   Signed-off-by: Random J Developer <random@developer.example.org>

using your real name (sorry, no pseudonyms or anonymous contributions) at the
end of the patch description.

.. _COPYING: https://git.pengutronix.de/cgit/ptxdist/tree/COPYING

There are some more usual tags (like *Acked-by* or *Reported-by*) which only
have informational character and so are not formally specified here.
See the `Linux kernel documentation
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html>`_
for a more complete list.

PTXdist Packages
----------------

While contributions to all parts of PTXdist are welcome, most contributions
concern individual packages. Here is a checklist of things to look out for
while creating or updating packages. These are not hard requirements, but
there should be good reasons for different choices.

Package Builds should be Reproducible
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many packages autodetect which features are available. As a result, the
exact features of a package may depend on the build host and the build
order of the packages. To avoid this, autodetection must be restricted as
much as possible.

For **autoconf** based packages, the first step is to specify all relevant
``configure`` options. The :ref:`configure_helper` script can help filter
out the unimportant options.

There are also cache variables that can be used to enforce the outcome of
autodetection if no option is available:

.. code-block:: make

  SOMEPKG_CONF_ENV := \
  	$(CROSS_ENV) \
  	ac_cv_broken_sem_getvalue=no

:ref:`configure_helper` also supports **meson** and **cmake**.
Note that the prepare stage for the package must be executed first.

Packages Suboptions
~~~~~~~~~~~~~~~~~~~

Suboptions for PTXdist packages are useful to make parts of the package
optional. However, it is not always easy to decide what should be optional
and how to map the build system options to package suboptions. Here are a
few guidelines to help with that.

-  Avoid unnecessary suboptions. When in doubt, use the package default or
   what other distributions use. If the creator of the package does not
   know what to choose, then the user won't either.
-  Use suboptions to save disk space. If a feature adds extra dependencies
   or uses a lot of space then a suboption is useful to save disk
   space when the feature is not needed.
-  Try to create high-level options. Some packages have very low-level
   build options with very few useful combinations. Try to distill the
   high-level features or use-cases and define options for those.
-  Options for new use-cases can always be added later. It's perfectly
   acceptable to just disable some unused features when creating a new
   package. When they are needed, then a new option can be added.

Updating a Package to a new Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The most common contribution to PTXdist are new versions for existing
packages. This is usually quite simple, but there are a few things to keep
in mind:

-  New versions can have new build system options that should be set for
   reproducible builds.
   :ref:`configure_helper` can be used to find the new options.
-  There may be patches for the old version. Make sure they are updated as
   well, or removed if they are no longer needed.
   Running ``ptxdist lint`` will tell you about this.
-  Run ``ptxdist licensecheck [<pkg>]`` to make sure that the checksum of
   pinned-down license files haven't changed.

   If the license file has changed, look at the difference between the old and
   the new version of the file (e.g. by comparing the two versioned build
   folders in ``platform-nnn/build-target/``), and update the package's
   ``_LICENSE`` variable if necessary.
   Often the difference is only in the copyright year, but in any case, describe
   the changes in the license file when sending your patch!

Misc
~~~~

For new packages, the top-level option and any non-obvious suboptions should
have a help text. The homepage of a package or the package description from
other distributions are usually a good inspiration.

For new packages, the generated templates contain commented-out default
sections. These are meant as a helper to simplify creating custom stages.
Any remaining default stages must be removed.

All submissions should be checked with ``ptxdist lint``. It does basic
sanity checks and finds some typical errors. Old patches that where not
updated of removed after a version bump. Unknown PTXCONF_* variables or
macros used in menu files. There are often typos or the variables was just
removed.

New packages must also have licensing information in the ``<PKG>_LICENSE``
and ``<PKG>_LICENSE_FILES`` variables.
Refer to the section :ref:`licensing_in_packages` for more information.

Helper Scripts
--------------

.. _configure_helper:

configure_helper.py
~~~~~~~~~~~~~~~~~~~

``configure_helper.py`` can be found in ``scripts/`` in the PTXdist source
tree. It should be used to determine which build system options should be
specified for a package. Currently, only **autoconf** and **meson** based
packages are supported.

It provides a diff between two lists of options. These list are generated
from the options specified in the package Makefile and from the source tree
of the package.

Both **autoconf** and **meson** provide several options that are rarely
needed. This tool contains a blacklist to filter out these options.

``configure_helper.py`` supports the following command-line options:

``-h, --help``
    Show the help message and exit

``-p <pkg>, --pkg <pkg>``
    The ptxdist package to check

``-o <old>, --old-src <old>``
    The old source directory

``-n <new>, --new-src <new>``
    The new source directory

``-s <only, --only-src <only``
    The only source directory

``--sort``
    Sort the options before comparing

``-f, --force``
    Call PTXdist with ``--force``

There are several different ways to configure arguments:

.. code-block:: sh

  $ configure_helper.py --pkg <pkg>

This will compare the available configure arguments of the current version
with those specified in PTXdist

.. code-block:: sh

  $ configure_helper.py --only-src /path/to/src --pkg <pkg>

This will compare the available configure arguments of the specified source
with those specified in PTXdist

.. code-block:: sh

  $ configure_helper.py --old-src /path/to/old-src --pkg <pkg>
  $ configure_helper.py --new-src /path/to/new-src --pkg <pkg>

This will compare the available configure arguments of the current version
with those of the specified old/new version

.. code-block:: sh

  $ configure_helper.py --new-src /path/to/new-src --old-src /path/to/old-src

This will compare the available configure arguments of the old and new
versions.

If ``--pkg`` is used, then the script must be called in the BSP workspace.
The environment variable ``ptxdist`` can be used to specify the PTXdist
version to use.
