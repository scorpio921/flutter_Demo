# my_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


flutter packages get   安装包， 类似于npm install
flutter run 启动项目

##  一、环境搭建
### 1.java环境搭建，官网下载系统相对应的exe文件，需要有Oracle账号，下载后需要配置环境变量
    1.系统变量（注意是系统变量）点击新建，变量名：JAVA_HOME，变量值：安装java目录，
    2.系统变量Path选项点编辑--->新建--->输入：%JAVA_HOME%\bin
    3.cmd打开窗口输入 java看是否完成安装
    4.注意java版本必须得是11，否则flutter doctor --android-licenses 会报错

### 2.flutter安装及环境配置
    1.官方地址下载压缩包，解压文件（请勿将 Flutter 安装在需要高权限的文件夹内，例如 C:\Program Files\，及有特殊字符或空格的路径下）
    2.用户变量Path选项点击编辑---》新建==》输入flutter解压地址/bin
    3.flutter doctor 验证安装配置是否正确
### 3.Android Studio安装及环境配置
    1.官网下载
    2.安装完成点击新建，File | Settings | Appearance & Behavior | System Settings | Android SDK  添加对应sdk
    3.环境配置系统变量
       名称：FLUTTER_STORAGE_BASE_URL  变量值：https://storage.flutter-io.cn
       名称：PUB_HOSTED_URL    变量值：https://pub.flutter-io.cn