{% if page.type ==='picture' %}
{%
  set js_commons = [
    'src/utils.js',
    'src/motion.js',
    'src/minigrid.min.js',
    'src/photo.js'
  ]
%}
{% else %}
{%
  set js_commons = [
    'src/utils.js',
    'src/motion.js'
  ]
%}
{% endif %}

{% for common in js_commons %}
  <script src="{{ url_for(theme.js) }}/{{ common }}?v={{ version }}"></script>
{% endfor %}
