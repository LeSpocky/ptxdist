.. _code_signing_helper_functions:

Code Signing Helper Functions
-----------------------------

PTXdist provides various bash helper functions to be used in :ref:`code signing
providers <code_signing_providers>` and :ref:`code signing consumers
<code_signing_consumers>`.

PTXdist stores URIs and CA keyrings using these helpers in
``$(PTXDIST_SYSROOT_HOST)/var/lib/keys/<signing-provider>/<role>/{uri,ca.pem}``.

SoftHSM Provider Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~

These helpers initialize and import public/private keys and certificates into
the SoftHSM.

.. _cs_init_softhsm:

cs_init_softhsm
^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_init_softhsm

Initialize SoftHSM, and set the initial pins.

.. _cs_import_cert_from_der:

cs_import_cert_from_der
^^^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_import_cert_from_der <role> <DER>

Import certificate from a given DER file for role.
To be used with SoftHSM only.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)
- SoftHSM must have been initialized (see :ref:`cs_init_softhsm`)

.. _cs_import_cert_from_pem:

cs_import_cert_from_pem
^^^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_import_cert_from_pem <role> <PEM>

Import certificate from a given PEM file for role.
To be used with SoftHSM only.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)
- SoftHSM must have been initialized (see :ref:`cs_init_softhsm`)

cs_import_pubkey_from_pem
^^^^^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_import_pubkey_from_pem <role> <PEM>

Import public key from a given PEM file for role.
To be used with SoftHSM only.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)
- SoftHSM must have been initialized (see :ref:`cs_init_softhsm`)

cs_import_privkey_from_pem
^^^^^^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_import_privkey_from_pem <role> <PEM>

Import private key from a given PEM file for role.
To be used with SoftHSM only.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)
- SoftHSM must have been initialized (see :ref:`cs_init_softhsm`)

cs_import_key_from_pem
^^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_import_key_from_pem <role> <PEM>

Import private/public key pair from a given PEM file for role.
To be used with SoftHSM only.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)
- SoftHSM must have been initialized (see :ref:`cs_init_softhsm`)

Generic Provider Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~

These helpers allow to define roles, set PKCS#11 URIs and handle certificate
authorities (CAs).
HSM as well as SoftHSM code signing providers should use them.

.. _cs_define_role:

cs_define_role
^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_define_role <role>

Define new key role.

A default PKCS#11 URI is set implicitly as convenience for SoftHSM use cases.

.. _cs_set_uri:

cs_set_uri
^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_set_uri <role> <URI>

Set given PKCS#11 URI for role.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)

.. _cs_append_ca_from_pem:

cs_append_ca_from_pem
^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_append_ca_from_pem <role> <PEM>

Append certificate from a given PEM file to the role's CA keyring.
If no CA keyring exists yet it is created as an empty file before.


Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)

.. _cs_append_ca_from_der:

cs_append_ca_from_der
^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_append_ca_from_der <role> <DER>

Append certificate from a given DER file to the role's CA keyring.
If no CA keyring exists yet it is created as an empty file before.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)

.. _cs_append_ca_from_uri:

cs_append_ca_from_uri
^^^^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_append_ca_from_uri <role> [<URI>]

Append certificate from a given PKCS#11 URI to the role's CA keyring.
If URI is omitted the already set URI for role is used.
If no CA keyring exists yet it is created as an empty file before.

Preconditions:

- the role must have been defined (see :ref:`cs_define_role`)
- when used with SoftHSM, certificates must have been imported before
  (see :ref:`cs_import_cert_from_der`, :ref:`cs_import_cert_from_pem`)

.. _cs_define_group:

cs_define_group
^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

   cs_define_group <group>

Define a new role group.

See :ref:`cs_group_add_roles` for an example.

.. _cs_group_add_roles:

cs_group_add_roles
^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

   cs_group_add_roles <group> <roles...>

Add all given roles to a role group.

Preconditions:

- the group must have been defined (see :ref:`cs_define_group`)
- the role(s) must have been defined (see :ref:`cs_define_role`)

Example:

.. code-block:: bash

   # define two roles named imx-habv4-srk1 and imx-habv4-srk2
   r="imx-habv4-srk1"
   cs_define_role "${r}"
   cs_set_uri "${r}" "pkcs11:object=SRK CA 0"
   cs_append_ca_from_uri "${r}"
   r="imx-habv4-srk2"
   cs_define_role "${r}"
   cs_set_uri "${r}" "pkcs11:object=SRK CA 1"
   cs_append_ca_from_uri "${r}"

   # define a group and add the roles
   g="imx-habv4-srk"
   cs_define_group "${g}"
   cs_group_add_roles "${g}" "imx-habv4-srk1" "imx-habv4-srk2"

.. _cs_group_get_roles:

cs_group_get_roles
^^^^^^^^^^^^^^^^^^

Usage:

.. code-block:: bash

   cs_group_get_roles <group>

Get a list of all roles that have been added to the role group.

Example:

.. code-block:: bash

   # iterate over role names in a role group, and print their name and URI
   for role in $(cs_group_get_roles "imx-habv4-srk"); do
   	echo "role '${role}' has URI '$(cs_get_uri "${role}")'"
   done

In the example given in :ref:`cs_group_add_roles` above, this would print::

   role 'imx-habv4-srk1' has URI 'pkcs11:object=SRK CA 0'
   role 'imx-habv4-srk2' has URI 'pkcs11:object=SRK CA 1'

Consumer Functions
~~~~~~~~~~~~~~~~~~

Packages that want to sign something or need access to keys/CAs can retrieve
PKCS#11 URIs and CA keyrings with these helpers.

.. _cs_get_uri:

cs_get_uri
^^^^^^^^^^

Usage:

.. code-block:: bash

    cs_get_uri <role>

Get PKCS#11 URI for role.

Preconditions:

- the URI must have been set (see :ref:`cs_set_uri`)

.. _cs_get_ca:

cs_get_ca
^^^^^^^^^

Usage:

.. code-block:: bash

    cs_get_ca <role>

Get path to the CA keyring in PEM format for role.

If the provider does not set a CA for this role (see :ref:`cs_append_ca_from_pem`,
:ref:`cs_append_ca_from_der`, :ref:`cs_append_ca_from_uri`), this function will print an empty
string.

Preconditions:

- The role must have been defined by the provider (see :ref:`cs_define_role`).
  Otherwise, this function will print ``ERROR_CA_NOT_YET_SET`` and return 1.
  This can happen if the function is evaluated by a variable expansion in make
  with ``:=`` instead of ``=`` before the code signing provider is set up.

Example:

.. code-block:: make

   # set up kernel module signing, and add a trusted CA if the provider set one
   KERNEL_SIGN_OPT =
   	CONFIG_MODULE_SIG_KEY='"$(shell cs_get_uri kernel-modules)"' \
   	CONFIG_MODULE_SIG_ALL=y \
   	$(if $(shell cs_get_ca kernel-trusted), \
   		CONFIG_SYSTEM_TRUSTED_KEYS=$(shell cs_get_ca kernel-trusted))
