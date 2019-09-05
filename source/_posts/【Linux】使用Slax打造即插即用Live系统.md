---
title: 【Linux】使用Slax打造即插即用Live系统
comments: true
tags:
  - Linux
  - Slax
  - LiveUSB
categories:
  - Linux
abbrlink: f6866bfc
date: 2019-05-25 16:27:34
mathjax: true
---

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

# 配置

## 启动
> 接下来的操作均在VirtualBox上进行。

将U盘插入电脑，按照你的电脑设置打开启动菜单，选择你的U盘启动。任何可以看到一个巨大的Logo。

![Slax](https://i.loli.net/2019/06/02/5cf369b4ef9df32019.png)

默认情况下，4秒之后会以正常模式启动，即可以保存所有更改。按`Tab`键选择更多的方式启动。
系统将会自动进入`X Window`界面。

![Slax](https://i.loli.net/2019/06/02/5cf36bf8428c811487.png)

## 包管理器配置

### 更换镜像源
```bash
nano /etc/apt/sources.list
```
打开/etc/apt/sources.list，替换为以下内容：
```
deb http://mirrors.163.com/debian/ stretch main non-free contrib
deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib
deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib
deb-src http://mirrors.163.com/debian/ stretch main non-free contrib
deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib
deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib
deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib
deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib
```
然后运行以下命令：
```bash
apt update
apt upgrade
```

### 安装软件包
比如要安装`git`，就输入以下命令：
```bash
apt install git
```

## 用户管理
`Slax`安装完成后默认是以`root`登录，具有最高权限，不适合平时的使用。我们需要创建普通用户，并设置合适的权限。
更改`root`密码：
```bash
passwd
```
创建用户：
```bash
useradd -d /home/yourname -s bash -p yourpassword yourname
# or
useradd -D -p yourpassword yourname
```
`Slax`默认没有安装`sudo`，通过以下命令安装：
```bash
apt install sudo
```