//
//  NSMutableAttributedString+Safeguard.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

/*
 目前可避免以下方法crash
 1.- (instancetype)initWithString:(NSString *)str;
 2.- (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
 3.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr;
 
 4. - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str;
 5.- (void)setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;
 
 6.- (void)addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;
 7.- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;
 8.- (void)removeAttribute:(NSAttributedStringKey)name range:(NSRange)range;
 
 9.- (void)replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString;
 10.- (void)insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc;
 11.- (void)appendAttributedString:(NSAttributedString *)attrString;
 12.- (void)deleteCharactersInRange:(NSRange)range;
 13.- (void)setAttributedString:(NSAttributedString *)attrString;
 
 
 */

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Safeguard)

@end
