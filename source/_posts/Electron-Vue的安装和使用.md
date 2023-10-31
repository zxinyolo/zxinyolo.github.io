---
title: Electron-Vue的安装和使用
author: zhangxin
tags:
  - private
  - Electron-Vue
date: 2023-10-31 22:22:28
categories: 技术文档
---

### 安装Electron-Vue

官网: https://github.com/SimulatedGREG/electron-vue

```shell
# 安装 vue-cli 和 脚手架样板代码
npm install -g vue-cli
vue init simulatedgreg/electron-vue my-project

# 安装依赖并运行你的程序
cd my-project
yarn # 或者 npm install   安装yarn  npm install yarn
yarn run dev # 或者 npm run dev
```

#### 安装中遇到的坑

##### 初始化时 vue init simulatedgreg/electron-vue my-project

![image-20231031224001787](https://raw.githubusercontent.com/zxinyolo/images/main/202310312240503.png)

-  use asss 选择no
- ESlink 选择yes
- Mocha 选择no



##### mac M1 版本安装Electron

- yarn add electron@11  要高于10版本
- yarn upgrade electron-builder@22.10.4 要高于20版本

##### vue-devtools报错

- yarn add electron-devtools-installer

- src/main/index.js文件中添加代码

  ```js
  app.on('ready', () => {
    if (process.env.NODE_ENV !== 'production') {
      require('vue-devtools').install()
    }
  })
  ```

  

##### vue 的 webpack 热更新总是报 404 错误

![image-20231031225031326](https://raw.githubusercontent.com/zxinyolo/images/main/202310312250367.png)

- .electron-vue/dev-runner.js 中的这行代码解开注释

##### 报错模块找不到

- 某些版本中src/index.ejs代码修改为(单双引号问题)

  ```js
  require('module').globalPaths.push('<%= htmlWebpackPlugin.options.nodeModules.replace(/\\/g, "\\\\") %>')
  ```

#### mac上运行白屏问题

- src/main/index.js 中添加代码

  ```js
    mainWindow = new BrowserWindow({
      height: 563,
      useContentSize: true,
      width: 1000,
      webPreferences: {
        enableRemoteModule: true,
        devTools: true,
        nodeIntegration: true,
        contextIsolation: false,
        nodeIntegrationInWorker: true
      }
  
    })
  ```





### Electron-Vue中引入element-ui

- yarn add element-ui

- 在 `/my-project/src/renderer/main.js` 中引入 element ui

  ```js
  // element-ui
  import ElementUI from 'element-ui'
  import 'element-ui/lib/theme-chalk/index.css'
  Vue.use(ElementUI)
  ```

- 此时就可以在任意 .vue 文件中添加和使用 element-ui 元素了

  ```js
  <el-button type="success" icon="el-icon-search" round>默认按钮</el-button>
  ```
