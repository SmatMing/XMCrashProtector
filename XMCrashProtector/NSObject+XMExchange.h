//
//  NSObject+XMExchange.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/15.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "XMProtectorManager.h"

@interface NSObject (XMExchange)


/**
 MARK: - 交换类方法
 对类方法进行拦截并替换
 @ kClass 被拦截的具体类
 @param originalSelector 类的原类方法
 @param newSelector 替代方法
 */
+ (void)exchangeClassMethod:(SEL _Nonnull)originalSelector
                     newSel:(SEL _Nonnull)newSelector;

+ (void)exchangeClassMethodWithClass:(Class _Nonnull)kClass
                         originalSel:(SEL _Nonnull)originalSelector
                              newSel:(SEL _Nonnull)newSelector;


/**
 MARK: - 交换对象方法
 对对象的实例方法进行拦截并替换
 @ kClass 被拦截的具体类
 @param originalSelector 对象的原实例方法
 @param newSelector 替代方法
 */
+ (void)exchangeInstanceMethod:(SEL _Nonnull)originalSelector
                        newSel:(SEL _Nonnull)newSelector;

+ (void)exchangeInstanceMethodWithClass:(Class _Nonnull)kClass
                            originalSel:(SEL _Nonnull)originalSelector
                                 newSel:(SEL _Nonnull)newSelector;


@end
