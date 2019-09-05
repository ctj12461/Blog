---
title: 【项目】一个好用的OI工具库
comments: true
mathjax: true
tags:
  - C++
  - OI
  - 算法
  - 数据结构
categories:
  - OI
abbrlink: 94407b2b
date: 2019-08-30 08:10:43
---
最近用学习`OI`的空余时间，写了一个有关`OI`的算法与数据结构的工具库。  
首先放出代码仓库：[OI-Utility](https://github.com/ctj12461/OI-Utility)。  
<!-- more -->
# 库的组成
目前以数据结构为主，比如`线段树`、`无旋Treap`等，当然也有像`AC自动机`之类的算法。
以后还会不断加入新的算法/数据结构。
# 代码相关
这个库有点类似`STL`，使用类与模板，可以更好地适用于各种数据类型（但不保证对所以类型都适用，可能出现一些错误）。为了保证安全，全部数据结构均使用静态数组分配或底层使用`STL`实现。由于使用了类体以保证可扩展性，可能效率会降低。

所有的代码都是基于`C++11`，所以对于没有`C++11`的`OJ`,不保证能够正常使用。
# 与我合作
如果你有什么算法或者数据结构想要加入[OI-Utility](https://github.com/ctj12461/OI-Utility)，可以联系我，具体看[About](https://ctj12461.netlify.com/about)，或者`Fork`仓库，向我发一个`Pull request`，欢迎参与[OI-Utility](https://github.com/ctj12461/OI-Utility)的开发。
