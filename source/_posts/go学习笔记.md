---
title: go学习笔记
author: zhangxin
tags:
  - private
  - go
date: 2024-09-27 17:00:03
categories: go
---

#### fmt

- Print

  将内容输出到系统的标准输入输出,

  ```go
  func main() {
  	fmt.Print("im you father. ")     // 只是单独的输出字符串
  	name := "father"
  	fmt.Printf("Im you: %s\n", name) // 格式化输出字符串
  	fmt.Println("单独显示一行")		 // 输出字符串之后会自动添加一个换行符
  	fmt.Println("单独显示一行")
  }
  //输出 
  im you father. Im you: father
  单独显示一行
  单独显示一行
  ```

- Fprint

  将内容输出到一个io.Writer接口类型的变量w中, 通常使用这个函数往文件中写入内容

  ```go
  func main() {
  	fmt.Fprint(os.Stdout, "向标准输出中写入内容")
  	fileObj, err := os.OpenFile("./xx.txt", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
  	if err != nil {
  		fmt.Println("打开文件出错，err:", err)
  		return
  	}
  	name := "枯藤"
  	// 向打开的文件句柄中写入内容
  	fmt.Fprintf(fileObj, "往文件中写如信息：%s", name)
  }
  ```

- Sprint

  会把传入的数据生成并返回一个字符串

  ```go
  func main() {
  	s1 := fmt.Sprint("枯藤")
  	name := "枯藤"
  	age := 18
  	s2 := fmt.Sprintf("name:%s,age:%d", name, age)
  	s3 := fmt.Sprintln("枯藤", "sfsd")
  	fmt.Println(s1, s2, s3)
  }
  
  ```

- Errorf

  生成格式化字符串并返回一个包含该字符串的错误

  ```go
  err := fmt.Errorf("这是一个错误")
  ```



#### 格式化占位符

