//
//  ViewController.m
//  TestOnIphone
//
//  Created by MichaeOu on 2017/5/8.
//  Copyright © 2017年 康美. All rights reserved.
//

#import "ViewController.h"
#import "ASURLConnection.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self setque];
}


//请求数据
- (void)setque
{
    
    [ASURLConnection requestAFNJSon:@{} method:@"jumper.clinic.doctor.getClinicRuleList"  completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
//            //数组接受
//            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
//            for (NSDictionary *dic in dataArr)
//            {
//                RulesCustomModel *model = [[RulesCustomModel alloc] initWithDictionary:dic];
//                [_dataArray addObject:model];
//                
//                ViewCustomModel *ViewModel = [[ViewCustomModel alloc] initWithViewDictionary:dic];
//                [_headerArray addObject:ViewModel];
//            }
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
    
    
    NSDictionary *jsonDic = @{@"hosp_id":[NSNumber numberWithInteger:55]};
    
    [ASURLConnection requestAFNJSon:jsonDic method:@"jumper.netinte.hospital.checkhospital" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1])
        {
            
          
        }
    } errorBlock:^(NSError *error) {
        
    }];

}

@end
