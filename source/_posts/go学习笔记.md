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

