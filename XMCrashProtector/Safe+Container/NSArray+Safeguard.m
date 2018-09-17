//
//  NSArray+Safeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSArray+Safeguard.h"
#import "NSObject+XMExchange.h"

@implementation NSArray (Safeguard)

+ (void)openCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArray = objc_getClass("NSArray");
        Class __NSPlacehodelrArray = objc_getClass("__NSPlaceholderArray");
        Class __NSArrayI = objc_getClass("__NSArrayI");
        Class __NSSingleObjectArrayI = objc_getClass("__NSSingleObjectArrayI");
        Class __NSArray0 = objc_getClass("__NSArray0");
        
        [self exchangeInstanceMethodWithClass:__NSPlacehodelrArray originalSel:@selector(initWithObjects:count:) newSel:@selector(safe_initWithObjects:count:)];
        
        [self exchangeInstanceMethodWithClass:__NSArrayI originalSel:@selector(objectAtIndex:) newSel:@selector(safe_objectAtIndexI:)];
        
        [self exchangeInstanceMethodWithClass:__NSArrayI originalSel:@selector(objectAtIndexedSubscript:) newSel:@selector(safe_objectAtIndexedSubscriptI:)];
        
        [self exchangeInstanceMethodWithClass:__NSArray0 originalSel:@selector(objectAtIndex:) newSel:@selector(safe_objectAtIndex0:)];
        
        [self exchangeInstanceMethodWithClass:__NSSingleObjectArrayI originalSel:@selector(objectAtIndex:) newSel:@selector(safe_objectAtIndexSI:)];
        
        [self exchangeInstanceMethodWithClass:__NSArray originalSel:@selector(objectsAtIndexes:) newSel:@selector(safe_objectsAtIndexes:)];
        
        // 以下方法调用频繁，替换可能会影响性能
        // getObjects:range:
        [self exchangeInstanceMethodWithClass:__NSArray originalSel:@selector(getObjects:range:) newSel:@selector(safe_getObjectsNSArray:range:)];
        [self exchangeInstanceMethodWithClass:__NSSingleObjectArrayI originalSel:@selector(getObjects:range:) newSel:@selector(safe_getObjectsNSSingleObjectArrayI:range:)];
        [self exchangeInstanceMethodWithClass:__NSArrayI originalSel:@selector(getObjects:range:) newSel:@selector(safe_getObjectsNSArrayI:range:)];
    });
}


- (instancetype)safe_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id   newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil && ![objects[i] isEqual:[NSNull null]]) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self safe_initWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}

-( id)safe_objectAtIndexedSubscriptI:(NSUInteger)index {
    id object=nil;
    @try {
        object = [self safe_objectAtIndexedSubscriptI:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

- (id)safe_objectAtIndexI:(NSUInteger)index {
    id object=nil;
    @try {
        object = [self safe_objectAtIndexI:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

- (id)safe_objectAtIndex0:(NSUInteger)index {
    id object=nil;
    @try {
        object = [self safe_objectAtIndex0:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

- (id)safe_objectAtIndexSI:(NSUInteger)index {
    id object=nil;
    @try {
        object = [self safe_objectAtIndexSI:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

- (id)safe_objectsAtIndexes:(NSIndexSet *)indexes {
    NSArray *returnArray = nil;
    @try {
        returnArray = [self safe_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    } @finally {
        return returnArray;
    }
}

#pragma mark getObjects:range:
- (void)safe_getObjectsNSArray:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self safe_getObjectsNSArray:objects range:range];
    } @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    } @finally {
    }
}

- (void)safe_getObjectsNSSingleObjectArrayI:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self safe_getObjectsNSSingleObjectArrayI:objects range:range];
    } @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    } @finally {
    }
}

- (void)safe_getObjectsNSArrayI:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self safe_getObjectsNSArrayI:objects range:range];
    } @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    } @finally {
    }
}


@end
