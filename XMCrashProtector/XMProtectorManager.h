//
// Created by xuzhangming on 2018/8/21.
// Copyright (c) 2018 xuzhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMProtectorCrash.h"
#import "XMProtectorCrashLog.h"


#ifdef DEBUG
#define XMLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#define XMLog(...) {}
#endif


#define  XMCrashProtectionLog(exception,crash)   [XMProtectorManager logCrashWithException:exception crashType:crash]


typedef void(^XMCrashProtectorBlock)(NSException *exception,NSString *crashLog, XMCrashProtectorType crashType);


@interface XMProtectorManager : NSObject

//打开目前所支持的所有crash保护 回调block
+ (void)openCrashProtectorType:(XMCrashProtectorType)crashType
                     withBlock:(XMCrashProtectorBlock)block;

+ (void)logCrashWithException:(NSException *)exception
                    crashType:(XMCrashProtectorType)crashType;


@end
