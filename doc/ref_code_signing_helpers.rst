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

Preconditions:

- a certificate must have been appended to the CA keyring
  (see :ref:`cs_append_ca_from_pem`, :ref:`cs_append_ca_from_der`,
  :ref:`cs_append_ca_from_uri`)
