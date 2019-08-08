---
title: C++的特殊技术：CRTP
comments: true
tags:
  - C++
  - Template
  - CRTP
categories:
  - C++
abbrlink: 179eb0e9
date: 2019-04-25 18:45:00
mathjax: true
---

`CRTP`也叫做`奇特重现模板模式`，是一种特殊的模板技术和使用方式，其概念为：
> 当存在一个模板基类时，其派生类将自身作为基类的模板参数。

<!-- more -->

比如像这样子：
```cpp
template<typename T>
class Base
{};

template<typename T>
class Derived : public Base<Derived<T>>
{};
```
虽然`CRTP`的用法看起来有点奇怪，“怎么能把一个对于基类未知的类型传给基类呢”，但它却是可以，因为这是模板。在这段代码里，我们传递给`Base`类的是一个类型，而不是数据，只要不在基类创建`T`，就不会出现类自我包含的问题。我们一般只在基类中写一些与派生类有关的操作，让派生类继承，通过实现基类中有关的操作，而获得一些功能。

# 实例
接下来我们就通过几个例子来理解`CRTP`。
## IComparable<T>
我们常常在`Java`和`C#`中看到比较类，这个例子就是`C++`中的比较类`IComparable<T>`，但是，它的功能比`Java`和`C#`的更加强大。

```cpp
#include<iostream>
using namespace std;

template<typename T>
class IComparable
{
public:
    bool less(const IComparable<T>& b) const {
        return this->lessImpl(b);
    }
    bool greater(const IComparable<T>& b) const {
        return b.less(*this);
    }
    bool notLess(const IComparable<T>& b) const {
        return !this->less(b);
    }
    bool notGreater(const IComparable<T>& b) const {
        return !this->greater(b);
    }
    bool equal(const IComparable<T>& b) const {
        return !this->less(b) && !this->greater(b);
    }
    bool notEqual(const IComparable<T>& b) const {
        return !this->equal(b);
    }
private:
    bool lessImpl(const IComparable<T>& b) const {
        return true;
    }
}; // Need Derived to override lessImpl().

class A : public IComparable<A>
{
public:
    A(int num):N(num){}
    bool lessImpl(const A& b){
        return N < b.N;
    }
private:
    int N;
};

class B : public IComparable<B>
{
public:
    B(int num1, int num2):N1(num1), N2(num2){}
    bool lessImpl(const B& b){
        return N1 < b.N1 || N2 < b.N2;
    }
private:
    int N1, N2;
};

int main(){
    //cout << alphabeta;
    A a(5), b(10);
    cout << a.less(b) << endl; // OK
    B c(5, 10), d(5, 0);
    cout << c.greater(d) <<endl; // OK
    
}
```
这段代码里，我首先定义了一个接口`IComparable<T>`，然后定义了一系列的比较函数，它们都直接或间接地使用了`lessImpl()`方法，而定义了派生类`A`和`B`之后，在类中覆盖`lessImpl()`
方法，并使用`CRTP`技术，获得`IComparable<T>`所带有的比较函数，这样，`A`和`B`就可以进行比较操作了。

对于这个例子，可以发现：生成这些操作完全是在编译期完成的，在运行期只是普通的比较，且没有**任何**空间开销，虽然`IComparable<T>`是空类，或者说是接口，但它是被继承的可以借助`EBO`,
优化空间，变为0空间开销。派生类只要写`lessImpl()`方法，就可以获得所有比较功能，这也是`CRTP`最显著的特点：
> 基类能够在不直接知道派生类类型的情况下，为派生类提供功能，且无任何的运行时开销。

## Counter<T>
这个例子是使用`CRTP`做一个简单的对象计数器`Counter<T>`。
```cpp
#include<iostream>
using namespace std;

template<typename T>
class Counter
{
public:
    static size_t get(){
        return Count;   
    }
    Counter(){
        add(1);
    }
    Counter(const Counter& other){
        add(1);
    }
    ~Counter(){
        add(-1);
    }
private:
    static int Count;
    static void add(int n){
        Count += n;
    }
};

template<typename T>
int Counter<T>::Count = 0;

class A : public Counter<A>
{};

class B : public Counter<B>
{};

int main(){
    // Counter<A>::add(1);  [Error] 'static void Counter<T>::add(int) [with T = A]' is private
    A a1;
    cout << "A : " << Counter<A>::get() << endl;
    {
        B b1;
        cout << "B : " << Counter<B>::get() << endl;
        {
            A a2;
            cout << "A : " << Counter<A>::get() << endl;
        }
        cout << "A : " << Counter<A>::get() << endl;
    }
    cout << "B : " << Counter<B>::get() << endl;
}
```

