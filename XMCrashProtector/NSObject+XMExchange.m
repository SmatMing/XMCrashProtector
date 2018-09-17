//
//  NSObject+XMExchange.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/15.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSObject+XMExchange.h"
#import <UIKit/UIKit.h>

@implementation NSObject (XMExchange)

//交换类方法
+ (void)exchangeClassMethod:(SEL _Nonnull)originalSelector
                     newSel:(SEL _Nonnull)newSelector {
    Class class = [self class];
    [self exchangeClassMethodWithClass:class originalSel:originalSelector newSel:newSelector];
}

+ (void)exchangeClassMethodWithClass:(Class _Nonnull)kClass
                         originalSel:(SEL _Nonnull)originalSelector
                              newSel:(SEL _Nonnull)newSelector {
    Method origMethod = class_getClassMethod(kClass, originalSelector);
    Method newMethod = class_getClassMethod(kClass, newSelector);
    Class metaKlass = objc_getMetaClass(NSStringFromClass(kClass).UTF8String);
    // class_addMethod:如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;如果方法没有存在,我们则先尝试添加被替换的方法的实现
    BOOL isAddMethod = class_addMethod(metaKlass,
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    if (isAddMethod) {
        class_replaceMethod(metaKlass, newSelector,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(origMethod, newMethod);
    }
}


//交换对象方法
+ (void)exchangeInstanceMethod:(SEL _Nonnull)originalSelector
                        newSel:(SEL _Nonnull)newSelector {
    Class class = [self class];
    [self exchangeInstanceMethodWithClass:class originalSel:originalSelector newSel:newSelector];
}

+ (void)exchangeInstanceMethodWithClass:(Class _Nonnull)kClass
                            originalSel:(SEL _Nonnull)originalSelector
                                 newSel:(SEL _Nonnull)newSelector {
    Method origMethod = class_getInstanceMethod(kClass, originalSelector);
    Method newMethod = class_getInstanceMethod(kClass, newSelector);
    // class_addMethod:如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;如果方法没有存在,我们则先尝试添加被替换的方法的实现
    BOOL isAddMethod = class_addMethod(kClass, originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    if (isAddMethod) {
        class_replaceMethod(kClass, newSelector,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(origMethod, newMethod);
    }
}


@end
