//
//  NSObject+SelectorSafeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSObject+SelectorSafeguard.h"
#import "NSObject+XMExchange.h"

#pragma mark - 辅助类
@interface SafeProxy: NSObject

@property (nonatomic,strong) NSException *exception;
@property (nonatomic,weak) id safe_object;

@end

@implementation SafeProxy

- (void)safe_pretectAction {
    //.m文件有方法没有实现
}

@end


#pragma mark - SelectorSafeguard
@implementation NSObject (SelectorSafeguard)

+ (void)openCrashProtectorSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1.
        [self exchangeInstanceMethod:@selector(methodSignatureForSelector:) newSel:@selector(safe_methodSignatureForSelector:)];
        
        //2.
        [self exchangeInstanceMethod:@selector(forwardInvocation:) newSel:@selector(safe_forwardInvocation:)];
    });
}


- (NSMethodSignature *)safe_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *ms = [self safe_methodSignatureForSelector:aSelector];
    if ([self respondsToSelector:aSelector] || ms){
        return ms;
    }
    else{
        return [SafeProxy instanceMethodSignatureForSelector:@selector(safe_pretectAction)];
    }
}

- (void)safe_forwardInvocation:(NSInvocation *)anInvocation {
    @try {
        [self safe_forwardInvocation:anInvocation];
        
    } @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeSelector);
        
    } @finally {
        
    }
}




@end
