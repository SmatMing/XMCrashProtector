//
//  NSNotificationCenter+Safeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSNotificationCenter+Safeguard.h"
#import "NSObject+XMExchange.h"
#import <objc/message.h>

#pragma mark - 辅助类
@interface NSObject (Notific)

@property (nonatomic,assign) BOOL isNotification;

@end

@implementation NSObject (Notific)

-(void)setIsNotification:(BOOL)isNotification {
    objc_setAssociatedObject(self, @selector(isNotification), @(isNotification), OBJC_ASSOCIATION_RETAIN);
}

-(BOOL)isNotification {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end


#pragma mark - Safeguard
@implementation NSNotificationCenter (Safeguard)
+ (void)openCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1.addObserver
        [self exchangeInstanceMethod:@selector(addObserver:selector:name:object:) newSel:@selector(safe_addObserver:selector:name:object:)];
        
        //2.
        [self exchangeInstanceMethod:NSSelectorFromString(@"dealloc") newSel:NSSelectorFromString(@"safe_dealloc")];
    });
}

- (void)safe_addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject {
    [observer setIsNotification:YES];
    [self safe_addObserver:observer selector:aSelector name:aName object:anObject];
}

- (void)safe_dealloc {
    if ([self isNotification]) {
        NSException *exception=[NSException exceptionWithName:@"dealloc时通知中心未移除本对象" reason:[NSString stringWithFormat:@"dealloc时通知中心未移除本对象  Class:%@",[self class]] userInfo:nil];
        XMCrashProtectionLog(exception, XMCrashProtectorCrashTypeNotification);
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self safe_dealloc];
}

@end
