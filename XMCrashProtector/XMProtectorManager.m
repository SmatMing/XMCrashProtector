//
// Created by xuzhangming on 2018/8/21.
// Copyright (c) 2018 xuzhangming. All rights reserved.
//

#import "XMProtectorManager.h"

static XMCrashProtectorBlock _crashProtector;

@implementation XMProtectorManager

//打开目前所支持的所有crash保护 回调block
+ (void)openCrashProtectorType:(XMCrashProtectorType)crashType
                     withBlock:(XMCrashProtectorBlock)block {
    if (block) {
        _crashProtector = block;
    }
    [[XMProtectorCrash shareProtecotor] openCrashProtector:crashType];
}

//crash 日志
+ (void)logCrashWithException:(NSException *)exception
                    crashType:(XMCrashProtectorType)crashType {
    //__weak __typeof(self) weakSelf = self;
    NSException *oldExc = [XMProtectorCrash shareProtecotor].exception;
    if ([exception.name isEqualToString:oldExc.name] &&
        [exception.reason isEqualToString:oldExc.reason]) {
        return;
    }
    [XMProtectorCrash shareProtecotor].exception = exception;
    [XMProtectorCrashLog logCrashWithException:exception block:^(NSString *logError) {
        if (_crashProtector) {
            XMLog(@"%@", logError);
            _crashProtector(exception,logError,crashType);
        }
    }];
}


@end
