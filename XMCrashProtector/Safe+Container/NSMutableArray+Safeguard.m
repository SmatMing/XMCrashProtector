//
//  NSMutableArray+Safeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSMutableArray+Safeguard.h"
#import <UIKit/UIKit.h>
#import "NSObject+XMExchange.h"

@implementation NSMutableArray (Safeguard)

+ (void)openCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //方法交换只要一次就好
        Class dClass=NSClassFromString(@"__NSArrayM");
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(objectAtIndex:) newSel:@selector(safe_objectAtIndexM:)];
        
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(objectAtIndexedSubscript:) newSel:@selector(safe_objectAtIndexedSubscript:)];
        
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(insertObject:atIndex:) newSel:@selector(safe_insertObject:atIndex:)];
        
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(removeObjectAtIndex:) newSel:@selector(safe_removeObjectAtIndex:)];
        
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(replaceObjectAtIndex:withObject:) newSel:@selector(safe_replaceObjectAtIndex:withObject:)];
        
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(setObject:atIndexedSubscript:) newSel:@selector(safe_setObject:atIndexedSubscript:)];
        
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(getObjects:range:) newSel:@selector(safe_getObjects:range:)];
    });
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)index {
    id object=nil;
    @try {
        object =  [self safe_objectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

- (id)safe_objectAtIndexM:(NSUInteger)index {
    id object=nil;
    @try {
        object= [self safe_objectAtIndexM:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}


- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self safe_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        
    }
}


- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self safe_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        
    }
}


- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    
    @try {
        [self safe_replaceObjectAtIndex:index withObject:anObject];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        
    }
}

- (void)safe_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self safe_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}

- (void)safe_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self safe_getObjects:objects range:range];
    } @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    } @finally {
    }
}



@end
