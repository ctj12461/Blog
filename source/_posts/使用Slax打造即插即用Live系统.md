---
title: 使用Slax打造即插即用Live系统
comments: true
tags:
  - Linux
  - Slax
  - LiveUSB
categories:
  - Linux
abbrlink: f6866bfc
date: 2019-05-25 16:27:34
---

# 前言
随着`Linux`的不断流行，越来越多的人开始尝试`Linux`，同时，也有人一不小心就玩坏了系统，无力回天了。
所以，很有必要找到一个安全的方法来使用`Linux`；`Live`系统就是一个不错的选择。
本文就使用`Slax`打造一个能够即插即用，且完整的系统（可以保存更改，支持`apt`）。

<!-- more -->

# Slax简介
> Slax is a modern, portable, small and fast Linux operating system with modular approach and outstanding design. It runs directly from your USB flash drive without installing, so you can carry it everywhere you go in your pocket. Despite its small size, Slax provides nice graphical user interface and wise selection of pre-installed programs, such as a Web browser, Terminal, and more. 

`Slax`是一个`Live`系统，轻量级，安装简单，除了可以安装在`CD`上，还可以安装在U盘，做到保存更改。
最新的`Slax`改为基于`Debian`，因此，可以使用`apt`，安装软件更加方便。

# 准备工作
需要准备以下内容的硬件或软件：
1. USB3.0、至少4GB的U盘一个
2. Slax 9.9.0
3. 一个能够打开`iso`文件的软件。

如果你的系统支持直接打开`iso`文件，那么就不需要第三项。

# 安装过程

## 下载
点击这个[链接](https://www.slax.org/)，到达`Slax`的官网，拉到页面底部，可以看到`x86`与`x64`的下载地址，点击下载即可。

## 安装
将`iso`中的内容**复制**到U盘里，`Windows`下可以使用`UltraISO`，**使用提取，而不是写入硬盘映像**。
`Windows10`可以直接打开`iso`文件了，直接复制到U盘。
`Linux`可以使用`dd`命令。

## 添加引导
切换到U盘的`./slax/boot/`目录下，运行`bootinst.sh`或者`bootinst.bat`安装引导。
至此，完成安装`Slax`。
