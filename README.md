# **使用须知**  
* 防止crash组件框架，用于常用方法crash防护。包含多种防护。
* 适用于ios8以上系统,其他系统可能会有不兼容的问题。

# **使用方法**
* 使用方法：下载导入工程,如图所示：
![](https://github.com/SmatMing/XMCrashProtector/blob/master/Resource/1.jpg)
crash的实时会回调上边的block,这是你就可根据需要把crashLog日志上传到自己服务器或者第三方平台。debug下方法内部会自动打印出crashLog。

# **crash防护效果输出日志**
* 这是未开启防护是时的crash截图
![](https://github.com/SmatMing/XMCrashProtector/blob/master/Resource/2.jpg)
* 这是开启防护是时,捕获到crash截图,如果[Error Place]没有定位到具体的位置,就需要手动去符号了
![](https://github.com/SmatMing/XMCrashProtector/blob/master/Resource/3.jpg)
* 可下载运行工程演示

# **crash防护支持一下几种类型**
```
typedef NS_ENUM(NSInteger, XMCrashProtectorType) {
XMCrashProtectorTypeAll = 0,         /*开启所有的保护*/
XMCrashProtectorTypeSelector = 1<<0, /*UnrecognizedSelector保护*/
XMCrashProtectorTypeKVO = 1<<1,       /*KVO保护*/
XMCrashProtectorTypeContainer = 1<<2, /*容器保护,包括:包括NSArray、NSMutableArray、 NSDictionary、NSMutableDictionary、NSString、 NSMutableString*/
XMCrashProtectorCrashTypeNotification = 1<<3, /*通知保护*/
XMCrashProtectorCrashTimer = 1<<4,  /*定时器保护*/
};
```
* 具体支持的防护方法请见各防护类的.h文件。

