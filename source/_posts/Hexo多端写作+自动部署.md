---
title: Hexo多端写作+自动部署
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
但我不想在站点根目录（`hexo init`的那个）下使用`git init`，打乱目录结构。  
在这里，我使用了一个Shell脚本，用来在博客根目录外创建文件夹，拷贝所有的源文件和其他必要的东西。
```bash
#!/bin/bash
# deploy.sh
git init ../BlogSource
cp -r $0 .travis.yml .gitignore themes source package.json _config.yml ../BlogSource
cd ../BlogSource
git add .
git commit -m "Commit at `date`"
git remote add origin git@github.com:yourname/yourrepo
git checkout -b source
#git pull --allow origin source
git push -f origin source
cd ..
rm -rf BlogSource
```
> 记住更改GitHub用户名和
不要告诉我你的电脑不能运行`Shell Script`！你的`Git Bash`就可以。  
这个`deploy.sh`首先在外部创建文件夹，再复制以下文件：
- $0：该脚本本身
- .travis.yml：后面会介绍到
- .gitignore：省略的文件
- themes：主题
- source：源文件
- package.json：需要使用的包
- config.yml：站点配置文件

如果想要保存历史，就把注释掉的那个`git pull`恢复了，去掉`-f`。

## 同步博客
同步博客的源文件也是使用`git`。  
以后在不同的电脑上只要使用以下命令同步仓库：
```bash
git clone git@github.com:yourname/yourepo -b source blog
```
或者：
```bash
git pull origin source
```
写好了就运行`deploy.sh`，不管是在原先博客根目录，还是`git clone`的，都适用。

# 自动部署
使用自动部署，看起来很高大上，其实就是自动地把source分支上的源文件生成为静态网页，并推送到master分支。这就要借助`CI`了。（即`持续集成`)

> 持续集成是一种软件开发实践，即团队开发成员经常集成他们的工作，通常每个成员每天至少集成一次，也就意味着每天可能会发生多次集成。每次集成都通过自动化的构建（包括编译，发布，自动化测试）来验证，从而尽早地发现集成错误。

我们就在我们的博客仓库下使用`CI`，让`CI`服务器帮我们部署。  
这里，我使用`Travis CI`，完成自动构建并部署。  

> Travis CI 是目前新兴的开源持续集成构建项目，它与jenkins，GO的很明显的特别在于采用yaml格式，简洁清新独树一帜。

## Travis CI配置
### 添加仓库
首先登录`Travis CI`[网站](https://travis-ci.com)，点击那个绿色的`Sign in with GitHub`，使用`GitHub`登录，之后`Travis CI`的账号会与`GitHub`绑定在一起。
在GitHub那里确认的时候把需要管理的仓库打上√。  
![Travis CI](https://i.loli.net/2019/04/20/5cbaebe3a817e.png)
如果没有打√，那就点击左边队列上面的加号，再点击`Manage repositories on GitHub`，进入`GitHub`的设置节面。  
![Travis CI](https://i.loli.net/2019/04/20/5cbaef0534b95.png)
选择`Only select repositories`，再下面的下拉框中选择仓库，最后点击`Approve and install`。  
![Travis CI](https://i.loli.net/2019/04/20/5cbaf02a24dc9.png)
这样就完成了添加仓库的配置。

### 添加Personal Access Tokens
> `Personal Access Tokens`是一种访问的便捷方式，不仅在GitHub上有使用，其他平台也有类似的实现，比如第三方登录。

再次进入GitHub，进入个人`Settings -> Developers settings -> Personal access tokens`，创建一个新的`Personal Access Tokens`。  
对于`Personal access tokens`的权限，除了删除仓库，其他都选中。最后生成了一个`Personal Access Tokens`，要记得保存，刷新后就会消失。  
切换会`Travis CI`，点击仓库的`Settings`，在`Environment Variables`添加环境变量，把刚刚获得的`Personal Access Tokens`填入`Value`，`Name`命名为`GITHUB_TOKEN`，确认。  
![Personal Access Tokens](https://i.loli.net/2019/04/20/5cbaf47324dd6.png)
顺便可以像我一样填入名字和Email，方便后面使用。  
至此，`Travis CI`上的配置全都完成，只剩下本地的配置了。

## 编写.travis.yml
包括`Travis CI`在内的所有`CI`服务，都不能在没有任何的帮助下完成，需要我们提供一个配置文件。
因为我们使用`Travis CI`，所以就要提供一个文件——.travis.yml放在根目录。
首先上配置：
```yaml
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
    - git commit -am "Automatic Construction :$(date '+%Y-%m-%d %H:%M:%S' -d '+8 hour')" # 零时区，+8小时
    - git push origin master

branches:
    only:
        - source # 只监听source分支的改动，否则之前的部署将会再次触发一个构建

env:
    global:
        - GH_REF: "https://${USER_NAME}:${GITHUB_TOKEN}@github.com/${USER_NAME}/${USER_NAME}.github.io.git" 
```
如果你有像我一样添加了`USER_NAME`和`USER_EMAIL`这两个字段，基本上就可以直接`Copy-Paste`了。

## 测试
### PC端
当你运行了之前的`deploy.sh`，就可以看到`Travis CI`触发了一个集成构建，`Running`那里就显示有一个任务，打开那个任务，你不仅可以查看状态，还可以看到输出的结果。  
![Automatic Construction](https://i.loli.net/2019/04/20/5cbb091d739e3.png)
正在构建的任务显示为黄色，构建成功的为绿色，失败的为红色。  
`Travis CI`会为你保存每一次的构建的`Configure`和`Log`。
![Automatic Construction](https://i.loli.net/2019/04/20/5cbb0b1586f6d.png)

构建成功了！这下，你就可以在你的博客上查看结果了。

### 移动端
说起来你可能不信，手机也可以更新`Hexo`博客了；但事实上手机确实可以，甚至更加轻松。  
你可以选择登录`GitHub`，点开网页编辑，但这是不必要的。现在移动端已经有了`GitHub`的客户端，不仅可以查看`Repositories`,`Commits`,`Issues`,`Pull requests`，还可以`Edit`，`Explore`等等等等各种功能，直接在客户端编辑，提交，`Travis CI`就帮你自动构建了。

# 总结
在`Git`、`GitHub`、`Travis CI`的支持下，`Hexo`做到了多端写作+部署，能够真正不关注任何平台，全身心投入写作，甚至是在移动端，只要能提交`Commit`就可以。
这也为Hexo接入其他平台，进一步提升写作体验打下基础。（如使用其他写作平台的Webhook+serverless）  
现在，`Hexo`不再是一个无法自动化的平台了。
