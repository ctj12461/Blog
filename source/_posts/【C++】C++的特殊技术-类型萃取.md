---
title: 【C++】C++的特殊技术：类型萃取
comments: true
tags:
 - C++
 - 类型萃取
 - 模板元编程
categories:
 - C++
abbrlink: '43e11492'
date: 2019-07-19 04:31:49
mathjax: true
---

`类型萃取`是通过`模板元编程`实现的一种`C++`特殊技术，使得程序在编译期完成类型的判别与操作。  
`类型萃取`因为其强大的功能，在`C++`中有着广泛应用。  
<!-- more -->
一个例子：

    #include <iostream>
    using namespace std;
    
    template<typename T1, typename T2>
    struct IsSame
    {
        static const bool Value = false;
    };
    
    template<typename T>
    struct IsSame<T,T>
    {
        static const bool Value = true;
    };
    
    int main(){
        if (IsSame<int, int>::Value) {
            cout << "Same" << endl;
        } else {
            cout << "Different" << endl;
        }
        return 0;
    }

很显然，程序输出了`Same`。  
其中，结构体`IsSame`使用了`模板元编程`，实现在编译期的类型判别。

# 类型萃取的通用实现
由于类型信息会在运行期丢失，所以，只有在编译期使用模板，才能保存类型信息。
接着，使用模板特化或者`SFINAE`等，实现编译期的条件控制。

## 类型信息保存
这是类型萃取最基础的部分，后面的各种的操作都基于类型信息保存。

    #include <iostream>
    using namespace std;
    
    template<typename T>
    struct GetType
    {
        typedef T Type;
    };
    
    int main(){
        int a;
        typedef GetType<int>::Type ResultType;
        ResultType b;
        cin >> a >> b;
        cout << a + b << endl;
    }
