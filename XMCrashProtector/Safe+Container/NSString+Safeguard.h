//
//  NSString+Safeguard.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//
/**
 *  Can avoid crash method
 *
 1. initWithString
 2. hasPrefix
 3. hasSuffix
 4. substringFromIndex:(NSUInteger)from
 5. substringToIndex:(NSUInteger)to {
 6. substringWithRange:(NSRange)range {
 7. characterAtIndex:(NSUInteger)index
 8. stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement 实际上调用的是9方法
 9. stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
 10. stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
 
 */

#import <Foundation/Foundation.h>

@interface NSString (Safeguard)

@end
