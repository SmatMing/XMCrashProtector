//
// Created by xuzhangming on 2018/8/21.
// Copyright (c) 2018 xuzhangming. All rights reserved.
//

#import "XMProtectorManager.h"

@implementation XMProtectorManager

//打开目前所支持的所有crash保护 回调block
+ (void)openCrashProtectorType:(XMCrashProtectorType)crashType
                     withBlock:(XMCrashProtectorBlock)block {
    [[XMProtectorCrash shareProtecotor] openCrashProtector:crashType handel:block];
}



@end
