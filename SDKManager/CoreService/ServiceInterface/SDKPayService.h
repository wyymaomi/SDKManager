//
//  SDKPayService.h
//  xiangmu
//
//  Created by 湛思科技 on 16/12/7.
//  Copyright © 2016年 湛思科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SDKPayCallback)(NSString *signString, NSError *error);

@protocol SDKPayService <NSObject>

/**
 *  请求支付
 *
 *  @param orderString 支付的订单串
 *  @param callback    回调方法
 */

- (void)payOrder:(NSString*)orderString callBack:(SDKPayCallback)callBack;

/**
 *  回调处理
 *
 *  @param url      回调的url
 *  @param callback 处理的回调方法
 */
- (BOOL)payProcessOrderWithPaymentResult:(NSURL*)url
                         standbyCallback:(void (^)(NSDictionary *resultDic))callback;

@end