对象构造肯定会调用构造函数，析构时也会调用析构函数，我们只要在构造函数和析构函数中添加计数的代码，再让其他类继承。
在继承`Counter<T>`时，`Counter<T>`的模板参数就是派生类，同时就会实例化类模板，创建一个特定为派生类提供的计数器。
构造函数将会在派生类被构造时隐式调用，从而实现了计数。

# 应用
我们看`C++`标准库中，最为经典的就是`enable_shared_from_this<T>`。
为了实现从类中传出一个安全的`shared_ptr<T>`来包装`this`指针，并且只能对现有的类做极小的修改，对实际使用没有影响。
使用`CRTP`是最好的选择。通过继承`enable_shared_from_this<T>`，它可以自动生成派生类的传出`this`的方法。
> 来自[cppreference.com](https://zh.cppreference.com/w/cpp/memory/enable_shared_from_this)的示例

```cpp
#include <memory>
#include <iostream>
 
struct Good: std::enable_shared_from_this<Good> // 注意：继承
{
    std::shared_ptr<Good> getptr() {
        return shared_from_this();
    }
};
 
struct Bad
{
    // 错误写法：用不安全的表达式试图获得 this 的 shared_ptr 对象
    std::shared_ptr<Bad> getptr() {
        return std::shared_ptr<Bad>(this);
    }
    ~Bad() { std::cout << "Bad::~Bad() called\n"; }
};
 
int main()
{
    // 正确的示例：两个 shared_ptr 对象将会共享同一对象
    std::shared_ptr<Good> gp1 = std::make_shared<Good>();
    std::shared_ptr<Good> gp2 = gp1->getptr();
    std::cout << "gp2.use_count() = " << gp2.use_count() << '\n';
 
    // 错误的使用示例：调用 shared_from_this 但其没有被 std::shared_ptr 占有
    try {
        Good not_so_good;
        std::shared_ptr<Good> gp1 = not_so_good.getptr();
    } catch(std::bad_weak_ptr& e) {
        // C++17 前为未定义行为； C++17 起抛出 std::bad_weak_ptr 异常
        std::cout << e.what() << '\n';    
    }
 
    // 错误的示例，每个 shared_ptr 都认为自己是对象仅有的所有者
    std::shared_ptr<Bad> bp1 = std::make_shared<Bad>();
    std::shared_ptr<Bad> bp2 = bp1->getptr();
    std::cout << "bp2.use_count() = " << bp2.use_count() << '\n';
} // UB ： Bad 对象将会被删除两次
```

还有就是`C++20`中的`view_interface<T>`，其派生类可以变成一个`范围`，还可以使用各种`范围适配器`。
> 由于`ranges`库还没有完全完成，暂无示例。

# CRTP的意义
有人喜欢称`CRTP`为静态多态，我认为这其实是**不正确的**。我们把`CRTP`和`Interface`做个比较，`CRTP`是通过模板参数获得派生类的类型，并为每个派生类都生成了一个基类，
每个派生类继承`CRTP`类都要将自身的类型传给基类，就发生了模板实例化，本质上并没有一个基类（接口）对多个派生类（实现）。

而对于`Interface`，`Interface`本身不知道派生类的类型，但是它有固定的方法规定，参数个数，类型，返回值，都是确定的，并且每个方法都是通过按照`vtable`调用的，都是指针。
这样就能真正的做到一个基类（接口）对多个派生类（实现）。

我习惯将`CRTP`作为快速扩展类的手段，基类可以获得到派生类的类型，提供各种操作，比普通的继承更加灵活。但`CRTP`基类并不会单独使用，只是作为一个模板的功能。
