//
//  NSDictionary+Safeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSDictionary+Safeguard.h"
#import "NSObject+XMExchange.h"

@implementation NSDictionary (Safeguard)

+ (void)openCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSPlaceholderDictionary = objc_getClass("__NSPlaceholderDictionary");
        [self exchangeInstanceMethodWithClass:__NSPlaceholderDictionary originalSel:@selector(initWithObjects:forKeys:count:) newSel:@selector(safe_initWithObjects:forKeys:count:)];
        [self exchangeInstanceMethodWithClass:__NSPlaceholderDictionary originalSel:@selector(dictionaryWithObjects:forKeys:count:) newSel:@selector(safe_dictionaryWithObjects:forKeys:count:)];
    });
}


- (instancetype)safe_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        
        //处理错误的数据，重新初始化一个字典
        NSUInteger index = 0;
        id   newObjects[cnt];
        id   newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safe_initWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

+ (instancetype)safe_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    id instance = nil;
    @try {
        instance = [self safe_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safe_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

@end
