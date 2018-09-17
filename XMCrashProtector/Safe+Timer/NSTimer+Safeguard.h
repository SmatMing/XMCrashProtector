//
//  NSTimer+Safeguard.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//
//通过scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:创建定时器开启重复性任务的时候,NSTimer会 强引用 target实例导致target不能被及时释放,造成内存泄露，因此需要要在适当的时机将其释放。

//可参考MSWeakTimer:https://github.com/mindsnacks/MSWeakTimer

#import <Foundation/Foundation.h>

@interface NSTimer (Safeguard)

@end
