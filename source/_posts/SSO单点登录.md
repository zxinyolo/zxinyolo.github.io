---
title: SSO单点登录
author: zhangxin
tags:
  - private
  - 单点登录
date: 2023-08-16 14:49:27
categories: 技术文档
---

#### 单点登录原理

单点登录(Single Sign On),简称SSO.在公司项目有多个时,用户只要登录一次,就可以在任意子系统中完成统一登录,统一退出.



#### SSO系统原理

![image-20230816145824921](https://raw.githubusercontent.com/zxinyolo/images/main/202308161458972.png)

其中网站A,网站B都有自己的登录,退出逻辑,但是只要设计到 登录就会被跳转到SSO服务,我们也可称之为注册中心,或者集中认证服务(简称CAS).当访问网站A时跳转到注册中心完成登录,在这里完成登录之后再跳回之前的站点,就可以完成当前网站的登录了.然后访问网站B时跳转到注册中心,这时会发现注册中心已经完成了登录,然后直接跳回网站B就可以了

假设网站A地址为http://site-a, 网站B的地址为http://site-b, 而注册中心的地址为http://site-sso



#### 第一次登录

第一次登录,假设是从网站A(http://site-a)进行登录时,然后跳转到注册中心(http://locallhost),登录成功把cookie在注册中心设置一份,之后再携带登录成功的消息跳回网站A完成登录.

![image-20230816150824342](https://raw.githubusercontent.com/zxinyolo/images/main/202308161508400.png)

#### 第N次登录

第二次登录,从网站B(http://site-b)进行登录,然后跳转到注册中心(http://locallhost)进行登录,因为之前已经登录过了,请求服务器是就能被识别之前已经登录过了,请求服务器,然后服务器携带登录信息直接从定向到网站B.

![image-20230816151354687](https://raw.githubusercontent.com/zxinyolo/images/main/202308161513741.png)

#### 登出逻辑

任意一个站点进行登出,假设是从站点A进行登出,首先请求服务器进行登出,然后清空客户端cookie,服务器cookie.然后被服务器重定向到注册中心登出,注册中心清空cookie,然后重定向到站点B到了出,站点B登出之后再重定向会最开始的登出页面

![image-20230816151757071](https://raw.githubusercontent.com/zxinyolo/images/main/202308161517129.png)

上面是主要实现的逻辑,但是因为技术有很多种,具体的方案要根据实际的方式来.

