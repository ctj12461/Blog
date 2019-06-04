<!DOCTYPE html>
<html lang="{{ connfig.language }}">
  <head>
    {% include '_partial/head.swig' %}
    <title>{% block title %}{% endblock %}</title>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    
  </head>

  <body>
    <div id="page">
      <header id="masthead">
        {%- include '_partial/header.swig' %}
      </header>
      <div id="content">
        {% block content %}{% endblock %}
      </div>

      <footer id="colophon">
        {%- include '_partial/footer.swig' %}
      </footer>

      <div class="back-to-top" id="back-to-top">
        <i class="iconfont icon-up"></i>
      </div>
    </div>
    
    {% include '_script/comments.swig' %}
    {% include '_script/libs.swig' %}
    {% include '_script/theme.swig' %}
    {% include '_script/commons.swig' %}

    {% include '_third-party/mathjax.swig' %}
    {% include '_third-party/metingjs.swig' %}
  </body>
</html>
