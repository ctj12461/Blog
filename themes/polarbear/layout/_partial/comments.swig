{% if page.comments and not is_home() %}
  <div class="comments" id="comments">
    {% if theme.disqus_shortname %}
    <div style="text-align:center;">
        <button class="btn" id="load-disqus" onclick="disqus.load();">加载 Disqus 评论</button>
    </div>
      <div id="disqus_thread">
        <noscript>
          Please enable JavaScript to view the
          <a href="//disqus.com/?ref_noscript">comments powered by Disqus.</a>
        </noscript>
      </div>
    {% elif theme.duoshuo_shortname %}
      <div class="ds-thread" data-thread-key="{{ page.path }}"
           data-title="{{ page.title }}" data-url="{{ page.permalink }}">
      </div>
    {% elif theme.valine.enable %}
      <script src="//cdn1.lncld.net/static/js/3.0.4/av-min.js"></script>
      <script src='//unpkg.com/valine/dist/Valine.min.js'></script>
      <div id="vcomments"></div>
        <script>
            new Valine({
                el: '#vcomments',
                appId: '{{ theme.valine.appid }}',
                appKey: '{{ theme.valine.appkey }}',
                notify: {{ theme.valine.notify }}, 
                verify: {{ theme.valine.verify }}, 
                avatar: '{{ theme.valine.avatar }}', 
                placeholder: '{{ theme.valine.placeholder }}'
            })
        </script>
    {% endif %}
  </div>
{% endif %}
