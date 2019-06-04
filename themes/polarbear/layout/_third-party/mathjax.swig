{% if theme.mathjax.enable %}
      <script src="{{ theme.mathjax.cdn }}" async></script>
      <script type="text/x-mathjax-config">
        MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
 	  </script>
{% endif %}