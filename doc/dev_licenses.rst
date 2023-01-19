.. _licensing_in_packages:

Tracking licensing information in packages
------------------------------------------

PTXdist aims to track licensing information for every package.
This includes the license(s) under which a package can be distributed,
as well as the respective files in the package's source tree that state those terms.
Sadly there is no widely adopted standard for machine-readable licensing
information in source code (`yet <https://reuse.software>`_),
so here are a few hints where to look.

In that process, we aim to collect the baseline set of licenses
which at least apply to a package.
There may be other licenses which apply too, but the complete set often cannot
be found without a time-consuming review.
Still, the extracted license information in PTXdist can serve as a hint for
the full license compliance process,
and can help to exclude certain software under certain licenses from the build.

There are many older package rules in PTXdist which don't specify licensing information.
If you want to help complete the database,
you can use ``grep -L _LICENSE_FILES rules/*.make`` (in the PTXdist tree) to find those rules.
Note however that this cannot find wrong or incomplete licensing information.

Finding licensing information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should first select and extract the package in question, and then have a
look at in the extracted package sources (usually something like
``platform-nnn/build-target/mypackage-1.0`` in your BSP, if in doubt see
``ptxdist package-info mypackage``).

* Check for files named ``COPYING``, ``COPYRIGHT``,  or ``LICENSE``.
  These often only contain the license text and, in case of GPL, no information
  if the code is available under the *-only* or *-or-later* variant.
  Sometimes these files are in a folder ``/doc`` or ``/legal``.

* Check the ``README``, if there is any.
  Often there is important information there, e.g. in case of GPL if the
  software is *GPL-x.x-or-later* or *GPL-x.x-only*.

* Check source files, like ``*.c`` for license headers.
  Often additional information can be found here.

* If you want to be extra sure, use a license compliance toolchain (e.g.
  `FOSSology <https://www.fossology.org/>`__) on the project.

Ideally you'll find two pieces of information:

* A *license text* (e.g. a GNU General Public License v2.0 text)
* A *license statement* that states that a certain license applies to (parts of) the project
  (often also including copyright statements and a warranty disclaimer)

Some licenses (e.g. BSD-style licenses) are also short enough so that both
pieces are combined in a short comment header in a source file or a README.
Strictly speaking, both the license text and the license statement must be
present for a complete, unambiguous license, but see the next section about
edge cases.

On the other hand, there are some parts that can be ignored for our purposes:

* Everything that is auto-generated, either by a script in the project source,
  or by the build system previous to packaging.
  The generator itself cannot hold copyright, although the authors of the
  templates used for the generation or the authors of the generator can.

* Most files belonging to the build system don't make it into the compiled code
  and can therefore be ignored (e.g. configure scripts, Makefiles).
  These cases sometimes can be hard to detect – if unsure, include the file in
  your research.

Some projects also include a COPYING.LIB containing an LGPL text, which is
referenced nowhere in the project.
In that case, ignore the COPYING.LIB – it probably comes from a boilerplate
project skeleton and the maintainer forgot to delete it.

Distillation into license identifiers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In PTXdist, we use `SPDX license expressions <https://spdx.org/licenses/>`_.

Either the license identifier is clear, e.g. because the README says "GPL 2.0
or later" (check the license text to be sure), or you can use tools like
`FOSSology <https://www.fossology.org>`__,
`licensecheck <https://wiki.debian.org/CopyrightReviewTools#Command-line_tools_in_Debian>`_,
or `spdx-license-match <https://github.com/rohieb/spdx-license-match>`_
to match texts to SPDX license identifiers.

License texts don't have to match exactly, you should apply the
`SPDX Matching Guidelines <https://spdx.org/spdx-license-list/matching-guidelines>`_
accordingly.
The important part here is that the project's license and the SPDX identifier
describe the same licensing terms.
"Rather close" or "mostly similar" statements are not enough for a match,
but simple unimportant changes like replacing *"The Author"* with the project's
maintainer's name, or a change in e-mail adresses, are usually okay.

For software that is not open-source according to the `OSI definition
<https://opensource.org/osd>`_, use the identifier ``proprietary``.

.. important::

   If no license identifier matches, or if anything is unclear about the
   licensing situation, use the identifier ``custom`` (for licenses)
   or ``custom-exception`` (for license exceptions, e.g.: ``GPL-2.0-only WITH
   custom-exception``).

If SPDX doesn't know about a license yet, and the project is considered open
source or free software, you can `report its license to be added to the SPDX
license list
<https://github.com/spdx/license-list-XML/blob/master/CONTRIBUTING.md#request-a-new-license-or-exception-be-added-to-the-spdx-license-list>`_.

Multiple licenses
^^^^^^^^^^^^^^^^^

Open-source software is re-used all the time, so it can happen that some files
make their way into a different project.
This is usually no problem.
If you encounter multiple parts of the project under different licenses, combine
their license expressions with ``AND``.
For example, in a project that contains both a library and command line tools,
the license expression could be ``GPL-2.0-or-later AND LGPL-2.1-or-later``.

Sometimes files are licensed under multiple licenses, and only one license is to
be selected.
In that case, combine the license expressions with ``OR``.
This is often the case with Device Trees in the Linux kernel, e.g.:
``GPL-2.0-only OR BSD-2-Clause``.

No operator precedence is defined, use brackets ``(…)`` to group sub-statements.

Conflicting and ambiguous statements
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Human interpretation is needed when statements inside the project conflict with
each other.
Some clues that can help you decide:

Detailedness:
  If the header in the COPYING file says *"GNU General Public License"*, but
  the license text below that is in fact a BSD license, the correct license for
  the license identifier is the BSD license.

Author Intent:
  If the README says *"this code is LGPL 2.1"*, but COPYING contains a GPL
  boilerplate license text, the correct license identifier is probably *"LGPL 2.1"*
  – the README written by the author prevails over the boilerplate text.

Recency:
  If README and COPYING are both clearly written by the author themselves, and
  the README says *"don't do $thing*" and COPYING says *"do $thing*", the more
  recent file prevails.

Scope:
  If no license statement can be found, but there is a COPYING file containing
  a license text, infer that the whole project is licensed under that license.

Err on the side of caution:
  If all you can find is a GPL license text, this doesn't yet tell you whether
  the project is licensed under the *-only* or the *-or-later* variant.
  In that case, interpret the license restrictively and choose the *-only*
  variant for the license identifier.

Don't assume:
  If anything is ambiguous or unclear, choose ``custom`` as a license identifier.

.. note::

   Any of these cases is considered a bug and should be reported to the upstream maintainers!

"Public Domain" software
^^^^^^^^^^^^^^^^^^^^^^^^

For `good reasons <https://wiki.spdx.org/view/Legal_Team/Decisions/Dealing_with_Public_Domain_within_SPDX_Files>`_,
SPDX doesn't supply a license identifier for "Public Domain".
Nevertheless, some PTXdist package rules specify ``public_domain`` as their
respective license identifier.
This is purely for historical reasons, and ``public_domain`` should normally
*not* be used for new packages.
Some of those "Public Domain" dedications in packages have since been accepted
in SPDX, e.g. `libselinux <https://spdx.org/licenses/libselinux-1.0.html>`_ or
`SQLite <https://spdx.org/licenses/blessing.html>`_.

No license information at all
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

No license - no usage rights!

Definitely report this bug to the upstream maintainer.
Maybe even point them in the direction of `machine-readablity <https://reuse.software/>`_ :)

Adding license files to PTXdist packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The SPDX license identifier of the package goes into the ``<PKG>_LICENSE``
variable in the respective package rule file.
All relevant files identified in the steps above are then added to the variable ``<PKG>_LICENSE_FILES``,
including a checksum so that PTXdist complains when they change.

Example:

.. code-block:: make

   DDRESCUE_LICENSE	:= GPL-2.0-or-later AND BSD-2-Clause
   DDRESCUE_LICENSE_FILES	:= \
           file://COPYING;md5=76d6e300ffd8fb9d18bd9b136a9bba13 \
           file://main.cc;startline=1;endline=16;md5=a01d61d3293ce28b883d8ba0c497e968 \
           file://arg_parser.cc;startline=1;endline=18;md5=41d1341d0d733a5d24b26dc3cbc1ac42

See the section :ref:`package_specific_variables` for more information about
the syntax of those two variables.

The MD5 sum for a block of lines can be generated with sed's ``p`` (print)
command applied to a range of lines.
For the example above, lines 1 to 16 of main.cc would be::

   $ sed -n 1,16p main.cc | md5sum -
   a01d61d3293ce28b883d8ba0c497e968

Always include the copyright statement ("Copyright YYYY (C) Some Person")
for the calculation of the checksum, even if it means that the checksum changes
on package updates when new years are added to the string.
While it is not is needed for most licenses to be valid, some licenses require
that it must not be removed (e.g. see GPLv2, section 1),
and it is proper etiquette to give attribution to the maintainers in the
license report document.

If additional information is in the README or license headers in source files
are used, also include these files (for source code: one of each is enough),
but use md5sum only on the relevant lines, so changes in the rest of the file
do not appear as license changes.

For rather chaotic directories with lots of license files, definitely include at
least one relevant source file with license headers (if there are any), as some
developers tend to accumulate license files without adjusting it to license
changes in their source.

.. note::

   For each single license identifier in the license expression, include at
   least one file with checksum in the ``<PKG>_LICENSE_FILES`` variable.

PTXdist will include all files (or their respective lines) that were referenced
in ``<PKG>_LICENSE_FILES`` as verbatim sources in the license report.
