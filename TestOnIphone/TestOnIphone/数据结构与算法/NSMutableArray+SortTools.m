//
//  NSMutableArray+SortTools.m
//  TestOnIphone
//
//  Created by MichaeOu on 2017/6/12.
//  Copyright © 2017年 康美. All rights reserved.
//

#import "NSMutableArray+SortTools.h"

@implementation NSMutableArray (SortTools)
/*
 *通过N-1次对剩余未排序元素中最大或最小元素的上浮来实现排序。
 *上浮通过交换相邻元素实现
 */
- (void) sortByBubble:(compareElement) cmpBlock
{
    NSObject *temp = nil;
    for(int i = 0; i < self.count - 1; i++){
        for(int j = 0; j < self.count - 1 - i; j++){
            if (cmpBlock([self objectAtIndex:j], [self objectAtIndex:j+1])) {
                temp = [self objectAtIndex:j];
                [self replaceObjectAtIndex:j
                                withObject:[self objectAtIndex:j+1]];
                [self replaceObjectAtIndex:j+1 withObject:temp];
            }
        }
    }
    temp = nil;
}

- (void) sortByChoose:(compareElement) cmpBlock{
    NSObject *temp = nil;
    NSInteger maxIndex = 0;
    for (int i = 0; i < self.count - 1; i++) {
        maxIndex = 0;
        for (int j = 0; j < self.count - 1 - i; j++) {
            if (cmpBlock([self objectAtIndex:maxIndex], [self objectAtIndex:j])) {
                maxIndex = j;
            }
        }
        temp = [self objectAtIndex:self.count - 1 - i];
        [self replaceObjectAtIndex:self.count - 1 - i
                        withObject:[self objectAtIndex:maxIndex]];
        [self replaceObjectAtIndex:maxIndex withObject:temp];
    }
    temp = nil;
}
/*
 *插入排序使用的是增量（incremental）方法；在排好子数组A[1..j-1]后，将A[j]插入，形成排好序的子数组A[1..j]；
 */
- (void) sortByInsert:(compareElement) cmpBlock{
    NSObject *temp = nil;
    for (int i = 1; i < self.count; i++) {
        temp = [self objectAtIndex:i];
        int j = 0;
        for (j = i; j > 0 && cmpBlock(temp, [self objectAtIndex:j-1]) ; j--) {
            [self replaceObjectAtIndex:j withObject:[self objectAtIndex:j-1]];
        }
        [self replaceObjectAtIndex:j withObject:temp];
    }
}

/*
 * 内容是否一样
 */
- (BOOL) isTheSame:(NSArray *)otherArray
 usingCompareBlock:(compareElement) cmpBlock{
    
    BOOL isSame = YES;
    
    if (self.count != otherArray.count) {
        isSame = NO;
    } else {
        for (int i = 0; i < self.count; i++) {
            if ([self objectAtIndex:i] == nil) {
                continue;
            }
            
            if (!cmpBlock([self objectAtIndex:i], [otherArray objectAtIndex:i])) {
                isSame = NO;
                break;
            }
        }
    }
    
    return isSame;
}


@end
