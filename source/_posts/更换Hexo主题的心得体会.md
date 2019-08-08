---
title: 更换Hexo主题的心得体会
comments: true
tags:
  - Hexo
  - Theme
  - Swig
  - Valine
categories:
  - Hexo
abbrlink: a8248088
date: 2019-05-10 14:21:00
mathjax: true
---

由于`NexT`主题加载过慢和太多人使用它，我就想更换一个更加简洁的主题。
所以我就找了一个目前看来最适合我的主题。在这个过程中，让我有了不少的收获。
这篇文章就是帮助你定制你喜爱的主题，并且在更换主题时绕过各种坑。

<!-- more -->

# 挑选主题
挑选一个合适的主题对于网站来说实在是太重要了；好的主题不仅要看上去美观，大方，而且还要有一定的性能要求。

以下是我从[Hexo主题列表](https://hexo.io/themes)中选出的较不错的主题。
## 主题列表
### NexT
`Hexo`使用最多的主题。界面华丽，功能繁多，且配置简单。支持四种风格`Muse`、`Mist`、`Pisces`、`Gemini`。对第三方支持好。但加载速度较慢。

优点：
- 界面美观
- 原生可配置项多
- 第三方支持好

缺点：
- 主题过于臃肿
- 速度慢
- 太多人使用导致网站相似度高，不利于`SEO`

### PolarBear
这个主题就是本博客正在使用的。整个主题分为五类主色调，支持自定义边栏附加组件。原生支持`LiveRe`和`Disqus`评论。

优点：
- 页面简洁美观
- 性能优异
- 轻量级

缺点：
- 原生可配置项较少，不易扩展，对初学者不友好
- 缺少第三方支持

### Amber
类似于`Polar Bear`的设计，但更加丰富（如首页带有轮播图）。由于这个主题是基于`Vue.js`和`Bootstrap`开发的，导致一些功能无法使用，但一般情况下不妨碍它的正常使用。

优点：
- 界面简洁美观
- 可配置性高

缺点：
- 部分功能无法使用

### AD
界面简洁，有较多的功能配置，为移动端做了非常完善的支持，配色丰富。但加载略慢。

优点：
- 界面简洁
- 可配置性高
- 移动端支持好

缺点：
- 加载略慢

### Anatole
左边使用巨大的`Logo`和各种扁平化小图标组成，右边是文章内容，设计独特。但可配置项太少。

优点：
- 界面简洁
- 性能优异

缺点：
- `Logo`影响这个网站的美观程度，如果设计的不符合主题风格，会适得其反。
- 可配置项太少

## 主题对比
主题 | 外观 | 性能 | 易用性 | 支持
:---: | :---: | :---: | :---: | :---:
NexT | 9 | 6 | 9 | 10
PolarBear | 8 | 10 | 7 | 9
Amber | 9 | 8 | 8 | 9
AD | 8 | 7 | 8 | 9
Anatole | 8 | 10 | 7 | 9 

所以，我们得出以下结论：
1. 如果你是一个初学者，不喜欢花太多时间来定制主题，那么你应该选择`NexT`，它是目前使用人数最多的主题，拥有活跃的社区，并且网络上大部分的网站都是根据`NexT`写的，你很容易就可以解决问题。
2. 如果你对性能有极致的追求，那你可以选择`PolarBear`，我相信舍弃一些不必要的东西是值得的。`PolarBear`拥有最简洁的配置，你不会在网站上看到一点无用的浪费，因为它可以没有一点动画效果或者图片。
3. 如果你想要找到美观与高效的平衡点，那么`Amber`最适合你。


# 配置主题
很多人最初开始使用`Hexo`，都会到主题列表查找自己喜欢的主题。但找到一个好看的主题之后，却因为不懂得如何配置使用停住了脚步。所以，很有必要学习如何配置，或者说是定制自己的主题。
> 本节以PolarBear为例。

## Swig语法快速入门

`Swig`是大部分主题采用的模板引擎，用来帮助我们渲染`markdown`或其他页面，最后生成静态页面。
学习模板引擎语法是扩展主题的必经之路，今后几乎所有的操作都需要它。

### 文件

在所有的主题当中，根目录都会有有一个`layout`文件夹，这里面就存放着模板引擎文件。在大部分主题中，都以`.swig`结尾。所有渲染页面的规则与操作都在里面。
事实上，里面的代码都是`HTML`, `JavaScript`和`Swig`语句组成。

### 添加简单的代码

只要在适当位置添加上代码就可以了，以后只要哪个页面按照该文件渲染，就可以在其中找到添加的代码。

### 条件判断
```
{% if ... %}
...
{% elif %}
...
{% else %}
...
{% endif %}
```
在我们的主题当中，一般是根据`YAML`配置文件决定的。比如下面这个：

```
...
{% if config.helloworld %}
    <p>Hello World</p>
{% else %}
    <p>Hello World</p>
{% endif %}
...
```
而`YAML`配置文件就是：
```yaml
helloworld: true
```
### 引入文件
```
{% include ... %}
```
如果你想要使用不同的文件，就可以这么做。但目前我们的扩展一般不会需要用到这个语法。

## 配置Valine
`Valine`是国内一款简洁美观，且速度快的评论系统。无后端，只需要使用一个`LeanCloud`账号即可。
本节就帮助大家为没有评论的`Hexo`主题加上`Valine`。
![Valine](https://i.loli.net/2019/05/18/5ce00464e341674965.png)
> 本节暂不涉及更复杂的配置内容，只是讲解如何安装，更多内容请参阅[Valine官网](https://valine.js.org)

找一找你的主题有没有`comments.swig`等类似的文件，如果有，但是并没有`Valine`，那么，就添加一个`if`的代码块，然后添加`<script>`块。其中，各个配置项都最好写出变量，在主题中写值。比如像这样：
```html
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
      {# Valine configuration #}
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
```
添加上最后一个`elif`块。
> 仅供参考，请根据实际情况判断。

如果没有这样的文件，那就打开`post.swig`之类的文件，在适当位置添加代码。
```html
{% extends "_layout.swig" %}
{% import '_macro/post.swig' as post_template %}

{% block title %} {{ page.title }} - {{ config.title }} {% endblock %}

{% block content %}
    <div id="primary">
        {{ post_template.render(page) }}
    </div>
{% endblock %}

{% if theme.valine.enable %}      
    {# Valine configuration #}      
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
```
> 仅供参考，请根据实际情况判断。

在主题配置文件里添加以下代码：
```yaml
# Valine
valine:
  enable: true
  appid: XRJUe95OIGJnGwd9p3kG19BA-gzGzoHsz
  appkey: qWTfqJmDG2X1cX2EAvHKdkOY
  notify: false
  verify: false
  placeholder: Just go go
  avatar: mm
```
`appid`和`appkey`是使用`LeanCloud`创建一个应用之后获取的。`placeholder`是还没有输入时默认显示的内容。`avatar`是头像。

## 添加busuanzi计数
找到`footer.swig`，在里面添加这些：
```
{% if theme.busuanzi.enable %} 
    <script async src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
{% endif %}
{% if theme.busuanzi.enable %}        
    {{ theme.busuanzi.pv }}<span id="busuanzi_value_site_pv"></span>&nbsp
    {{ theme.busuanzi.uv }}<span id="busuanzi_value_site_uv"></span>
{% endif %}
```
在主题配置文件里添加：
```
busuanzi:
  enable: true
  pv: "Page View" # 显示pv的内容
  uv: "User View" # 显示uv的内容
```
![busuanzi](https://i.loli.net/2019/05/19/5ce0f322a892132422.png)

## 添加APlayer和MetingJS
`APlayer`是一个功能强大的`H5`音乐播放器，但是由于配置较为复杂，不是那么方便。所以，就有了`MetingJS`这一神器，基于`APlayer`，
能够自动通过链接或者歌曲/歌单的`ID`播放音乐。更多配置请查看该[链接](https://github.com/metowolf/MetingJS)。
![MetingJS](https://i.loli.net/2019/05/25/5ce92fc1a11f273735.png)
打开`_layout.swig`，在其中的`<body>`部分添加以下代码：
```html
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
```
在主题配置文件里添加：
```yaml
meting:
  enable: true
  server: netease
  type: playlist
  id: 2772976450
  autoplay: true
  loop: all
  order: random
  height: 300px
```
这是各个选项的描述，有需要可以自行添加：

| 名称 | 默认值 | 描述 |
|:----|:-------|:----|
|container | document.querySelector('.aplayer') | 播放器容器元素 |
|fixed | false | 开启吸底模式, [详情](https://aplayer.js.org/#/home?id=fixed-mode) |
|mini | false | 开启迷你模式, [详情](https://aplayer.js.org/#/home?id=mini-mode) |
|autoplay | false | 音频自动播放 |
|theme | '#b7daff' | 主题色 |
|loop | 'all' | 音频循环播放, 可选值: 'all', 'one', 'none' |
|order | 'list' | 音频循环顺序, 可选值: 'list', 'random' |
|preload | 'auto' | 预加载，可选值: 'none', 'metadata', 'auto' |
|volume | 0.7 | 默认音量，请注意播放器会记忆用户设置，用户手动设置音量后默认音量即失效 |
|audio | - | 音频信息, 应该是一个对象或对象数组 |
|audio.name | - | 音频名称 |
|audio.artist | - | 音频艺术家 |
|audio.url | - | 音频链接 |
|audio.cover | - | 音频封面 |
|audio.lrc | - | [详情](https://aplayer.js.org/#/home?id=lrc) |
|audio.theme | - | 切换到此音频时的主题色，比上面的 theme 优先级高 |
|audio.type | 'auto' | 可选值: 'auto', 'hls', 'normal' 或其他自定义类型, [详情](https://aplayer.js.org/#/home?id=mse-support) |
|customAudioType | - | 自定义类型，[详情](https://aplayer.js.org/#/home?id=mse-support) |
|mutex | true | 互斥，阻止多个播放器同时播放，当前播放器播放时暂停其他播放器 |
|lrcType | 0 | [详情](https://aplayer.js.org/#/home?id=lrc) |
|listFolded | false | 列表默认折叠 |
|listMaxHeight | - | 列表最大高度 |
|storageName | 'aplayer-setting' | 存储播放器设置的 localStorage key |

# 合理定制主题
上面的这些例子，是为了帮助大家能够自己扩展主题，展现独特之处，但在使用这些方法的同时，也要注意分寸。
你应该已经发现了，上面所介绍的功能，有很多其实被我关闭了。这其实是为博客的综合体验考虑关闭的。

1. 首先是从加载速度来看，加载慢的网页很容易让人失去耐心。据统计，网站的加载速度每慢下1s，就会失去3%的访问量。
   虽然不知道这个统计结果的准确性，但我们都不希望为了一个性能低下的网站而苦苦等待。
   
2. 过多的效果以及组件，如果与主题不协调，就会适得其反，看起来十分不舒服。良好的设计也是影响体验的关键。
3. 不实用，大多数人关注的不是那些华丽的特效，而是真正实用的内容。

但我也不是说它们一无是处，它们也都各有所长，真正的用处只有在特定情况下才会被发现。

经过这次更换主题，确实学到了许多。最重要的是——内容至上。