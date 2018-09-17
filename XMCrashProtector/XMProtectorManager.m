//
// Created by xuzhangming on 2018/8/21.
// Copyright (c) 2018 xuzhangming. All rights reserved.
//

#import "XMProtectorManager.h"
#import "XMProtectorCrash.h"

static XMCrashProtectorBlock _crashProtector;

@implementation XMProtectorManager

//打开目前所支持的所有crash保护 回调block
+ (void)openAllCrashProtectorWithBlock:(XMCrashProtectorBlock)block {
    if (block) {
        _crashProtector = block;
    }
    [XMProtectorCrash openAllCrashProtector];    
}

//crash 日志
+ (void)logCrashWithException:(NSException *)exception
                    crashType:(XMCrashProtectorType)crashType {
    //__weak __typeof(self) weakSelf = self;
    [XMProtectorCrashLog logCrashWithException:exception block:^(NSString *logError) {
        if (_crashProtector) {
            XMLog(@"%@", logError);
            _crashProtector(exception,logError,crashType);
        }
    }];
}


@end