![image-20240929162503018](https://raw.githubusercontent.com/zxinyolo/images/main/image-20240929162503018.png)

![image-20240929162531846](https://raw.githubusercontent.com/zxinyolo/images/main/202410081513725.png)

![image-20240929162603932](https://raw.githubusercontent.com/zxinyolo/images/main/image-20240929162603932.png)

![image-20240929162623565](https://raw.githubusercontent.com/zxinyolo/images/main/202410081513358.png)

![image-20240929162638978](https://raw.githubusercontent.com/zxinyolo/images/main/image-20240929162638978.png)

![image-20240929162654433](https://raw.githubusercontent.com/zxinyolo/images/main/202410081513971.png)

![image-20240929162720612](https://raw.githubusercontent.com/zxinyolo/images/main/202410081513363.png)



#### 基本类型

![](https://raw.githubusercontent.com/zxinyolo/images/main/202410081518325.png)



#### 字符串

```go
func main() {
	// 字符串连接
	str1 := "hello"
	str2 := "world"
	result := str1 + "," + str2
	fmt.Println(result) //hello,world

	// 字符串切片
	str := "golang"
	fmt.Println(str[2:4]) //la

	// 字符串查找
	str3 := "hello, go"
	found := strings.Contains(str3, "go")
	fmt.Println(found) // true
	position := strings.Index(str3, "go")
	fmt.Println(position) // 7

	// 字符串比较
	str4 := "apple"
	str5 := "banana"

	fmt.Println(str4 == str5) //false

	compRequest := strings.Compare(str4, str5)
	fmt.Println(compRequest) // 输出: -1, 表示str4再str5之前, 0表示相等

	// 字符串替换
	source := "go is good, go is great"
	replaced := strings.ReplaceAll(source, "go", "Go")
	fmt.Println(replaced) //Go is Good, Go is great

	// 字符串的大小写转换
	str6 := "GoLang"
	lowercase := strings.ToLower(str6)
	uppercase := strings.ToUpper(str6)
	fmt.Println(lowercase) // golang
	fmt.Println(uppercase) // GOLANG

	// 使用正则表达式处理字符串
	str7 := "My email is example@example.com"
	re := regexp.MustCompile(`[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}`)
	email := re.FindString(str7)
	fmt.Println(email) // 输出: example@example.com

	// 字符串拆分
	str8 := "appele, banana, cherry"
	items := strings.Split(str8, ",")
	fmt.Println(items)                 // [appele  banana  cherry]
	fmt.Println(reflect.TypeOf(items)) // []string

	// 字符串合并
	items1 := []string{"apple", "banana", "cherry"}
	str9 := strings.Join(items1, ", ")
	fmt.Println(str9) //apple, banana, cherry

	// 字符串遍历
	str10 := "Go"
	for index, value := range str10 {
		fmt.Printf("%d, %c\n", index, value)
		//0, G
		//1, o
	}

	// 获取字符串中的字符
	str11 := "Go"
	byteValue := str11[1]
	fmt.Println(byteValue) // 输出: 111 (ASCII码的'o')

	// 字符串统计
	str12 := "Go is easy to learn. Go is powerful."
	str13 := "够浪 is easy to learn. 够浪 is powerful."
	count := strings.Count(str12, "Go")
	count1 := strings.Count(str13, "够浪")
	fmt.Println(count)  // 输出: 2
	fmt.Println(count1) // 输出: 2

	//字符串与UTF-8互操
	//获取字符串长度
	str14 := "语言"
	byteLen := len(str)
	runeLen := utf8.RuneCountInString(str14)
	fmt.Println(byteLen) // 输出: 6
	fmt.Println(runeLen) // 输出: 2
	//将字符串解码为rune切片
	str15 := "语言"
	runes := []rune(str15)
	fmt.Println(runes) // 输出: [35821 35328]

	// strconv 字符串给的类型转换
	// strconv.Atoi 字符串转换为整数。
	// strconv.FormatFloat 浮点数转换为字符串
	// strconv.ParseFloat函数可以将字符串转换为浮点数。
}
```



#### 数组

- 数组是一种数据类型的固定长度序列
- 数组定义: var a [len]int, 比如: var a [5]int, 数组长度必须是产量, 且是类型的组成部分. 一旦定义, 长度不能变
- 长度是数组类型的一部分,因此, var a [5]int和var a [10]int是不同的类型.
- 数组可以通过下标访问, 下标从0开始,最后一个元素下标是: len - 1
- 访问越界, 如果下标在数组合法范围外,则会触发访问越界, 会panic
- 数组是值类型, 赋值和传参会复制整个数组, 而不是指针. 因此改变副本的值,不会改变本身的值
- 支持 “==”, “!=” 操作符, 因为内存总是被初始化过的
- 指针数组[n]*T, 数组指针 *[n]T



```go
package main

import (
    "fmt"
)

var arr0 [5]int = [5]int{1, 2, 3}
var arr1 = [5]int{1, 2, 3, 4, 5}
var arr2 = [...]int{1, 2, 3, 4, 5, 6}
var str = [5]string{3: "hello world", 4: "tom"}

func main() {
    a := [3]int{1, 2}           // 未初始化元素值为 0。
    b := [...]int{1, 2, 3, 4}   // 通过初始化值确定数组长度。
    c := [5]int{2: 100, 4: 200} // 使用引号初始化元素。
    d := [...]struct {
        name string
        age  uint8
    }{
        {"user1", 10}, // 可省略元素类型。
        {"user2", 20}, // 别忘了最后一行的逗号。
    }
    fmt.Println(arr0, arr1, arr2, str)
    fmt.Println(a, b, c, d)
}

// 结果:  [1 2 3 0 0] [1 2 3 4 5] [1 2 3 4 5 6] [   hello world tom]
//       [1 2 0] [1 2 3 4] [0 0 100 0 200] [{user1 10} {user2 20}]
```



#### 切片Slice

- 切片是数组的一个引用, 因此切片是引用类型. 但自身是结构体, 值拷贝传递.
- 切片的长度可以改变,因此,切片是一个可变数组
- 切片遍历方式和数组一样, 可以用len()求长度, 表示可用元素数量, 读写操作不能超过该限制
- cap可以求出slice最大扩张容量, 不能超出数组限制, 0 <=  len(slice) <= len(array), 其中array是slice引用的数组
- 切片的定义: var 变量名 []类型, 比如 var str []string var arr[int]
- 如果slice == nil, 那么len、cap 结果都等于0

1. 增

   ```go
   func main() {
   	// 追加单个元素
   	s := []int{1, 2, 3}
   	s = append(s, 4)
   	fmt.Println(s)  // 输出: [1 2 3 4]
       // 追加多个元素
   	s := []int{1, 2, 3}
   	s = append(s, 4, 5, 6)
   	fmt.Println(s) // 输出: [1 2 3 4 5 6]
       // 追加多个元素
   	s1 := []int{1, 2, 3}
   	s2 := []int{4, 5, 6}
   	s1 = append(s1, s2...) // 追加另一个切片，需要用 `...` 展开切片
   	fmt.Println(s1) // 输出: [1 2 3 4 5 6]
   }
   ```

   

2. 删

   ```go
   func main() {
   	s := []int{1, 2, 3, 4, 5}
   
   	// 删除索引为2的元素（值为3）
   	s = append(s[:2], s[3:]...)
   	fmt.Println(s) // 输出：[1 2 4 5]
   }
   ```

   

3. 改

   ```go
   package main
   
   import "fmt"
   
   func main() {
       s := []int{1, 2, 3, 4, 5}
   
       // 修改索引为2的元素
       s[2] = 10
       fmt.Println(s) // 输出: [1 2 10 4 5]
   }
   ```

   

4. 查

   访问单个元素

   ```go
   package main
   
   import "fmt"
   
   func main() {
       s := []int{1, 2, 3, 4, 5}
   
       // 访问索引为2的元素
       fmt.Println(s[2]) // 输出: 3
   }
   ```

   遍历切片中的所有元素

   ```go
   package main
   
   import "fmt"
   
   func main() {
       s := []int{1, 2, 3, 4, 5}
   
       // 遍历切片
       for i, v := range s {
           fmt.Printf("索引: %d, 值: %d\n", i, v)
       }
   }
   ```



#### 指针

- go语言中的函数传参都是值拷贝,需要修改某个变量的时候,可以创建一个指向该变量的地址的指针变量,传递数据使用指针,无需拷贝数据

- go中指针操作非常简单,只需要记住两个符号:&(取地址)和*(根据地址取值)

- 在对普通变量使用&操作符取地址后会获得这个变量的指针，然后可以对指针使用`*`操作，也就是指针取值，代码如下

  ```go
  func main() {
      //指针取值
      a := 10
      b := &a // 取变量a的地址，将指针保存到b中
      fmt.Printf("type of b:%T\n", b)
      c := *b // 指针取值（根据指针去内存取值）
      fmt.Printf("type of c:%T\n", c)
      fmt.Printf("value of c:%v\n", c)
  }
  // 结果
  // type of b:*int
  // type of c:int
  // value of c:10
  ```

- 变量、指针地址、指针变量、取地址、取值的相互关系和特性如下:

  - 对变量进行取地址(&)操作, 可以获得这个变量的指针变量
  - 指针变量的值是指针地址
  - 对指针变量进行取值(*)操作,可以获得指针变量指向的原变量的值

- new和make的区别

  ```go
  func main() {
      var a *int
      *a = 100
      fmt.Println(*a)
  
      var b map[string]int
      b["测试"] = 100
      fmt.Println(b)
  }
  // 代码运行会报错
  // 在Go语言中对于引用类型的变量，在使用的时候不仅要声明它，还要为它分配内存空间，否则值就没办法存储。而对于值类型的声明不需要分配内存空间，是因为它们在声明的时候已经默认分配好了内存空间。要分配内存，就引出来new和make
  ```

  - 二者都是用来做内存分配的。
  - make只用于slice、map以及channel的初始化，返回的还是这三个引用类型本身；
  - 而new用于类型的内存分配，并且内存对应的值为类型零值，返回的是指向类型的指针。



