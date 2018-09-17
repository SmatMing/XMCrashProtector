//
//  XMProtectorCrashLog.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/11.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMProtectorCrashLog : NSObject

+ (void)logCrashWithException:(NSException *)exception
                        block:(void(^)(NSString *logError))block;

@end
