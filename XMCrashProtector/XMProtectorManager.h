//
// Created by xuzhangming on 2018/8/21.
// Copyright (c) 2018 xuzhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMProtectorCrashLog.h"


#ifdef DEBUG
#define XMLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#define XMLog(...) {}
#endif


#define  XMCrashProtectionLog(exception,crash)   [XMProtectorManager logCrashWithException:exception crashType:crash]


//crash的类型
typedef NS_ENUM(NSInteger, XMCrashProtectorType) {
    XMCrashProtectorTypeAll = 0,         /*开启所有的保护*/
    XMCrashProtectorTypeSelector = 1<<0, /*UnrecognizedSelector保护*/
    XMCrashProtectorTypeKVO = 1<<1,       /*KVO保护*/
    XMCrashProtectorTypeContainer = 1<<2, /*容器保护,包括:包括NSArray、NSMutableArray、 NSDictionary、NSMutableDictionary、NSString、 NSMutableString*/
    XMCrashProtectorCrashTypeNotification = 1<<3, /*通知保护*/
    XMCrashProtectorCrashTimer = 1<<4,  /*定时器保护*/
};

typedef void(^XMCrashProtectorBlock)(NSException *exception,NSString *crashLog, XMCrashProtectorType crashType);


@interface XMProtectorManager : NSObject

//打开目前所支持的所有crash保护 回调block
+ (void)openAllCrashProtectorWithBlock:(XMCrashProtectorBlock)block;

+ (void)logCrashWithException:(NSException *)exception
                    crashType:(XMCrashProtectorType)crashType;


@end
