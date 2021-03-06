.. highlight:: sh

Writing docstrings for Sphinx
=============================

To comply with Sphinx, a tool that extracts information from docstrings,
several considerations must be taken into account:

-  No indentation change is allowed unless it is introduced by a Sphinx
   directive
-  Inside a paragraph, new lines are ignored.
-  The list of parameters will be generated writing special formatting
   markup.

Packages
--------

For packages and subpackages, write docstrings that describe the package
in ``__init__.py``. One liners are OK.

::

    """
    Brief description of package

    Long description of package.
    This line is in the same paragraph.
    """

.. note::

    -  The long description can have many paragraphs
    -  Notice the use of double (instead of single) quotes
    -  Use the opening and closing quotes in a line of its own

Modules
-------

For each module, describe the module in the docstring:

::

    """
    Brief description of module

    Detailed description of module
    """

Functions
---------

As a convention, the format for docstrings in topology common is as
follows:

::

    def function_name1(param1, param2, param3):
        """
        Brief description of function

        Detailed descrption of function

        :param param1: <0-255> Description
        :param type_x param2: The description of this parameter is too long
            to fit in one line.  Use indentation
        :param param3: Description
        :type param3: type_of_param3
        :returns: Description of the return value
        :rtype: return_type
        """

This will rendered as follows:

.. py:function:: function_name1(param1, param2, param3)

   Brief description of function

   Detailed descrption of function

   :param param1: <0-255> Description
   :param type_x param2: The description of this parameter is too long
      to fit in one line.  Use indentation.
   :param param3: Description
   :type param3: type_of_3rd_param
   :returns: Description of the return value
   :rtype: return_type

.. note::

    -  Use type information only in necessary cases.
    -  Notice the two equivalent ways of declaring type information in
       ``param_2`` and ``param_3``
    -  Use parameter lists and return values where applicable.
    -  Don't end descriptions with a period (Exception: long
       descriptions)

.. warning::

    The indentation in the multiline description of ``param2`` is
    mandatory. Any number of spaces produces the same output.

Elaborate docstrings
--------------------

Sphinx understands reStructuredText, a lightweight markup language, and
expands it for code API documentation. Some useful formatting is
presented in the following docstring:

::

    """
    You can cross-reference functions with :py:func:`function_name1`,
    and modules with :py:mod:`my_other_module`.

    To show a hyperlink use:
    `PEP-8 <https://www.python.org/dev/peps/pep-0008/>`_
    or just the link: https://www.python.org/dev/peps/pep-0008/

    Use two asterisks for text in **bold**,
    one for text in *italics*,
    double backquotes for ``code``.

    To write lists, leave a blank line before and after the list and don't indent the items.

    * This is a bullet list
    * You can use *, -, +

    * The blank line above is optional. For multiline items
      you must follow the item indentation.
    * You can nest lists

      * The blank line above is required
      * The blank line after the last item is required

    * Returned to the parent

    1. This is an ordered list.
    2. It can be numeric, alphabetic or roman

       a) You can use 1. or 1) or (1)
       b) but be consistent

    #. This will generate next number
    #. Inconsistent numbering will produce different lists.
       Ending the list with a blank line is mandatory, even if it is at the end of the docstring.

    To show an example in the interactive shell write it with one indentation and separated by
    blank lines:

        >>> def foo(msj='Success'):
        ...     assert msj == 'Success', 'Foo Fail'
        ...
        >>> retry_wrapper('Hello World','Error msj',1,3)(foo)()
        Hello World

        >>> retry_wrapper('Hello World','Error msj',1,1)(foo)('fail')
        Hello World
        Error msj
        Waiting 1 seconds to retry
        Error msj
        Retry time of 1 seconds expired
        Traceback (most recent call last):
           File "<stdin>", line 1, in <module>
           File "retry_wrapper.py", line 19, in wrapper
              func(*args, **kwargs)
           File "<stdin>", line 2, in foo
        AssertionError: Foo Fail

    For more formatting markup see: http://www.sphinx-doc.org/en/stable/rest.html
    """

This will produce:

