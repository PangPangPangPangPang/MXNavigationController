# MXNavigator
---
###介绍
MXNavigator是一个自定义container view controller。

###功能
* 通过添加**pageNick**使相同页面可以重用而不会出现无限叠加的问题。
* 可以实现灵活的过场动画。
* 将页面跳转抽象成**url**形式，方便与H5交互。
* 支持手势返回。

###主要接口

```objective-c
//跳转页面
- (void)gotoPageWithPageName:(NSString *)pageName
                    pageNick:(NSString *)pageNick
                        args:(NSDictionary *)args
                   animeType:(MXAnimateType)type;
//返回页面
- (void)popToPrePage;
```

###未来功能
* 将会实现系统**UINavigationBar**相关动画。
* 优化内存管理。
* 实现**callback**。

###关于我
[微薄](http://weibo.com/mmmmmmaxx)

[Blog](http://mmmmmmax.wang)

