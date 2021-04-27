.. _kconfig-diffs:

Kconfig Diffs
-------------

For packages using Kconfig as their configuration system, PTXdist can generate
their config file from another *reference config file* and a *Kconfig diff* on
the fly.
This mechanism can be used to build configuration variants of a kernel or
barebox package.
For example, a "debug" kernel package can refer to the config file of the
"production" kernel as its reference config file, and its Kconfig diff then
only contains the Kconfig symbols that were changed in the "debug" variant:

+-----------------------------------+-------------------------------------+-----------------------------------+
| release config symbol             | debug kconfig diff                  | resulting debug config symbol     |
+===================================+=====================================+===================================+
| CONFIG_LOCALVERSION="release"     | CONFIG_LOCALVERSION="debug"         | CONFIG_LOCALVERSION="debug"       |
+-----------------------------------+-------------------------------------+-----------------------------------+
| # CONFIG_ARCH_MULTI_V6 is not set |                                     | # CONFIG_ARCH_MULTI_V6 is not set |
+-----------------------------------+-------------------------------------+-----------------------------------+
| CONFIG_ARCH_MULTI_V7=y            |                                     | CONFIG_ARCH_MULTI_V7=y            |
+-----------------------------------+-------------------------------------+-----------------------------------+
| # CONFIG_CGROUP_DEBUG is not set  | CONFIG_CGROUP_DEBUG=y               | CONFIG_CGROUP_DEBUG=y             |
+-----------------------------------+-------------------------------------+-----------------------------------+
| # CONFIG_DEBUG_PREEMPT is not set | CONFIG_DEBUG_PREEMPT=y              | CONFIG_DEBUG_PREEMPT=y            |
+-----------------------------------+-------------------------------------+-----------------------------------+
| CONFIG_WATCHDOG=y                 | # CONFIG_WATCHDOG is not set        | # CONFIG_WATCHDOG is not set      |
+-----------------------------------+-------------------------------------+-----------------------------------+
| CONFIG_WATCHDOG_CORE=y            | # CONFIG_WATCHDOG_CORE is undefined |                                   |
+-----------------------------------+-------------------------------------+-----------------------------------+
| CONFIG_BCM2835_WDT=y              | # CONFIG_BCM2835_WDT is undefined   |                                   |
+-----------------------------------+-------------------------------------+-----------------------------------+

Kconfig does not write symbols to the config file that have unfulfilled dependencies (e.g., in the
above example ``CONFIG_WATCHDOG_CORE`` and ``CONFIG_BCM2835_WDT`` depend on ``CONFIG_WATCHDOG``).
Those symbols that are not present in the resulting debug config file are represented as ``… is
undefined`` in the diff.

The first line of the Kconfig diff file contains the MD5 sum of the reference config file.
PTXdist uses this checksum to detect when the reference config has changed,
in which case the diff needs to be regenerated from the package's config file,
and to make sure that the diff is applicable to the reference config.

Using Kconfig diffs
~~~~~~~~~~~~~~~~~~~

The main part is setting the ``<PKG>_REF_CONFIG`` variable of a package to the reference config
file, for example::

   # rules/kernel.make:
   KERNEL_CONFIG		:= $(call ptx/in-platformconfigdir, kernelconfig-release)

::

   # rules/kernel-debug.make:
   KERNEL_DEBUG_CONFIG		:= $(call ptx/in-platformconfigdir, kernelconfig-debug)
   KERNEL_DEBUG_REF_CONFIG	:= $(call ptx/in-platformconfigdir, kernelconfig-release)

PTXdist will now automatically generate ``kernelconfig-debug`` from ``kernelconfig-release`` and
``kernelconfig-debug.diff`` whenever doing and *oldconfig* or *menuconfig* on the *kernel-debug*
package.
If any symbols were changed by that operation, both the ``kernelconfig-debug.diff`` and the
``kernelconfig-debug`` are updated afterwards.

Kconfig diffs and layers
~~~~~~~~~~~~~~~~~~~~~~~~

PTXdist uses the same diff mechanism whenever the config file of a Kconfig-style package is changed
in an inherited layer (see :ref:`layers-in-ptxdist`).
In that case, the diff is calculated between the package's config file in the base layer and the
package's (adapted) config file in the current layer.

.. note::
   When using both ``<PKG>_REF_CONFIG`` and inter-layer Kconfig diffs, the inter-layer diff takes
   precedence, and the reference config file in the inherited layer is ignored.
   In the following example, arrows represent the config diff relation:

   .. image:: dev_kconfig_diffs_layer_precedence.svg
