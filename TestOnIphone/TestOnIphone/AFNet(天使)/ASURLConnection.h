//
//  ASURLConnection.h
//  AngelSound
//
//  Created by jumper on 15-1-15.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

#import "DesEncrypt.h"



#define pKey @"*JUMPER*"       //DES加密key
#define sKey @"JUMPER2014API"  //MD5加密key
#define normalUrl @"http://mobile.jumper-health.com"//正式接口
#define testUrl @"http://10.0.1.115:8081" //测试接口
#define testDataUrl  @"http://10.0.1.68:8081"

#define baseModel @"%@/mobile/api%@/handler.do?method=%@&params=%@&sign=%@" //URL

//#define baseModel @"%@/mobile/api/v3/handler.do?method=%@&params=%@&sign=%@" //URL V3
typedef void (^completeBlock_tt)(NSData *data,id responseObject);

typedef void (^errorBlock_t)(NSError *error);

@interface ASURLConnection : NSObject

/**
 *  解密请求数据
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecrypt:(id)data;

/**
 *  解密支付宝请求数据，因为里面的加号不能替换
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecryptWithZhifubao:(id)data;

/**
 *  获取请求状态值
 *  @return msg（int）
 */
+(NSNumber *)getMsg:(id)data;

/**
 *  获取请求后的文字提示
 *  @return message
 */
+(NSString *)getMessage:(id )data;



/**
 *  AFN 请求
 *
 dic         :参数字典
 method      :请求方法
 view        :父视图
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+(void)requestAFNJSon:(NSDictionary *)dic
               method:(NSString *)method
        completeBlock:(completeBlock_tt)completeBlock
           errorBlock:(errorBlock_t)errorBlock;

+(void)requestAFNJSon:(NSDictionary *)dic method:(NSString *)method view:(UIView *)view version:(NSString *)string completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock;

@end
