//
//  SDKManager.h
//  xiangmu
//
//  Created by 湛思科技 on 16/12/7.
//  Copyright © 2016年 湛思科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SDKPlatformType) {
//    SDKPlatformQQ = 1,  // QQ
//    SDKPlatformWechat=2,  // 微信
    SDKPlatformAlipay=0   // 支付宝
};



@interface SDKManager : NSObject

// 读取配置文件注册第三方SDK
+ (void)registerPlatforms;

// 根据配置列表依次注册第三方SDK
//+ (void)registerWithPlatformConfigList:(NSArray*)configList;

// 统一处理各个SDK的回调
+ (BOOL)handleOpenURL:(NSURL*)url;

// 获取配置服务
+(id)getRegisterService:(SDKPlatformType)platformType;

+(id)getPayService:(SDKPlatformType)platformType;



@end
