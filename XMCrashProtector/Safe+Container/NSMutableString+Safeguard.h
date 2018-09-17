//
//  NSMutableString+Safeguard.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//
/*
 除NSString的一些方法外又额外避免了一些方法crash
 
 1.- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
 2.- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange;
 3.- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
 4.- (void)deleteCharactersInRange:(NSRange)range;
 5.- (void)appendString:(NSString *)aString;
 6.- (void)setString:(NSString *)aString;
 
 */

#import <Foundation/Foundation.h>

@interface NSMutableString (Safeguard)

@end
