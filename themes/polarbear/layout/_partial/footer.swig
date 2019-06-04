{% if theme.busuanzi.enable %} 
    <script async src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
{% endif %}

{% if theme.automatic_deploy_links %}
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
{% endif %}

<span class="copyright-year">
    {% set current = date(Date.now(), "YYYY") %}
        &copy;
    {% if theme.since and theme.since != current %}
        {{ theme.since }} -
    {% endif %}
    {{ current }}
    
    <span class="footer-author">{{ config.author }}.</span>
    {% if theme.busuanzi.enable %}        
        {{ theme.busuanzi.pv }}<span id="busuanzi_value_site_pv"></span>&nbsp
        {{ theme.busuanzi.uv }}<span id="busuanzi_value_site_uv"></span>
    {% endif %}
</span>
