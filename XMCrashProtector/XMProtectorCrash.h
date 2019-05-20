//
//  XMProtectorCrash.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/11.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

//crash的类型
typedef NS_ENUM(NSInteger, XMCrashProtectorType) {
    XMCrashProtectorTypeSelector = 1<<0, /*UnrecognizedSelector保护*/
    XMCrashProtectorTypeKVO = 1<<1,       /*KVO保护*/
    XMCrashProtectorTypeContainer = 1<<2, /*容器保护,包括:包括NSArray、NSMutableArray、 NSDictionary、NSMutableDictionary、NSString、 NSMutableString*/
    XMCrashProtectorCrashTypeNotification = 1<<3, /*通知保护*/
    XMCrashProtectorCrashTimer = 1<<4,  /*定时器保护*/
    XMCrashProtectorTypeAll = XMCrashProtectorTypeSelector | XMCrashProtectorTypeKVO | XMCrashProtectorTypeContainer | XMCrashProtectorCrashTypeNotification | XMCrashProtectorCrashTimer,         /*开启所有的保护*/
};

@interface XMProtectorCrash : NSObject

+ (instancetype)shareProtecotor;

- (void)openCrashProtector:(XMCrashProtectorType)crashType;

@end
