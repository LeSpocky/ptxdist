Creating New Package Templates
------------------------------

For larger projects it can be convenient to have project specific package
templates. This can be achieved by either modifying existing templates or
by creating completely new templates.

Modifying a Template
~~~~~~~~~~~~~~~~~~~~

A template can be modified by providing new input files. This is easier
than creating a new template but does not allow to specify new variables to
substitute in the input files.

PTXdist looks for template files the same way it looks for rules files. The
only difference is, that it searches in the ``templates/`` subdirectory.
So a modified ``./rules/templates/template-target-make`` can be used to
tweak the ``target`` template.

Creating a New Template
~~~~~~~~~~~~~~~~~~~~~~~

For a completely new template, some bash scripting is required. All shell
code must be placed in a file named like this:
``./scripts/lib/ptxd_lib_*.sh``.

The minimum requirement for a new template is:
-  a shell function that creates the new package
-  registering the new template

.. code-block:: sh

    ptxd_template_new_mypkg() {
        # create the package here
    }
    export -f ptxd_template_new_mypkg
    ptxd_template_help_list[${#ptxd_template_help_list[@]}]="mypkg"
    ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create awesome mypkg package"

PTXdist provides several helper functions to simplify the template.
Using those functions, the package creation process is split into two
parts:

-  query the user for input and export variables.
-  create the new package files from the template source files by
   substituting all instances of ``@<variable>@`` with the value of the
   corresponding variable.

A simple template function could look like this:

.. code-block:: sh

    ptxd_template_new_mypkg() {
        ptxd_template_read_basic &&
        ptxd_template_read "enter download section" DL_SECTION "foobar"
        ptxd_template_read_author &&
        export section="local_${dlsection}" &&
        ptxd_template_write_rules
    }

This template requires ``rules/templates/template-mypkg-make`` and
``rules/templates/template-mypkg-in`` as source files. They could be
derived from the ``target`` template with a simple modification:

.. code-block:: make

    @PACKAGE@_SUFFIX	:= tar.xz
    @PACKAGE@_URL	:= http://dl.my-company.local/downloads/@DL_SECTION@/$(@PACKAGE@).$(@PACKAGE@_SUFFIX)

The helper functions that are used in the example above are defined in
``scripts/lib/ptxd_lib_template.sh`` in the PTXdist source tree.

The template is a normal shell function. Arbitrary things can be done here
to create the new package. The helper functions are just the most
convenient way to crate simple templates. It is also possible to create
more files. For examples, the builtin ``genimage`` template creates a extra
config file for the new package.
