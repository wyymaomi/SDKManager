//
//  SDKManager.m
//  xiangmu
//
//  Created by 湛思科技 on 16/12/7.
//  Copyright © 2016年 湛思科技. All rights reserved.
//

#import "SDKManager.h"
#import "SDKRegisterService.h"
#import "SDKPayService.h"

NSString *const SDKConfigAppIdKey = @"appId";
NSString *const SDKConfigAppSecretKey = @"appSecret";
NSString *const SDKConfigAppSchemeKey = @"appScheme";
NSString *const SDKConfigAppPlatformTypeKey = @"appPlatformType";
NSString *const SDKConfigAppDescriptionKey = @"appDescription";
NSString *const SDKConfigAppServiceProvider = @"serviceProvider";


static NSArray *sdkServiceConfigList = nil;

@implementation SDKManager

#pragma mark - 根据配置列表依次注册

+ (void)registerPlatforms
{
    NSArray *sdkServiceConfigList;
    if (sdkServiceConfigList == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SDKServiceConfig" ofType:@"plist"];
        sdkServiceConfigList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    
    [self registerWithPlatformConfigList:sdkServiceConfigList];
}

+ (void)registerWithPlatformConfigList:(NSArray*)configList;
{
    if (configList == nil || configList.count == 0) {
        return;
    }
    
    for (NSDictionary *platformConfig in configList) {
        SDKPlatformType platformType = [platformConfig[SDKConfigAppPlatformTypeKey] integerValue];
        Class registerServiceImpl = [[self class] getServiceProviderWithPlatformType:platformType];//[[self class] getRegisterService:platformType];
        if (registerServiceImpl != nil) {
            [[registerServiceImpl sharedService] registerWithPlatformConfig:platformConfig];
        }
    }
}

#pragma mark - 处理应用回调URL

+(BOOL)handleOpenURL:(NSURL *)url
{
    if (sdkServiceConfigList == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SDKServiceConfig" ofType:@"plist"];
        sdkServiceConfigList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    
    for (NSDictionary *sdkServiceConfig in sdkServiceConfigList) {
        Class serviceProvider = NSClassFromString(sdkServiceConfig[SDKConfigAppServiceProvider]);
        if (serviceProvider) {
            if ([[serviceProvider sharedService] conformsToProtocol:@protocol(SDKRegisterService)]) {
                if ([[serviceProvider sharedService] handleResultUrl:url]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}


+ (id)getRegisterService:(SDKPlatformType)type
{
    Class sharedServiceImplCls = [self getServiceProviderWithPlatformType:type];
    if (sharedServiceImplCls) {
        if ([[sharedServiceImplCls sharedService] conformsToProtocol:@protocol(SDKRegisterService)]) {
            return [sharedServiceImplCls sharedService];
        }
    }
    return nil;
}

#pragma mark - 根据平台获取服务提供者
+(Class)getServiceProviderWithPlatformType:(SDKPlatformType)platformType
{
    if (sdkServiceConfigList == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SDKServiceConfig" ofType:@"plist"];
        sdkServiceConfigList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    
    Class serviceProvider = nil;
    
    for (NSDictionary *platformConfig in sdkServiceConfigList) {
        // find the specified platform
        if ([platformConfig[SDKConfigAppPlatformTypeKey] integerValue] == platformType) {
            serviceProvider = NSClassFromString(platformConfig[SDKConfigAppServiceProvider]);
            break;
        }
    }
    
    return serviceProvider;
    
}

#pragma mark - 获取支付服务提供者

+(id)getPayService:(SDKPlatformType)platformType
{
    Class sharedServiceImplCls = [self getServiceProviderWithPlatformType:platformType];
    if (sharedServiceImplCls != nil) {
        if ([[sharedServiceImplCls sharedService] conformsToProtocol:@protocol(SDKPayService)]) {
            return [sharedServiceImplCls sharedService] ;
        }
    }
    
    return nil;
}

@end
