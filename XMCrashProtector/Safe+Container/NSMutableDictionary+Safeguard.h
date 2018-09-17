//
//  NSMutableDictionary+Safeguard.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//
/*
 目前可避免以下crash
 
 1.直接调用 setObject:forKey
 2.通过下标方式赋值的时候，value为nil不会崩溃
 iOS11之前会调用 setObject:forKey
 iOS11之后（含11)  setObject:forKeyedSubscript:
 3.removeObjectForKey
 
 */
#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safeguard)

@end
