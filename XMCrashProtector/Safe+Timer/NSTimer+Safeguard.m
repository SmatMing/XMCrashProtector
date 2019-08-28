//
//  NSTimer+Safeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSTimer+Safeguard.h"
#import "NSObject+XMExchange.h"

#pragma mark - 辅助
@interface WeakProxy: NSProxy

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end

@implementation WeakProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[WeakProxy alloc] initWithTarget:target];
}

//当不能识别方法时候,就会调用这个方法,由于这里对所有的不能处理的都传递给_target了,所以methodSignatureForSelector和forwardInvocation不可能被执行的,
//因为_target是弱引用的,所以当_target可能释放了,当它被释放了的情况下,那么forwardingTargetForSelector就是返回nil了.
//所有需要重载methodSignatureForSelector和forwardInvocation

// 转发目标选择器
- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

// 函数执行器
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

// 方法签名的选择器
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}



@end


#pragma mark - Safeguard
@implementation NSTimer (Safeguard)

+ (void)openCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1.
        [self exchangeClassMethod:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) newSel:@selector(safe_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)];
        
        //2.
        [self exchangeClassMethod:@selector(timerWithTimeInterval:target:selector:userInfo:repeats:) newSel:@selector(safe_timerWithTimeInterval:target:selector:userInfo:repeats:)];
    });
}

+ (NSTimer *)safe_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    WeakProxy *weakProxy = [WeakProxy proxyWithTarget:target];
    
    return [self safe_scheduledTimerWithTimeInterval:timeInterval target:weakProxy selector:selector userInfo:userInfo repeats:repeats];
}

+ (NSTimer *)safe_timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)repeats {
    WeakProxy *weakProxy = [WeakProxy proxyWithTarget:target];
    
    return [self safe_timerWithTimeInterval:timeInterval target:weakProxy selector:aSelector userInfo:userInfo repeats:repeats];
}


@end
