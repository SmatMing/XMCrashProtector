//
//  NSMutableAttributedString+Safeguard.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "NSMutableAttributedString+Safeguard.h"
#import "NSObject+XMExchange.h"

@implementation NSMutableAttributedString (Safeguard)

+ (void)openCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dClass = NSClassFromString(@"NSConcreteMutableAttributedString");
        //initWithString:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(initWithString:) newSel:@selector(safe_initWithString:)];
        
        //initWithAttributedString
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(initWithString:attributes:) newSel:@selector(safe_initWithString:attributes:)];
        
        //initWithString:attributes:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(initWithAttributedString:) newSel:@selector(safe_initWithAttributedString:)];
        
        //4.replaceCharactersInRange:withString:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(replaceCharactersInRange:withString:) newSel:@selector(safe_replaceCharactersInRange:withString:)];
        
        //5.setAttributes:range:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(setAttributes:range:) newSel:@selector(safe_setAttributes:range:)];
        
        
        
        //6.addAttribute:value:range:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(addAttribute:value:range:) newSel:@selector(safe_addAttribute:value:range:)];
        
        //7.addAttributes:range:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(addAttributes:range:) newSel:@selector(safe_addAttributes:range:)];
        
        //8.removeAttribute:range:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(removeAttribute:range:) newSel:@selector(safe_removeAttribute:range:)];
        
        //9.replaceCharactersInRange:withAttributedString:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(replaceCharactersInRange:withAttributedString:) newSel:@selector(safe_replaceCharactersInRange:withAttributedString:)];
        
        
        //10.insertAttributedString:atIndex:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(insertAttributedString:atIndex:) newSel:@selector(safe_insertAttributedString:atIndex:)];
        
        
        //11.appendAttributedString:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(appendAttributedString:) newSel:@selector(safe_appendAttributedString:)];
        
        //12.deleteCharactersInRange:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(deleteCharactersInRange:) newSel:@selector(safe_deleteCharactersInRange:)];
        
        //13.setAttributedString:
        [self exchangeInstanceMethodWithClass:dClass originalSel:@selector(setAttributedString:) newSel:@selector(safe_setAttributedString:)];
        
    });
}

- (instancetype)safe_initWithString:(NSString *)str {
    id object = nil;
    @try {
        object = [self safe_initWithString:str];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

- (instancetype)safe_initWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    
    @try {
        object = [self safe_initWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

- (instancetype)safe_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self safe_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
        return object;
    }
}

-(void)safe_replaceCharactersInRange:(NSRange)range withString:(nonnull NSString *)aString {
    @try {
        [self safe_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}

-(void)safe_setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range {
    @try {
        [self safe_setAttributes:attrs range:range];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}

-(void)safe_addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range {
    @try {
        [self safe_addAttribute:name value:value range:range];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}
-(void)safe_addAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range {
    @try {
        [self safe_addAttributes:attrs range:range];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}

-(void)safe_removeAttribute:(NSAttributedStringKey)name range:(NSRange)range {
    @try {
        [self safe_removeAttribute:name range:range];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}

-(void)safe_replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString {
    @try {
        [self safe_replaceCharactersInRange:range withAttributedString:attrString];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}


-(void)safe_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc {
    @try {
        [self safe_insertAttributedString:attrString atIndex:loc];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}


-(void)safe_appendAttributedString:(NSAttributedString *)attrString {
    @try {
        [self safe_appendAttributedString:attrString];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}

-(void)safe_deleteCharactersInRange:(NSRange)range {
    @try {
        [self safe_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}

-(void)safe_setAttributedString:(NSAttributedString *)attrString {
    @try {
        [self safe_setAttributedString:attrString];
    }
    @catch (NSException *exception) {
        XMCrashProtectionLog(exception, XMCrashProtectorTypeContainer);
    }
    @finally {
    }
}


@end
