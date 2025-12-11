# torchlight_dex

火炬之光图鉴

A new Flutter project.

## 打包

### 安卓

[参考按照教程](https://docs.flutter.dev/deployment/android#create-an-upload-keystore)  

只需要注意下面两步骤：

1.生成并将你的`upload-keystore.jks`复制到`[项目]/android/app/`下  
2.在`[项目]/android/`下创建配置好`key.properties`

运行`flutter build apk --split-per-abi`即可打包

安卓手机一般使用`app-arm64-v8a-release.apk`的包即可
