//
//  NSMutableArray+SortTools.h
//  TestOnIphone
//
//  Created by MichaeOu on 2017/6/12.
//  Copyright © 2017年 康美. All rights reserved.
//

#import <Foundation/Foundation.h>

//比较算法的块定义
//若需要置换返回YES，否则返回NO
typedef BOOL (^compareElement)(NSObject * el1, NSObject *el2);

@interface NSMutableArray (SortTools)
/*
 * 通过N-1次对剩余未排序元素中最大或最小元素的上浮来实现排序。
 * 上浮通过交换相邻元素实现
 */
- (void) sortByBubble:(compareElement) cmpBlock;
/*
 *通过N-1次将剩余未排序元素中最大（小）元素放置到数组尾部来实现排序。
 */
- (void) sortByChoose:(compareElement) cmpBlock;
/*
 *插入排序使用的是增量（incremental）方法；在排好子数组A[1..j-1]后，将A[j]插入，形成排好序的子数组A[1..j]；
 */
- (void) sortByInsert:(compareElement) cmpBlock;
/*
 * 内容是否一样
 */
- (BOOL) isTheSame:(NSArray *)otherArray
 usingCompareBlock:(compareElement) cmpBlock;

@end
