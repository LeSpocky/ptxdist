.. _adding_files:

Adding Binary Only Files
------------------------

Sometimes a few binary files have to be added into the root filesystem.
Or - to be more precise - some files, that do not need to be built in
any way.

On the other hand, sometimes files should be included that are not
covered by any open source license and so, should not be shipped in the
source code format.

Add Binary Files File by File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Doing to on a file by file base can happen by just using the ``install_copy``
macro in the *targetinstall* stage in our own customized rules file.

.. code-block:: none

    @$(call install_copy, binary_example, 0, 0, 0644, \
       </path/to/some/file/>ptx_logo.png, \
       /example/ptx_logo.png)

It copies the file ``ptx_logo.png`` from some location to target’s root
filesystem. Refer :ref:`install_copy` for further information about using the
``install_copy`` macro.

The disadvantage of this method is: if we want to install more than one
file, we need one call to the ``install_copy`` macro per file. This is
even harder if not only a set of files is to be installed, but a whole
directory tree with files instead.

Add Binary Files via an Archive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If a whole tree of files is to be installed, working with a *tar* based
archive could make life easier. In this case the archive itself provides
all the required information the files are needing to be installed in a
correct manner:

-  the file itself and its name

-  the directory structure and the final location of every file in this
   structure

-  user and group ID on a per file base

.. code-block:: none

    @$(call install_archive, binary_example, -, -, \
       </path/to/an/>archive.tgz, /)

Refer :ref:`install_archive` for further information about using the
``install_archive`` macro.

Using an archive can be useful to install parts of the root filesystem
that are not covered by any open source license. Its possible to ship
the binaries within the regular BSP, without the need for their sources.
However it is possible for the customer to re-create everything required
from the BSP to get their target up and running again.

Another use case for the archive method could be the support for
different development teams. One team provides a software component in
the archive format, the other team does not need to build it but can use
it in the same way than every other software component.

Creating a Rules File
~~~~~~~~~~~~~~~~~~~~~

Let PTXdist create one for us.

.. code-block:: text

    $ ptxdist newpackage file

    ptxdist: creating a new 'file' package:

    ptxdist: enter package name.......: my_binfiles
    ptxdist: enter version number.....: 1
    ptxdist: enter package author.....: My Name <me@my-org.com>
    ptxdist: enter package section....: rootfs

Now two new files are present in the BSP:

#. ``rules/my_binfiles.in`` The template for the menu

#. ``rules/my_binfiles.make`` The rules template

Both files now must be customized to meet our requirements. Due to the
answer *rootfs* to the “``enter package section``” question, we will
find the new menu entry in:

.. code-block:: text

    Root Filesystem --->
    	< > my_binfiles (NEW)

Enabling this new entry will also run our stages in
``rules/my_binfiles.make`` the next time we enter:

.. code-block:: text

    $ ptxdist go
