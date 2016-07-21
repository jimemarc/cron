=={{ '=' * node.subname|length }}==
``{{ node.subname }}``
=={{ '=' * node.subname|length }}==

.. automodule:: {{ node.name }}
   :members:
   :show-inheritance:

   .. rubric:: Inheritance
   .. inheritance-diagram:: {{ item }}
      :parts: 1

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
