---
title: 【Hexo】Hexo多端写作+自动部署
comments: true
tags:
  - Hexo
  - Blog
  - Travis CI
  - Git
categories:
  - Hexo
abbrlink: 988a40dc
date: 2019-04-14 17:13:50
mathjax: true
---

`Hexo`是一个优秀的静态Blog生成器，有各种各样的主题和插件，扩展性强，使用简单。再加上`GitHub Pages`，那就完美了。
<!-- more -->

# Hexo的蛋疼之处
大家肯定都想直接修改源文件，就能够立刻生效，甚至是在移动端，不受任何环境影响，
但是`Hexo`不能随时随地更新博客，因为`Hexo`是生成静态网页，没有后台管理，就牺牲了写作的灵活性。  
那这要怎么解决呢？这篇文章就是你的解决方案。


# 多端写作
既然Hexo不能原生支持多端使用源文件并同步，那就要借助第三方工具了。
但是要用哪种工具呢？当然是`Git`啦！这样，就可以把源文件发布到`GitHub`上，还可以进行版本控制，一举两得！  

> 同步了源文件，也要记得`hexo d`。

## 复制源文件
我们既然想到了使用`Git`，那就要使用不同分支，在`GitHub`的仓库上分开保存源文件和生成的静态网页。  
首先，我们要在站点根目录初始化仓库。

    git init
    mkdir script
    cd script

在`script`目录下，创建`sync.sh`，用来同步。

    #!/bin/bash
    # sync.sh
    
    cd ..
    git add .
    git commit -m "Commit at `date`"
    git pull  --allow origin source
    git push origin source

## 同步博客
同步博客的源文件也是使用`git`。  
以后在不同的电脑上只要使用以下命令克隆仓库：

    git clone git@github.com:yourname/yourepo -b source blog

或者：

    cd script && ./sync.sh

# 自动部署
使用自动部署，看起来很高大上，其实就是自动地把source分支上的源文件生成为静态网页，并推送到master分支。这就要借助`CI`了。（即`持续集成`)

> 持续集成是一种软件开发实践，即团队开发成员经常集成他们的工作，通常每个成员每天至少集成一次，也就意味着每天可能会发生多次集成。每次集成都通过自动化的构建（包括编译，发布，自动化测试）来验证，从而尽早地发现集成错误。

我们就在我们的博客仓库下使用`CI`，让`CI`服务器帮我们部署。  
这里介绍`Travis CI`和`Netlify`，完成自动构建并部署。  
> 我更推荐使用`Netlify`，配置简单，并且它不会拒绝百度爬虫，功能也比`GitHub Pages`多。

## 使用Travis CI
### 添加仓库
首先登录`Travis CI`[网站](https://travis-ci.com)，点击那个绿色的`Sign in with GitHub`，使用`GitHub`登录，之后`Travis CI`的账号会与`GitHub`绑定在一起。
在GitHub那里确认的时候把需要管理的仓库打上√。  
![Travis CI](/images/posts/988a40dc-1.png)
如果没有打√，那就点击左边队列上面的加号，再点击`Manage repositories on GitHub`，进入`GitHub`的设置节面。  
![Travis CI](/images/posts/988a40dc-2.png)
选择`Only select repositories`，再下面的下拉框中选择仓库，最后点击`Approve and install`。  
![Travis CI](/images/posts/988a40dc-3.png)
这样就完成了添加仓库的配置。

### 添加Personal Access Tokens
> `Personal Access Tokens`是一种访问的便捷方式，不仅在GitHub上有使用，其他平台也有类似的实现，比如第三方登录。

再次进入GitHub，进入个人`Settings -> Developers settings -> Personal access tokens`，创建一个新的`Personal Access Tokens`。  
对于`Personal access tokens`的权限，除了删除仓库，其他都选中。最后生成了一个`Personal Access Tokens`，要记得保存，刷新后就会消失。  
切换会`Travis CI`，点击仓库的`Settings`，在`Environment Variables`添加环境变量，把刚刚获得的`Personal Access Tokens`填入`Value`，`Name`命名为`GITHUB_TOKEN`，确认。  
![Personal Access Tokens](/images/posts/988a40dc-4.png)
顺便可以像我一样填入名字和Email，方便后面使用。  
至此，`Travis CI`上的配置全都完成，只剩下本地的配置了。

### 编写.travis.yml
包括`Travis CI`在内的所有`CI`服务，都不能在没有任何的帮助下完成，需要我们提供一个配置文件。
因为我们使用`Travis CI`，所以就要提供一个文件——.travis.yml放在根目录。
首先上配置：

    language: node_js # Hexo基于nodejs
    
    node_js: stable
    
    cache: # 使用缓存，加快构建速度
        apt: true
        directories:
            - node_modules 
    
    before_install:
        - npm install hexo-cli -g # 安装Hexo
    
    install:
        - npm install # 安装所有package.json中的包
    
    script: # 构建
        - hexo clean 
        - hexo g
    
    after_script: # 部署
        - git init pub_web
        - cd pub_web
        - git remote add origin ${GH_REF}
        - git pull origin master --allow
        - cp -rf ../public/* . 
        - git config user.name "${USER_NAME}"
        - git config user.email "${USER_EMAIL}"
        - git add .
        - git commit -am "Automatic Construction :$(date '+%Y-%m-%d %H:%M:%S' -d '+8 hour')"
        - git push origin master
    
    branches:
        only:
            - source # 只监听source分支的改动，否则之前的部署将会再次触发一个构建
    
    env:
        global:
            - GH_REF: "https://${USER_NAME}:${GITHUB_TOKEN}@github.com/${USER_NAME}/${USER_REPO}" 
    
如果你有像我一样添加了`USER_NAME`、`USER_REPO`和`USER_EMAIL`这三个字段，基本上就可以直接复制粘贴了。

### 测试
使用之前的脚本推送代码，`Travis CI`会自动构建并部署，查看网站检查即可。

## 使用Netlify
### 添加仓库
在[Netlify](https://netlify.com)中，使用`GitHub`登录即可。点击`New site from Git`，选择`GitHub`授权，选择仓库。
在第三步时，在`Branch to deploy`中选择`source`(根据源代码的分支选择），在`Build command`中填入`hexo g`的命令，在`Publish directory`中填入`public/`。最后点击`Deploy site`。 
![Netlify](imapes/posts/988a40dc-5.png)
现在，`Netlify`就添加了站点，并会开始第一次构建。

### 其他配置
点击菜单上的`Setting`;  
![Setting](images/posts/988a40dc-6.png)  
再点击`Change site name`，可以为自己的站点选择一个二级域名，只要不重复，顺便选择一个都可以。
![Name](images/posts/988a40dc-7.png)

### 测试
和`Travis CI`一样测试即可。

