//
//  ViewController.m
//  TestOnIphone
//
//  Created by MichaeOu on 2017/5/8.
//  Copyright © 2017年 康美. All rights reserved.
//

#import "ViewController.h"
#import "ASURLConnection.h"

#import "NSMutableArray+SortTools.h"
#import <OpenGLES/ES1/gl.h>

@interface ViewController ()


@property (nonatomic, strong) NSMutableArray *testBubbleBefore;
@property (nonatomic, strong) NSMutableArray *testBubbleAfter;
@property (nonatomic, strong) NSMutableArray *testChooseAfter;
@property (nonatomic, strong) NSMutableArray *testChooseBefore;
@property (nonatomic, strong) NSMutableArray *testInsertB;
@property (nonatomic, strong) NSMutableArray *testInsertA;

@end

@implementation ViewController

@synthesize testBubbleBefore, testBubbleAfter, testChooseAfter, testChooseBefore;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    [self setUp];
    //[self tearDown];
    [self testBubble];
}

- (void)buttonClick
{

    [self setque];
    
}


//请求数据
- (void)setque
{
    
    [ASURLConnection requestAFNJSon:@{} method:@"jumper.clinic.doctor.getClinicRuleList"  completeBlock:^(NSData *data, id responseObject) {
        
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            //数组接受
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            NSLog(@"%@===dataArr.count=%ld",dataArr,dataArr.count);
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
    
  
}



- (void)setUp
{
    //[super setUp];
    
    // Set-up code here.
    self.testBubbleBefore = [NSMutableArray arrayWithObjects:@45, @2, @63,@11, nil];
    
    self.testBubbleAfter = [NSMutableArray arrayWithObjects:@2, @11, @45,@63, nil];
    
    self.testChooseBefore = [NSMutableArray arrayWithObjects:@45, @2, @63,@11, nil];
    
    self.testChooseAfter = [NSMutableArray arrayWithObjects:@2, @11, @45,@63, nil];
    
    self.testInsertB = [NSMutableArray arrayWithObjects:@45, @2, @63,@11, nil];
    
    self.testInsertA = [NSMutableArray arrayWithObjects:@2, @11, @45,@63, nil];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [self.testBubbleBefore removeAllObjects];
    [self.testBubbleAfter removeAllObjects];
    [self.testChooseBefore removeAllObjects];
    [self.testChooseAfter removeAllObjects];
    [self.testInsertB removeAllObjects];
    [self.testInsertA removeAllObjects];
    
}

/*
 *冒泡测试
 */
- (void)testBubble
{
    
    
    [self.testBubbleBefore sortByBubble:^BOOL(NSObject *el1, NSObject *el2) {
        __weak NSNumber *n1 = (NSNumber *)el1;
        __weak NSNumber *n2 = (NSNumber *)el2;
        return n1.intValue > n2.intValue;
    }];
    
    BOOL isSame = [self.testBubbleBefore isTheSame:self.testBubbleAfter usingCompareBlock:^BOOL(NSObject *el1, NSObject *el2) {
        __weak NSNumber *n1 = (NSNumber *)el1;
        __weak NSNumber *n2 = (NSNumber *)el2;
        return n1.intValue == n2.intValue;
    }];
    STAssertTrue(isSame, @"testBefore is not the same as testAfter!");
    
}

/*
 *选择排序测试
 */
- (void)testChoose
{
    
    
    [self.testChooseBefore sortByChoose:^BOOL(NSObject *el2, NSObject *el1) {
        __weak NSNumber *n2 = (NSNumber *)el2;
        __weak NSNumber *n1 = (NSNumber *)el1;
        return n1.intValue > n2.intValue;
    }];
    
    BOOL isSame = [self.testChooseBefore isTheSame:self.testChooseAfter usingCompareBlock:^BOOL(NSObject *el1, NSObject *el2) {
        __weak NSNumber *n1 = (NSNumber *)el1;
        __weak NSNumber *n2 = (NSNumber *)el2;
        return n1.intValue == n2.intValue;
    }];
    STAssertTrue(isSame, @"testBefore is not the same as testAfter!");
    
}

/*
 *插入排序测试
 */
- (void)testInsert
{
    
    
    [self.testInsertB sortByInsert:^BOOL(NSObject *el2, NSObject *el1) {
        __weak NSNumber *n1 = (NSNumber *)el1;
        __weak NSNumber *n2 = (NSNumber *)el2;
        return n1.intValue > n2.intValue;
    }];
    
    BOOL isSame = [self.testInsertB isTheSame:self.testInsertA usingCompareBlock:^BOOL(NSObject *el1, NSObject *el2) {
        __weak NSNumber *n1 = (NSNumber *)el1;
        __weak NSNumber *n2 = (NSNumber *)el2;
        return n1.intValue == n2.intValue;
    }];
    STAssertTrue(isSame, @"testBefore is not the same as testAfter!");
    
}

@end

