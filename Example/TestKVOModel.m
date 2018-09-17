//
//  TestKVOModel.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/12.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "TestKVOModel.h"

@implementation TestKVOModel
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"11111111");
}

- (void)dealloc {
    NSLog(@"TestKVOModel 被销毁了");
}

- (void)notifiaction:(NSNotification*)note {
    NSLog(@"收到通知");
}

@end
