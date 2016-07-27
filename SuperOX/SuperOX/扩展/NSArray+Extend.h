//
//  NSArray+Extend.h
//  SuperOX
//
//  Created by changxicao on 16/7/27.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extend)

- (NSArray *)arrayWithObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (NSArray *)arrayByRemovingObjectsOfClass:(Class)aClass;
- (NSArray *)arrayByKeepingObjectsOfClass:(Class)aClass;
- (NSArray *)arrayByRemovingObjectsFromArray:(NSArray *)otherArray;

- (NSArray *)transformedArrayUsingHandler:(id (^)(id originalObject, NSUInteger index))handler;
- (NSArray *)reverseArray;
@end


@interface NSMutableArray (Extend)

+ (NSMutableArray *)nullArrayWithCapacity:(NSUInteger)capacity;
- (void)removeObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
- (void)removeLatterObjectsToKeepObjectsNoMoreThan:(NSInteger)maxCount;
- (void)replaceObject:(id)anObject withObject:(id)anotherObject;
- (void)insertUniqueObject:(id)anObject;
- (void)insertUniqueObject:(id)anObject atIndex:(NSInteger)index;
- (void)insertUniqueObjectsFromArray:(NSArray *)otherArray;
- (void)appendUniqueObjectsFromArray:(NSArray *)otherArray;
- (void)moveObjectAtIndex:(NSUInteger)fromIdx toIndex:(NSUInteger)toIdx;
- (void)insertNewestUniqueObject:(id)anObject;
- (void)insertNewestUniqueObject:(id)anObject atIndex:(NSInteger)index;
@end
