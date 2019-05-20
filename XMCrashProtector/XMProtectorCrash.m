//
//  XMProtectorCrash.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/11.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "XMProtectorCrash.h"

@interface XMProtectorCrash ()
{
    NSMutableSet* _currentClassesSet;
    NSMutableSet* _blackClassesSet;
    NSInteger _currentClassSize;
    dispatch_semaphore_t _classArrayLock;
    dispatch_semaphore_t _prtectorLock;
}

@end

@implementation XMProtectorCrash

+ (instancetype)shareProtecotor {
    static dispatch_once_t onceToken;
    static id crashProtector;
    dispatch_once(&onceToken, ^{
        crashProtector = [[self alloc] init];
    });
    return crashProtector;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _blackClassesSet = [NSMutableSet new];
        _currentClassesSet = [NSMutableSet new];
        _currentClassSize = 0;
        _classArrayLock = dispatch_semaphore_create(1);
        _prtectorLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)openCrashProtector:(XMCrashProtectorType)crashType {
    
     dispatch_semaphore_wait(_prtectorLock, DISPATCH_TIME_FOREVER);
    if (crashType) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"
        
         //容器类保护
        if (XMCrashProtectorTypeContainer) {
            //1.NSString
            [NSString performSelector:@selector(openCrashProtector)];
            [NSMutableString performSelector:@selector(openCrashProtector)];
            
            //2.NSAttributedString
            [NSAttributedString performSelector:@selector(openCrashProtector)];
            [NSMutableAttributedString performSelector:@selector(openCrashProtector)];
            
            //3.NSArray
            [NSArray performSelector:@selector(openCrashProtector)];
            [NSMutableArray performSelector:@selector(openCrashProtector)];
            
            //4.NSDictionary
            [NSDictionary performSelector:@selector(openCrashProtector)];
            [NSMutableDictionary performSelector:@selector(openCrashProtector)];
        }
        
        //定时器保护
        if (XMCrashProtectorCrashTimer) {
            [NSTimer performSelector:@selector(openCrashProtector)];
        }
        
        //KVO
        if (XMCrashProtectorTypeKVO) {
            [NSObject performSelector:@selector(openCrashProtectorKVO)];
        }
        
        //Selecter
        if (XMCrashProtectorTypeSelector) {
           [NSObject performSelector:@selector(openCrashProtectorSelector)];
        }
        
        //NotificationCenter
        if (XMCrashProtectorCrashTypeNotification) {
            [NSNotificationCenter performSelector:@selector(openCrashProtector)];
        }
        
         #pragma clang diagnostic pop
    }
    dispatch_semaphore_signal(_prtectorLock);
}

@end