.. py:function:: function()

    You can cross-reference functions with :py:func:`function_name1`,
    and modules with :py:mod:`my_other_module`.

    To show a hyperlink use:
    `PEP-8 <https://www.python.org/dev/peps/pep-0008/>`_
    or just the link: https://www.python.org/dev/peps/pep-0008/

    Use two asterisks for text in **bold**,
    one for text in *italics*,
    double backquotes for ``code``.

    To write lists, leave a blank line before and after the list and don't indent the items.

    * This is a bullet list
    * You can use \*, -, +

    * The blank line above is optional. For multiline items
      you must follow the item indentation.
    * You can nest lists

      * The blank line above is required
      * The blank line after the last item is required

    * Returned to the parent

    1. This is an ordered list.
    2. It can be numeric, alphabetic or roman

       a) You can use 1. or 1) or (1)
       b) but be consistent

    #. This will generate next number
    #. Inconsistent numbering will produce different lists.
       Ending the list with a blank line is mandatory, even if it is at the end of the docstring.

    To show an example in the interactive shell write it with one indentation and separated by
    blank lines:

        >>> def foo(msj='Success'):
        ...     assert msj == 'Success', 'Foo Fail'
        ...
        >>> retry_wrapper('Hello World','Error msj',1,3)(foo)()
        Hello World

        >>> retry_wrapper('Hello World','Error msj',1,1)(foo)('fail')
        Hello World
        Error msj
        Waiting 1 seconds to retry
        Error msj
        Retry time of 1 seconds expired
        Traceback (most recent call last):
           File "<stdin>", line 1, in <module>
           File "retry_wrapper.py", line 19, in wrapper
              func(*args, **kwargs)
           File "<stdin>", line 2, in foo
        AssertionError: Foo Fail

    For more formatting markup see: http://www.sphinx-doc.org/en/stable/rest.html


For usage examples with valid data for function parameters use the
following example:

::

    def function_name2(node, router_id, neighbor_dict, step=None):
        """
        Brief description of function

        Detailed descrption of function

        :param node: A modular framework node object that supports the vty shell
        :param router_id: Short description
            ::

                Ex: '1.1.1.1'

        :param neighbor_dict: The description of this parameter is too long
            to fit in one line ::

                Ex:  {<neighbor1>: <update-source1>,
                      <neighbor2>: <update-source2>}
                     {'168.51.2.3': '168.51.2.4',
                      '192.151.21.4': '192.151.21.5'}

        :param step: A modular framework step object to set a debugging mark.
            Default: None
        """
        step and step("Description. Try to use arguments {}".format(router_id))

This will produce:

.. py:function:: function_name2()

        Brief description of function

        Detailed descrption of function

        :param node: A modular framework node object that supports the vty shell
        :param router_id: Short description
            ::

                Ex: '1.1.1.1'

        :param neighbor_dict: The description of this parameter is too long
            to fit in one line ::

                Ex:  {<neighbor1>: <update-source1>,
                      <neighbor2>: <update-source2>}
                     {'168.51.2.3': '168.51.2.4',
                      '192.151.21.4': '192.151.21.5'}

        :param step: A modular framework step object to set a debugging mark.
            Default: None


-  Use two colons (::) to introduce a literal block
-  The colons **must not** go on the first line of the description
-  If you put them in a line of their own, indent them (Ex:
   ``param router_id``)
-  If they follow the text, separate them by at least one space (Ex:
   ``param neighbor_dict``)
-  The literal block must follow the two colons with a blank line and
   extra indentation
-  The blank line following the literal code is optional, for esthetic
   purposes

.. note::

    A side effect of adding literal blocks is a change in font for the
    description which is output below the parameter, not alongside.

.. tip::

    -  Use the step function with default None and validate it
    -  Run ``tox -e doc`` or ``tox`` to make sure your docstrings are
       properly formatted

Global variables
----------------

For absolutely necessary cases, add important global variables and
constants to the API documentation like this:

::

    variable_name = 1000
    """This is an important global variable."""

which will produce:

.. py:data:: variable_name
   This is an important global variable.

