=={{ '=' * node.subname|length }}==
``{{ node.subname }}``
=={{ '=' * node.subname|length }}==

.. automodule:: {{ node.name }}
   :members:

   .. contents::
      :local:
{##}
{%- block modules -%}
{%- if subnodes %}
.. toctree::
{% for item in subnodes %}
   {{ item.name }}
{%- endfor %}
{##}
{%- endif -%}
{%- endblock -%}
{##}
.. currentmodule:: {{ node.name }}
{##}
{%- block functions -%}
{%- if node.functions %}

Functions
=========

{% for item in node.functions %}
.. autofunction:: {{ item }}
{##}
{%- endfor -%}
{%- endif -%}
{%- endblock -%}

{%- block classes -%}
{%- if node.classes %}

Classes
=======

{% for item in node.classes %}
.. autoclass:: {{ item }}
   :members:

   .. rubric:: Inheritance
   .. inheritance-diagram:: {{ item }}
      :parts: 1
{##}
{%- endfor -%}
{%- endif -%}
{%- endblock -%}

{%- block exceptions -%}
{%- if node.exceptions %}

Exceptions
==========

{% for item in node.exceptions %}
.. autoexception:: {{ item }}

   .. rubric:: Inheritance
   .. inheritance-diagram:: {{ item }}
      :parts: 1
{##}
{%- endfor -%}
{%- endif -%}
{%- endblock -%}

{%- block variables -%}
{%- if node.variables %}

Variables
=========

{% for item, obj in node.variables.items() %}
.. autodata:: {{ item }}
   :annotation:

   .. code-block:: guess

      {{ obj|pprint|indent(6) }}
{##}
{%- endfor -%}
{%- endif -%}
{%- endblock -%}
