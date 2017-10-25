//
//  SDKAlipayServiceImpl.h
//  xiangmu
//
//  Created by 湛思科技 on 16/12/7.
//  Copyright © 2016年 湛思科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDKRegisterService.h"
#import "SDKPayService.h"

//#import 
//#import "SDK"

#define kMsgPayUserCancelled @"用户取消"
#define kMsgPayNetworkFailed @"网络连接错误"
#define kMsgPayFailue @"支付失败"
#define kMsgPayProcessing @"支付处理中"
#define kMsgPaySuccess @"支付成功"
#define kAdvPurchaseSuccessNotification @"kAdvPurchaseSuccessNotification"

@interface SDKAlipayServiceImpl : NSObject<SDKRegisterService,SDKPayService>

@end
