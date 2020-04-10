//
// Created by xuzhangming on 2018/8/21.
// Copyright (c) 2018 xuzhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMProtectorCrash.h"

#ifdef DEBUG
#define XMLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#define XMLog(...) {}
#endif


#define  XMCrashProtectionLog(exception,crash)   [[XMProtectorCrash shareProtecotor] catchWithException:exception crashType:crash]


@interface XMProtectorManager : NSObject

//打开目前所支持的所有crash保护 回调block
+ (void)openCrashProtectorType:(XMCrashProtectorType)crashType
                     withBlock:(XMCrashProtectorBlock)block;

@end
