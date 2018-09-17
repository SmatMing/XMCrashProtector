//
//  NSAttributedString+Safeguard.h
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
 
 */
#import <Foundation/Foundation.h>

@interface NSAttributedString (Safeguard)

@end
