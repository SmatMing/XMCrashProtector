//
//  NSObject+KVOSafeguard.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//
/**
 ①、警告：
 A addobserver B  A先dealloc  B未移除keypath的crash捕获不到，B先dealloc，B未移除keypath的crash可以捕获搭配
 1、重复添加相同的keyPath观察者，会重复调用 observeValueForKeyPath：...方法
 
 ②、crash情况：
 1、移除未被以KVO注册的观察者 会crash
 2、重复移除观察者 会crash
 
 此类用来管理混乱的KVO关系
 让被观察对象持有一个KVO的delegate，所有和KVO相关的操作均通过delegate来进行管理，delegate通过建立一张map来维护KVO整个关系
 
 好处：
 不会crash 1.如果出现KVO重复添加观察者或重复移除观察者（KVO注册观察者与移除观察者不匹配）的情况，delegate可以直接阻止这些非正常的操作。
 
 crash 2.被观察对象dealloc之前，可以通过delegate自动将与自己有关的KVO关系都注销掉，避免了KVO的被观察者dealloc时仍然注册着KVO导致的crash。
 
 注意：
 重复添加观察者不会crash，即不会走@catch
 多次添加对同一个属性观察的观察者，系统方法内部会强应用这个观察者，同理即可remove该观察者同样次数。
 
 */

#import <Foundation/Foundation.h>

@class KVOProxy;
@interface NSObject (KVOSafeguard)

@property (nonatomic, strong) KVOProxy * _Nullable KVOProxy;

+ (void)openCrashProtectorKVO;

@end
