{% if page.type ==='picture' %}
{%
  set js_commons = [
    'src/minigrid.min.js',
    'src/photo.js'
  ]
%}
{% endif %}

{% for common in js_commons %}
  <script type="text/javascript" src="../js/{{ common }}"></script>
{% endfor %}