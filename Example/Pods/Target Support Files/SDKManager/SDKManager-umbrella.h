#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SDKAlipayServiceImpl.h"
#import "AlipaySDK.h"
#import "APayAuthInfo.h"
#import "SDKManager.h"
#import "SDKPayService.h"
#import "SDKRegisterService.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"

FOUNDATION_EXPORT double SDKManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char SDKManagerVersionString[];

