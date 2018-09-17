//
//  XMProtectorCrash.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/11.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "XMProtectorCrash.h"
#import "NSObject+Safeguard.h"
//container
#import "NSString+Safeguard.h"
#import "NSMutableString+Safeguard.h"
#import "NSAttributedString+Safeguard.h"
#import "NSMutableAttributedString+Safeguard.h"
#import "NSArray+Safeguard.h"
#import "NSMutableArray+Safeguard.h"
#import "NSDictionary+Safeguard.h"
#import "NSMutableDictionary+Safeguard.h"
//NSTimer
#import "NSTimer+Safeguard.h"
//KVO
#import "NSObject+KVOSafeguard.h"
//UnRecognitionSelector
#import "NSObject+SelectorSafeguard.h"
//Notification
#import "NSNotificationCenter+Safeguard.h"



@implementation XMProtectorCrash

+ (void)openAllCrashProtector {
    //容器类保护
    [self openContainerCrashProtector];
    
    //定时器保护
    [self openTimerCrashProtector];
    
    //KVO
    [self openKOVCrashProtector];
    
    //Selecter
    [self openUnrecognizedSelectorCrashProtector];
    
    //NotificationCenter,可能会有性能问题，dealloc里面加了判断，
    //系统的每个对象dealloc时都会调用
    [self openNotificationCenterCrashProtector];
}


+ (void)openContainerCrashProtector {
    //1.NSString
    [NSString openCrashProtector];
    [NSMutableString openCrashProtector];
    //2.NSAttributedString
    [NSAttributedString openCrashProtector];
    [NSMutableAttributedString openCrashProtector];
    //3.NSArray
    [NSArray openCrashProtector];
    [NSMutableArray openCrashProtector];
    //4.NSDictionary
    [NSDictionary openCrashProtector];
    [NSMutableDictionary openCrashProtector];
}

+ (void)openTimerCrashProtector {
    [NSTimer openCrashProtector];
}

+ (void)openKOVCrashProtector {
    [NSObject openCrashProtectorKVO];
}

+ (void)openUnrecognizedSelectorCrashProtector {
    [NSObject openCrashProtectorSelector];
}

+ (void)openNotificationCenterCrashProtector {
    [NSNotificationCenter openCrashProtector];
}



@end
