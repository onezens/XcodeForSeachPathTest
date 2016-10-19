# XcodeForSeachPathTest
Xcode test demo for SeachPath

#blog地址(定时更新):
[http://www.wackosix.cn/searchpaths/](http://www.wackosix.cn/searchpaths/)

#Xcode 导入第三方库-Search Paths相关配置
开发的过程当中，导入第三方库(framework/.a/.dylib)或者下载使用别人的demo会经常会遇到一些关于库的导入的问题。而导入第三方库后，这写库的路径应该现在在导入当前项目target的`Search Paths`中，具体的设置路径：`target -> Build Settings -> Search Paths -> Framework Search Paths / Library Search Paths`。

##创建测试demo
创建测试项目的时候分别创建framwork和library的文件夹，从两种不同类型的第三方库，不同目录位置去测试。两个相关目录的位置示意图：
![](http://src.wackosix.cn/image/2/4a/28ed3b326d5759e592b0846d14cfc.png)
* Frameworks 文件夹在`*.xcodeproj`项目文件的上次层目录中
* ThirdLib 文件夹在`*.xcodeproj`同级目录下的XcodeForSearchPathTest目录中

**注意：** Frameworks文件夹在拖到项目中的时候，取消Copy items if needed 选项

##导入第三方库
将自己创建好的测试库`libzhenLib.a`和`zhenFW.framework`分别导入项目当中对应得文件夹，后Search Paths 变化示意图：
![](http://src.wackosix.cn/image/3/64/9bb6ad48f598039e175b586447161.png)
从图中可以看出Library Search Paths中Xcode自动添加好库的路径，但是Framework Search Paths中没有任何的变化。编译项目之后，会有一个错误`ld: framework no found zhenFW`：
![](http://src.wackosix.cn/image/b/af/9aed5f47ec765b2da18970c789094.png)
这个错误的原因是：zhenFW 已经导入到了项目当中，但是没有找到它的路径。通过猜想可以知道`libzhenLib.a`库没有报错并且`Library Search Paths`有它的库的路径，那么可能zhenFW报错的原因是`Framework Search Paths`中没有配置它的路径，下面咱们来配置它的路径来测试问题是否解决来验证我们的猜想的正确性。

**配置zhenFW路径：**首先点击`Framework Search Paths`展开添加路径的框，然后将`zhenFW.framework`拖拽到上面展开的框里面。拖入之后的示意图为：
![](http://src.wackosix.cn/image/7/db/5b8dcf4c6dd6db7c4ec616111208b.png)
拖到里面之后生成的路径为：`"$(SRCROOT)/../Frameworks/zhenFW/zhenFW.framework"`，然后编译项目之后，还是报原先的错误。  
**报错原因：**`Framework Search Paths`重点在Paths，是路径！但Xcode生成的路径是一个文件的路径，而不是目录的路径，将默认生成的修改为：`"$(SRCROOT)/../Frameworks/zhenFW/"`，编译成功！

**说明：**

* 正常导入库的时候Xcode会默认生成库的路径，但是有时候会没有生成，这时就需要差错，并且手动去解决、删除后重新导入以及查找该库的使用说明。
* 如果在测试的时候，路径生成正常的话，可以自己手动删除一个来测试
* 文件夹路径和文件路径的区别

## Search Paths相关参数说明
1. 导入库的时候自动生成的的路径：`$(PROJECT_DIR)/XcodeForSeachPathTest/ThirdLib/zhenLib`，手动拖拽的路径`"$(SRCROOT)/../Frameworks/zhenFW/zhenFW.framework"`，很明显的区别是手动拖得有双引号，双引号的作用是如果在路径中有空格，可以识别该路径。没有双引号但是路径中有空格，我们发现它会自动变成两个路径。
2. 路径中有空格必须要加双引号
3. 多个路径可以用空格隔开，不用双引号包住
4. `$(SRCROOT)` / `$(PROJECT_DIR)` 基本没啥区别，都是指向`*.xcodeproj`所在的路径
5. 通过`/..`来调到上一层路径,返回上上层文件夹用`/../..`
6. `$(inherited)` ： target 的 `Framework Search Paths`添加`$(inherited)`参数会从`PROJECT -> Build Settings -> Framework Search Paths`里面的路径会被其继承，没有的话不会继承。所以一个项目里面有多个target，使用到了同一个库(Library或Framework)那么为了方便我们可以在target添加继承参数，并且`PROJECT`统一中添加库的路径。继承的优先级：
   * Platform defaults
   * Project file (描述举例用这个优先级，比较常用)
   * xcconfig file for the Project file
   * Target
   * xcconfig file for the Target

7. `recursive`：遍历该目录，`non-recursive`：默认路径设置；不遍历该目录。如果路径的属性为`recursive`，那么编译的时候在找库的路径的时候，会遍历该目录下的所有子目录的库文件。PS：在搭建项目的时候，可以创建一个专门放库文件的文件夹并且设置其属性为`recursive`。`$(PROJECT_DIR)/**`相当于遍历项目文件同级下的所有路径(不推荐使用，项目大的话，影响编译的速度)。
8. Search Paths子选项：Header Search Paths 、User Header Search Paths的参数设置与其相同
9. 具体路径应该需要根据不同项目的不同的路径来配置，通过了解相关配置，可以更加方便的差错和修复错误

## 测试demo
[XcodeForSeachPathTest](https://github.com/onezens/XcodeForSeachPathTest)

## 参考文章
 * [The Unofficial Guide to xcconfig files](https://pewpewthespells.com/blog/xcconfig_guide.html)
 * [XCode环境变量及路径设置](http://blog.csdn.net/freedom2028/article/details/8658819)
 * [xcode环境设置](http://blog.csdn.net/ylwdi/article/details/26259207)





