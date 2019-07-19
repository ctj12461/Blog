---
title: C++的特殊技术：类型萃取
comments: true
tags:
  - C++
  - 类型萃取
  - 模板元编程
categories:
  - C++
date: 2019-07-19T04:31:49.682Z
---
`类型萃取`是通过`模板元编程`实现的一种`C++`特殊技术，使得程序在编译期完成类型的判别与操作。  
`类型萃取`因为其强大的功能，在`C++`中有着广泛应用。  
<!-- more -->
一个例子：
```cpp
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
	if(IsSame<int, int>::Value){
		cout << "Same" << endl;
	}
	return 0;
}
```
