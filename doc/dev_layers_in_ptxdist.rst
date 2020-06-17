.. _layers-in-ptxdist:

Layers in PTXdist
-----------------

For better maintenance or other reasons, a PTXdist project can be split
into multiple layers. Each layer has exactly the same directory hierarchy
as described in :ref:`directory_hierarchy` and other chapters.

All layers are explicitly stacked in the filesystem. The top layer is the
workspace of the PTXdist project. Any ``selected_*`` links and the platform
build directory are created here. The layer below is defined by the
subdirectory or symlink named ``base/``. More can be stacked the same
way, so ``base/base/`` is the third layer and so on.
In many ways, PTXdist itself can be considered as the bottom layer. This is
either implicit or explicit with one last ``base/`` symlink.

A project can overwrite files provided by PTXdist in many different ways,
e.g. rule files or files installed with :ref:`install_alternative` etc.
This concept expands naturally to layers. Each layer can overwrite files
provided by lower layers in the exact same way. Any files are always
searched for in a strict layer by layer order.

Writing Layer Aware Rules
~~~~~~~~~~~~~~~~~~~~~~~~~

For the most part, package rules work just as expected when multiple layers
are used. Any layer specific handling is done implicitly by PTXdist.
However, there are a few things that need special handling.

The variables :ref:`PTXDIST_WORKSPACE<ptxdist_workspace>` and
:ref:`PTXDIST_PLATFORMCONFIGDIR`<ptxdist_platformconfigdir>` always refer
to the directories in the top layer. These variables might be used in rules
files like this:

.. code-block:: make

   MY_KERNEL_CONFIG := $(PTXDIST_PLATFORMCONFIGDIR)/kernelconfig.special

If the referenced file is in any layer but the top one then it will not
be found. To handle use-cases like this, the macros :ref:`in_path` and
:ref:`in_platformconfigdir` can be used:

.. code-block:: make

   MY_KERNEL_CONFIG := $(call ptx/in-platformconfigdir, kernelconfig.special)

This way, the layers are searched top to bottom until the config file is
found.

PTXdist Config Files with Multiple Layers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In many cases a layer may want to modify the **ptxconfig** by enabling or
disabling some options. Any changes must be propagated through the whole
layer stack.

The features and workflow described here apply to the **ptxconfig**, the
**platformconfig** and any **collectionconfig** used in the project.

To do this, PTXdist stores a delta config to the layer below and a full
config file in each layer. If the two files are missing then the config is
unchanged. The bottom layer has only the config file and no delta.

At runtime, PTXdist will always use the full config file in the top layer
where the config exists. Before doing so, it will ensure that the config is
consistent across all layers. This means that, for any layer that contains a
delta config, the full config file of the layer below has not changed since
the delta config was last updated. If any inconsistency is detected,
PTXdist will abort.

For any command that modifies the config file, except ``oldconfig``,
PTXdist will use kconfig implicitly on all layers to check if the config
for this layer is up to date. This is a stricter check than the consistency
validation. For example, if a new package was added to a layer without
updating the **ptxconfig** then this will be detected and PTXdist will
abort. If all other layers are up to date, then PTXdist will use the delta
config of the top layer, apply it to the full config of the layer below
and execute the specified command with the resulting config file.

.. note:: If the config file does not exist yet on the top layer, then it
  will be created if changes to the config are made. Similarly the config
  will be deleted if the delta is empty after the changes. In either case
  it may be necessary to update any ``selected_*`` link to point to the
  correct config.

If PTXdist detects an inconsistency or an out of date config file then it
must be updated before they can be used. This can be done by using the
``oldconfig`` command. In this special case, PTXdist will iterate from the
bottom to the top layer and run ``oldconfig`` for each of them. It will
use the delta config applied to the full config of the layer below at each
step. This means that it's possible to enable or disable a option in the
bottom layer and ``oldconfig`` will propagate this change to all other
layers.

Packages with kconfig Based Config Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For packages such as the Linux kernel that have kconfig based config files,
a lot of the infrastructure to handle config files and deltas across
multiple layers can be reused. Consistency validation is done implicitly
and ``menuconfig`` and other kconfig commands will use config files and
deltas as expected.

It's not possible to implicitly run ``oldconfig`` on other layers (this may
require a different source tree for the packages), so any inconsistencies
must be resolved manually by running ``oldconfig`` explicitly on each
layer.

The make macros that provide these features are currently used by the
barebox and kernel packages and templates.
