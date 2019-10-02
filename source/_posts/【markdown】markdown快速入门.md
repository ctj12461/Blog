---
title: 【markdown】markdown快速入门
tags:
  - markdown
  - Blog
  - 标记语言
categories: markdown
abbrlink: 349b787b
date: 2019-03-30 18:49:17
mathjax: true
---

markdown是一个优雅的标记语言。  
它的语法，能够写出纯文本无法相比的效果。它拥有HTML所以的优点，比起HTML却是无法想象的简单。  
对于你来说，肯定想写出颜值高的页面，却又苦恼与富文本编辑器的操作繁琐，速度缓慢。  
那么，markdown就是你最好的选择。

<!-- more -->

# markdown简介
> markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。
> markdown具有一系列衍生版本，用于扩展markdown的功能（如表格、脚注、内嵌HTML等等），这些功能原初的markdown尚不具备，
> 它们能让Markdown转换成更多的格式，例如LaTeX，Docbook。markdown增强版中较有名的有markdown Extra、MultiMarkdown、 
> Maruku等。这些衍生版本要么基于工具，如Pandoc；要么基于网站，如GitHub和Wikipedia，在语法上基本兼容，但在一些语法和渲染效果上有改动。

*以上内容来自百度百科*   

从上面的介绍我们就可以对markdown有初步的认识了。markdown是一种对HTML简化的一种标记语言，但它易于编写，也很容易阅读，只要一两个字符就能达到HTML的效果。即使有些内容无法写出（比如数学公式），
也有扩展的版本供大家使用。由于其简单性、易用性和灵活性，是它与生俱来的优点。markdown已经在各大平台上，以及各种博客得到广泛应用。  
那markdown难吗？不难，看下面你就知道了。

# markdown语法
## 段落
段落是markdown中最简单的语法。因为它根本就不需要输入声明特殊的东西，直接输入要显示的字符就行了。
```markdown
Passage
```

markdown与HTML一样，想要换行，必须要使用一个标签，否则，多个空格就会被合并成一个空格。但是，markdown没有专用的换行字符，要使用两个空格`  `。

## 标题
也是和HTML一样，markdown有六级标题。这次，markdown给出了标题的语法。对于n级的标题，就用n个`#`来表示，`#`的后面在留个空格，输入标题内容。
```markdown
# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6
```
> 由于为了不影响博客网站中标题的显示，就不演示一二级标题了，可以看上面的。

效果：
### Header 3
#### Header 4
##### Header 5
###### Header 6
注意：`#`之后尽量留空格，在各大平台上，对markdown的支持都不一样，比如在GitHub上，不留空格，就会把`#`当作与后面的标题内容是一部分的，从而变成了段落。想要做到cross-platform，就要注意这个细节。

## 字体
### 粗体
```markdown
**Passage**
```
效果：  
**Passage**  
### 斜体
```markdown
*Passage*
```
效果：  
*Passage*   
### 粗斜体
```markdown
***Passage***
```
效果：  
***Passage***  
### 删除线
```markdown
~~Passage~~
```
效果：  
~~Passage~~  

## 引用
引用是几乎每篇文章里都会有的部分。有些东西已经有了，我们就可以不必再继续make-wheels，使用引用，就可以在不侵犯©的情况下便捷的写作了。（不要滥用引用，否则就会让你的的文章变得没有质量，同时，也要注明出处等必要信息。）  
```markdown
> Reference
```
效果：  
> Reference  

还有一种做法，就是把引用当作注释，或者对话情节来使用，这里就不演示了。  
引用可以多级嵌套，也就是让引用块的左边多一些线。比如下面这个Example：
```markdown
> Reference 1
>> Reference 2
>>> Reference 3
>>>> Reference 4
>>>>> Reference 5
```
效果：  
> Reference 1
>> Reference 2
>>> Reference 3
>>>> Reference 4
>>>>> Reference 5

具体作用我不太清楚，应该是把别的文章里的引用也显示出来，层次更加分明。

## 分割线
分割线可以对一些内容进行逻辑上的划分，同时，会比标题自带的分割线更加明显,大家可以看下面做个比较：
```markdown
### Title
---
```
效果：  
### Title
---
其实分割线不仅仅只能用`---`，还可以用`***`，`----`，`****`，只要是三个及以上个`-`或`*`，都可以达到分割线的效果，大家选一种简单的就行了。

