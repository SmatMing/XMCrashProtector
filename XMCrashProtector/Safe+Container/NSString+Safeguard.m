//
//  NSString+Safeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSString+Safeguard.h"
#import "NSObject+XMExchange.h"

@implementation NSString (Safeguard)

+ (void)openCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dClass= NSClassFromString(@"__NSCFConstantString");
        Class NSPlaceholderStringClass = NSClassFromString(@"NSPlaceholderString");
        //initWithString:
        [self exchangeInstanceMethodWithClass:NSPlaceholderStringClass originalSel:@selector(initWithString:) newSel:@selector(safe_initWithString:)];
        
        //hasPrefix
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(hasPrefix:) newSel:@selector(safe_hasPrefix:)];
        
        //hasSuffix
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(hasSuffix:) newSel:@selector(safe_hasSuffix:)];
        
        //substringFromIndex
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(substringFromIndex:) newSel:@selector(safe_substringFromIndex:)];
        
        //substringToIndex
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(substringToIndex:) newSel:@selector(safe_substringToIndex:)];
        
        //substringWithRange
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(substringWithRange:) newSel:@selector(safe_substringWithRange:)];
        
        //characterAtIndex
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(characterAtIndex:) newSel:@selector(safe_characterAtIndex:)];
        
        //stringByReplacingOccurrencesOfString:withString:options:range:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) newSel:@selector(safe_stringByReplacingOccurrencesOfString:withString:options:range:)];
        
        
        //stringByReplacingCharactersInRange:withString:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(stringByReplacingCharactersInRange:withString:) newSel:@selector(safe_stringByReplacingCharactersInRange:withString:)];
        
        //rangeOfString:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(rangeOfString:) newSel:@selector(safe_rangeOfString:)];
        
    });
}


-(instancetype)safe_initWithString:(NSString *)aString {
    id instance = nil;
    @try {
        instance = [self safe_initWithString:aString];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return instance;
    }
}

-(BOOL)safe_hasPrefix:(NSString *)str {
    BOOL has = NO;
    @try {
        has = [self safe_hasPrefix:str];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return has;
    }
}

-(BOOL)safe_hasSuffix:(NSString *)str {
    BOOL has = NO;
    @try {
        has = [self safe_hasSuffix:str];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return has;
    }
}

- (NSString *)safe_substringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    @try {
        subString = [self safe_substringFromIndex:from];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)safe_substringToIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self safe_substringToIndex:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)safe_substringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    @try {
        subString = [self safe_substringWithRange:range];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (unichar)safe_characterAtIndex:(NSUInteger)index {
    
    unichar characteristic;
    @try {
        characteristic = [self safe_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return characteristic;
    }
}

- (NSString *)safe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safe_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


- (NSString *)safe_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safe_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

- (NSRange)safe_rangeOfString:(NSString *)searchString {
    NSRange rang = NSMakeRange(0, 0);
    
    @try {
        rang = [self safe_rangeOfString:searchString];
    } @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
       
    } @finally {
        return rang;
    }
}


@end
