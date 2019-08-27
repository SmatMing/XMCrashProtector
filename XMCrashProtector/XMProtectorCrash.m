//
//  XMProtectorCrash.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/11.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "XMProtectorCrash.h"
#import "XMProtectorCrashLog.h"

@interface XMProtectorCrash ()
{
    NSMutableSet* _currentClassesSet;
    NSMutableSet* _blackClassesSet;
    NSInteger _currentClassSize;
    dispatch_semaphore_t _classArrayLock;
    dispatch_semaphore_t _prtectorLock;
}

@property (nonatomic, copy) XMCrashProtectorBlock handel;

@property (nonatomic, strong) NSException *oldException;

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
        
        [self catchUncaughtExceptionHandler];
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


//崩溃捕捉Uncaugh
-(void)catchUncaughtExceptionHandler {
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

static void uncaughtExceptionHandler(NSException*exception){
    
    [[XMProtectorCrash shareProtecotor] catchCrashCallBack:exception];
}

//try-catch 回调
- (void)catchWithException:(NSException *)exception
                 crashType:(XMCrashProtectorType)crashType {
    [self catchCrashCallBack:exception];
}


- (void)catchCrashCallBack:(NSException *)exception {
    if ([exception.name isEqualToString:self.oldException.name] &&
        [exception.reason isEqualToString:self.oldException.reason]) {
        return;
    }
    self.oldException = exception;
    XMCrashProtectorBlock handel = [XMProtectorCrash shareProtecotor].handel;
    if (handel) {
        [XMProtectorCrashLog logCrashWithException:exception block:^(NSString *logError) {
            handel(exception,logError);
        }];
    }
}


@end
