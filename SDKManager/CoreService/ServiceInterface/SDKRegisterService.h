//
//  SDKRegisterService.h
//  xiangmu
//
//  Created by 湛思科技 on 16/12/7.
//  Copyright © 2016年 湛思科技. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const SDKConfigAppIdKey;
FOUNDATION_EXTERN NSString *const SDKConfigAppSecretKey;
FOUNDATION_EXTERN NSString *const SDKConfigAppSchemeKey;
FOUNDATION_EXTERN NSString *const SDKConfigAppPlatformTypeKey;


@protocol SDKRegisterService <NSObject>

@required

/*!
 *  @brief  每个注册SDK自行管理其服务单例
 *
 *  @return 返回SDK服务实现的单例
 */
+ (instancetype)sharedService;

/*!
 *  @brief  检测第三方SDK应用是否安装
 *
 *  @return 已安装返回YES，否则返回NO
 */
- (BOOL)isPlatformAppInstalled;

/*!
 *  @brief  注册获取第三方SDK使用权限
 */
- (void)registerWithPlatformConfig:(NSDictionary*)config;

/*!
 *  @brief  判断是否已经获取注册权限
 */
- (BOOL)isRegistered;

/*!
 *  @brief  统一处理第三方SDK应用的处理回调
 *
 *  @param url fixMe
 *
 *  @return 处理成功返回YES，否则返回NO
 */
- (BOOL)handleResultUrl:(NSURL *)url;

@end
