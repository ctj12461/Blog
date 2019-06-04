{% if theme.meting.enable %}
    <link href="https://cdn.bootcss.com/aplayer/1.10.1/APlayer.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/aplayer/1.10.1/APlayer.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/meting@2.0.1/dist/APlayer.min.css">
    <script src="https://unpkg.com/meting@2.0.1/dist/APlayer.min.js"></script>
    <!-- require MetingJS -->
    <script src="https://unpkg.com/meting@2.0.1/dist/Meting.min.js"></script>

    <meting-js
      server="{{ theme.meting.server }}"
      type="{{ theme.meting.type }}"
      id="{{ theme.meting.id }}"
      fixed="true"
      autoplay="{{ theme.meting.autoplay }}"
      loop="{{ theme.meting.loop }}"
      order="{{ theme.meting.order }}"
      mutex="true"
      preload="metadata"
      list-max-height="{{ theme.meting.height }}">
    </meting-js>
{% endif %}