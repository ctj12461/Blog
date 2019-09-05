---
title: 【工具】生成GitHub上的各种标签
comments: true
tags:
  - GitHub
  - Tools
categories:
  - Tools
abbrlink: b443c1fd
date: 2019-05-01 13:18:40
mathjax: true
---

今天为了给博客网站的`GitHub`仓库添加一些链接，但又想有一点与众不同。看到其他项目都有许多标签，就考虑能不能自己也做一个这样的东西出来。

<!-- more -->

# 标签的来源
随便点击一个`Star`多的项目，如果`README`有很多标签，除了`build`、`npm`、`chat`这样有平台支持的，查看链接，就可以知道来源了。
在搜索之后，终于找到了网址：
```
https://shields.io/
```

# 生成标签
这个网站专门生成自定义的标签，并且支持静态和动态两种类型，自定义标题和颜色。

其中，最开始的是分类，有各种已经预设好的标签，下面标题写着`Static`的就是我们要的生成器了。
![Generator](https://i.loli.net/2019/05/01/5cc933643e0cc.png)
在`label`和`message`填上相应的文字，选择颜色，点击`Make Badge`，就会跳转到一个生成好的页面，复制地址就可以了。

# 使用标签
如果你有看过我的另外一篇文章[markdown快速入门](https://ctj12461.netlify.com/2019/349b787b.html#图片链接)，就会知道怎么在`markdown`中使用图片链接。这里就只放出效果图了。
![Labels](https://i.loli.net/2019/05/01/5cc9358577447.png)

