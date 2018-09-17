//
//  NSMutableArray+Safeguard.h
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/17.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//
/**
 可避免以下crash
 
 1. - (void)addObject:(ObjectType)anObject(实际调用insertObject:)
 2. - (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;
 3. - (id)objectAtIndex:(NSUInteger)index( 包含   array[index]  形式  )
 4. - (void)removeObjectAtIndex:(NSUInteger)index
 5. - (void)replaceObjectAtIndex:(NSUInteger)index
 
 */

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safeguard)

@end
