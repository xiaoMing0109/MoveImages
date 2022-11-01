![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a4cb287a1e984292b3944f2ef19e669f~tplv-k3u1fbpfcp-zoom-1.image)

# MoveImages
Xcode Command Line Tool 写的递归迁移文件夹下的所有图片至指定文件夹的小工具。

## 使用

### 可执行文件
1. 编译生成可执行文件。
2. 切换至 Products 目录定位可执行文件位置。
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0f66a621dd2c4d4aae324814980d6502~tplv-k3u1fbpfcp-zoom-1.image)
3. 添加可执行权限 
```
chmod +x MoveImages
```
4. 运行
- 交互模式
```
./MoveImages
```
- 或者查看静态执行使用介绍
```
./MoveImages -h or --help
```
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f411b3e4db694765bce9931088cd60cf~tplv-k3u1fbpfcp-zoom-1.image)

### Xcode 调试运行
- 直接运行
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e40558efdd4743d69b1170fbf33f45ca~tplv-k3u1fbpfcp-zoom-1.image)
多余字符是针对终端 log 文本颜色变更，Xcode 中不支持，忽略即可。
- 或者通过 `Edit Scheme` 添加参数模拟静态执行方式调试
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/04dba04a5ca2457299ffa7b74d06e719~tplv-k3u1fbpfcp-zoom-1.image)

## 附录
- 想修改支持移动文件类型在此修改即可。
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dfd4be0abf624e81a60065d64a209bf6~tplv-k3u1fbpfcp-zoom-1.image)
- 终端静态模式运行时，请注意 frompath、topath 为绝对路径，且不要包含多余空格。（建议采用将文件夹拖动至终端的方式来正确填充文件路径）

Demo: [GitHub](https://github.com/xiaoMing0109/MoveImages)
文章: [掘金](https://juejin.cn/post/7160977036129861668/)

参考链接:
[https://github.com/DeveloperLx/macOS_Development_Tutorials_translation/blob/master/Command%20Line%20Programs%20on%20macOS%20Tutorial.md](https://github.com/DeveloperLx/macOS_Development_Tutorials_translation/blob/master/Command%20Line%20Programs%20on%20macOS%20Tutorial.md)