//
//  ASURLConnection.m
//  AngelSound
//
//  Created by jumper on 15-1-15.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASURLConnection.h"
#import "JSONKit.h"

#define time 5.0f
@implementation ASURLConnection
{
    NSMutableData *_data;
    completeBlock_tt _completeBlock;
    errorBlock_t _errorBlock;
}
////////////////////////////////////////////////////////////////////// 加密  //////////////////////////////////////////////////////////////////////
/**
 *  加密URL
 *
 *  jsondic    :参数
 *  method     :方法
 *
 *  @return url 加密后的URL
 */
+(NSString *)doDEStoGetJson:(NSDictionary *)jsondict andMethod:(NSString *)method andVersion:(NSString *)version{
    NSString *jsonString = [jsondict JSONString];
//    jsonString = [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *des = [[DesEncrypt encryptUseDES:jsonString key:pKey] uppercaseString];
    NSString *md5 = [[DesEncrypt md5:[NSString stringWithFormat:@"%@method%@params%@%@",sKey,method,des,sKey] ]uppercaseString];
    NSString *url;
    url = [NSString stringWithFormat:baseModel,normalUrl,version,method,des,md5];
    return url;
}

/**
 *  解密请求数据
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecrypt:(id)data
{
    
    NSString *str = [DesEncrypt decryptUseDES:data key:@"*JUMPER*"];
    str = [str  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [str stringByReplacingOccurrencesOfString:@"+"withString:@" "];
//    return str;
}
/**
 *  解密支付宝请求数据，因为里面的加号不能替换
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecryptWithZhifubao:(id)data{
    NSString *str = [DesEncrypt decryptUseDES:data key:@"*JUMPER*"];
    str = [str  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str;
}
/**
 *  获取请求状态值
 *  @return msg（int）
 */
+(NSNumber *)getMsg:(id)data {
    NSNumber *msg = [(NSDictionary *)[[self doDESDecrypt:data] objectFromJSONString]objectForKey:@"msg"];
    return msg;
}

/**
 *  获取请求后的文字提示
 *  @return message
 */
+(NSString *)getMessage:(id )data{
    NSString *message = [(NSDictionary *)[[self doDESDecrypt:data] objectFromJSONString]objectForKey:@"msgbox"];
    return message;
}


////////////////////////////////////////////////////////////////////// 请求 //////////////////////////////////////////////////////////////////////


/**
 *  AFN 请求
 *
 *  dic         :参数字典
 *  method      :请求方法
    completeBlock  : 完成请求后的处理
    errorBlock     : 请求出错后的处理
 */
+(void)requestAFNJSon:(NSDictionary *)dic method:(NSString *)method  completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:@""];
        url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];

        //    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = time;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSLog(@"url = %@",url);

        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
            });
    
            k_NslogDesData
            completeBlock(nil,responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorBlock(error);
            k_NslogError
        
           
        }];
    });
    
}


+(void)requestAFNJSon:(NSDictionary *)dic method:(NSString *)method view:(UIView *)view version:(NSString *)string completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
   
    if(view){
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:string];
        url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
        //    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = time;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(view){
                
              
            }
            k_NslogDesData
            completeBlock(nil,responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorBlock(error);
            k_NslogError
            if(view){
                
                        }
        }];
    });
    
}

@end