## 图片
图片的语法比起HTML真的是很简洁，看一下它的语法，我想你应该会这么认为的。
```markdown
![Picture](http://uploadbeta.com/api/pictures/random/?key=BingEverydayWallpaperPicture "Picture from Bing")
```
效果：  
![Picture](/images/posts/349b787b-1.png "Picture from Bing")
其中`Picture`这个字段就是图片显示的名称，建议这个名字不要乱取，因为有些人会使用CLI的浏览器，特别是在Linux上时，为了方便，访问简单的网页不一定会用Firefox或者Chrome这样的浏览器，
（具体原因有很多，想要了解请自行体会），CLI浏览器对于图片，就会显示其名称，对用户来说，可以引导阅读。  
中间的链接可以使用绝对路径或者相对路径，只要能用URL表示的就可以填。  
`"Picture from Bing"`这个字段是把鼠标放在这个图片上会出现的东西，相当于是个提示，可加可不加。  

## 链接
### 普通链接
链接的语法与图片的语法十分类似，比图片少了一个`!`。
```markdown
[Link](https://ctj12461.netlify.com "My Blog Website")
```
效果：  
[Link](https://ctj12461.netlify.com "My Blog Website")   
参数的含义与图片类似。  

### 图片链接
链接的标题可以是图片，也就是在原来填标题的位置替换成一个图片的链接，显示出来就是一个图片，点击还可以跳转。
```markdown
[![Link](https://img.shields.io/badge/website-click%20here-orange.svg)](https://ctj12461.netlify.com)
```
效果：  
[![Link](https://img.shields.io/badge/website-click%20here-orange.svg)](https://ctj12461.netlify.com)

### 无标题链接
如果我们不需要为链接添加一个标题，我们可以直接把这个链接写在markdown中。
```markdown
My blog website : https://ctj12461.netlify.com
```
效果：  
My blog website : https://ctj12461.netlify.com   
对于这种无标题链接，其标题就直接显示为URL。

## 代码块
说到代码块，那对像我的这个博客一样的技术博客来说，是十分重要的。各种代码都要放在这里面。（除非你想故意让别人看不懂。）。
代码块分为两种，一种短的，一种长的。我们先来看短的的语法。
### 短代码块
```markdown
`Code Block`
```
效果：  
`Code Block`。
短的代码块适用于短的各种Classes或者Functions，节省空间，又可以起强调作用。  
### 长代码块
```markdown
(```)Language
// Code Block 
// ...
// ...
(```)
```
用三个反引号组成代码块，同时，在第一组反引号后面，还可以加上语言，指定代码块的代码高亮风格（可选）。
## 列表
### 有序列表
只要在列表项前加上序号即可。
```markdown
1. Item 1
2. Item 2
3. Item 3
```
效果：  
1. Item 1
2. Item 2
3. Item 3

### 无序列表
在无序列表项前加上`*`、`+`、`-`即可。
```markdown
* Item 1
+ Item 2
- Item 3
```
效果：  
* Item 1
+ Item 2
- Item 3

### 多级列表
多级列表也叫列表嵌套，每一级列表项之间需要加上缩进，即可达到多级的效果。<br/>
多级列表对有序和无序列表都适用。
```markdown
1. Item 1
	1. Item 1-1
	2. Item 1-2
2. Item 2

* Item 
	1. Item 1
	2. Item 2

```
效果：  
1. Item 1
	1. Item 1-1
	2. Item 1-2
2. Item 2

* Item 
	1. Item 1
	2. Item 2

## 表格
表格并没有想象中的那么难，只需要注意以下几点。

### 基本语法
markdown表格分为三个部分：标题、格式控制、表格项。我们先讲标题和表格项。<br>
markdown的表格只支持横向排列标题，不支持纵向。标题直接用`|`分开。在标题与表格项之间，添加`-----`。  
同样的，表格项之间也是像分割标题一样，使用`|`。
```markdown
Header 1 | Header 2 | Header 3
-----|-----|-----
Item 1-1 | Item 1-2 | Item 1-3
Item 2-1 | Item 2-2 | Item 2-3
```
效果：  

Header 1 | Header 2 | Header 3
-----|-----|-----
Item 1-1 | Item 1-2 | Item 1-3
Item 2-1 | Item 2-2 | Item 2-3

默认情况下，标题和表格项居左呈现。

### 格式控制
`-----`就是控制格式要修改的。
1. `-----` 默认
2. `:----` 居左
3. `:---:` 居中
4. `----:` 居右  

```markdown
Header 1 | Header 2 | Header 3
-----|-----|-----
Item 1-1 | Item 1-2 | Item 1-3
Item 2-1 | Item 2-2 | Item 2-3
```
效果：  

Header 1 | Header 2 | Header 3
:----|:---:|----:
Item 1-1 | Item 1-2 | Item 1-3
Item 2-1 | Item 2-2 | Item 2-3

## 流程图
使用流程图，要写一个专用的代码块，放在其中的，都会被渲染成流程图。
> 由于博客的问题，我没办法直接写出语法，只能用简单用语言描述一下了。

与代码块类似，在语言的位置添加上`flow`。  
画流程图其实就像面向过程的程序设计，分为顺序、分支、循环。接下来就从这三个方面讨论。
### 顺序流程图
顺序流程图就是一个Start和一个End，中间在加上若干个Operations。我们把它们看作一个个步骤。步骤的使用要先定义，然后连接。
定义语法：
```markdown
Step=>Type: Title
```
连接语法：
```markdown
Step1->Step2
```
示例：
```markdown
S=>start: Start
O1=>operation: Operation 1
O2=>operation: Operation 2
E=>end: End
S->O1->O2->E
```
> 自行加上框架

效果：  
```flow
S=>start: Start
O1=>operation: Operation 1
O2=>operation: Operation 2
E=>end: End

S->O1->O2->E
```

### 分支语法
分支语法运用到了新的类型`cond`。
分支语法：
```markdown
Cond=>condition: Title
Cond(yes,[pos])->Step1
Cond(no,[pos])->Step2

```
`[pos]`为`left`或`right`，可选。  

顺便介绍一下子过程类型和输入输出类型。
子过程语法：
```markdown
S=>subroutine: Title
O->S([pos])
```
`[pos]`为`left`或`right`，可选。<br/>
输入输出语法：
```markdown
IO=>inputoutput: Title
O->IO
```
示例：
```flow
S=>start: Start
IO=>inputoutput: Input
O1=>operation: Operation 1
O2=>operation: Operation 2
C=>condition: Yes or No
E=>end: End
R=>subroutine: Other
S->O1->IO->O2->C
C(yes)->E
C(no)->R
```

### 循环语法
循环的语法其实没有什么特殊之处，就是相互连接而已。一般配合分支语法使用。
```flow
S=>start: Start
O1=>operation: Operation 1
O2=>operation: Operation 2
S->O1->O2
O2->O1
```

### 流程图实战
画一个程序设计的过程。
```markdown
Start=>start: Porject Starts
Design=>operation: Design
Dev=>inputoutput: Develop
Comp=>operation: Compile
CondComp=>condition: Successed or Failed?
Debug=>operation: Debug
CondDebug=>condition: Successed or Failed?
Subm=>operation: Submit
Main=>operation: Maintain
CondUse=>condition: Useable?
Disc=>operation: Discard
End=>end: Project Ends

Start->Design->Dev->Comp->CondComp
CondComp(yes)->Debug
CondComp(no)->Dev
Debug->CondDebug
CondDebug(yes)->Subm
CondDebug(no,right)->Dev
Subm->Main->CondUse
CondUse(yes,right)->Design
CondUse(no)->Disc
Disc->End
```
效果：  
```flow
Start=>start: Porject Starts
Design=>operation: Design
Dev=>inputoutput: Develop
Comp=>operation: Compile
CondComp=>condition: Successed or Failed?
Debug=>operation: Debug
CondDebug=>condition: Successed or Failed?
Subm=>operation: Submit
Main=>operation: Maintain
CondUse=>condition: Useable?
Disc=>operation: Discard
End=>end: Project Ends

Start->Design->Dev->Comp->CondComp
CondComp(yes)->Debug
CondComp(no)->Dev
Debug->CondDebug
CondDebug(yes)->Subm
CondDebug(no,right)->Dev
Subm->Main->CondUse
CondUse(yes,right)->Design
CondUse(no)->Disc
Disc->End
```
# 一些需要注意的地方
## 语法的传染性
markdown的很多语法都具有传染性，如果不显式分开，就不会达到想要的效果。
比如列表、引用，不属于这些的内容如果想要分开，就要加上空行。
在编写时，要养成在这些后面加上空行的习惯。

## 加上空格
标题和列表项之前一定要加上空格，对于某些平台，不加空格，都不会给你渲染markdown文本。想要在多平台上发布的童鞋要注意了。

# 结束语
markdown诞生至今已有十几年了，不断地发展，广泛地被使用。现在，是时候让markdown来改变写作方式了！
