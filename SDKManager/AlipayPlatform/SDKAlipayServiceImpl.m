//
//  SDKAlipayServiceImpl.m
//  xiangmu
//
//  Created by 湛思科技 on 16/12/7.
//  Copyright © 2016年 湛思科技. All rights reserved.
//

#import "SDKAlipayServiceImpl.h"
#import <AlipaySDK/AlipaySDK.h>

@interface SDKAlipayServiceImpl ()

@property (strong, nonatomic) NSString *aliPayScheme;

@end

@implementation SDKAlipayServiceImpl

+ (instancetype)sharedService;
{
    static SDKAlipayServiceImpl *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 配置部分

- (BOOL)isPlatformAppInstalled
{
    return YES;
}

- (void)registerWithPlatformConfig:(NSDictionary *)config
{
    if (config == nil || config.allKeys.count == 0) {
        return;
    }
    
    NSString *appScheme = @"com.chinaiyong.iyong";
#ifdef TEST
    appScheme = @"com.chinaiyong.iyongtest";
#endif
    self.aliPayScheme = appScheme;
    
//    NSString *appScheme = config[SDKConfigAppSchemeKey];
//    if (appScheme && appScheme.length > 0) {
//        self.aliPayScheme = appScheme;
//    }
}

- (BOOL)isRegistered
{
    return (self.aliPayScheme && self.aliPayScheme.length > 0);
}

- (BOOL)handleResultUrl:(NSURL *)url
{
    return [self payProcessOrderWithPaymentResult:url standbyCallback:nil];
}

#pragma mark -

- (void)payOrder:(NSString*)orderString callBack:(SDKPayCallback)callBack;
{
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:self.aliPayScheme callback:^(NSDictionary *resultDic) {
//        DLog(@"resultDic = %@", resultDic);
        
//        NSLog(@"resultStatus = %ld", (long)[resultDic[@"resultStatus"] integerValue]);
        if (callBack) {
            callBack(resultDic[@"resultStatus"], nil);
        }
    }];
}

- (BOOL)payProcessOrderWithPaymentResult:(NSURL*)url
                         standbyCallback:(void (^)(NSDictionary *resultDic))callback;
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            DLog(@"result = %@", resultDic);
//            [MsgToolBox showAlert:@"" content:resultDic[@"memo"]];
//            NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
//            if (resultStatus == 6001) {
//                [MsgToolBox showAlert:@"" content:@"用户]
//            }
            NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];//[signString integerValue];
            NSString *title = @"";
            NSString *msg;
            if (resultStatus == 6001) {
                msg = kMsgPayUserCancelled;
//                [MsgToolBox showAlert:@"" content:kMsgPayUserCancelled];
                //                        [self showTipMessage:@"用户取消"];
            }
            else if (resultStatus == 6002){
                msg = kMsgPayNetworkFailed;
//                [MsgToolBox showAlert:@"" content:kMsgPayNetworkFailed];
                //                        [self showTipMessage:@"网络连接错误"];
            }
            else if (resultStatus == 4000){
                msg = kMsgPayFailue;
//                [MsgToolBox showAlert:@"" content:kMsgPayFailue];
                //            [self showTipMessage:@"订单支付失败"];
            }
            else if (resultStatus == 8000){
                msg = kMsgPayProcessing;
//                [MsgToolBox showAlert:@"" content:kMsgPayProcessing];
                //            [self showTipMessage:@"正在处理中"];
            }
            else if (resultStatus == 9000){
                msg = kMsgPaySuccess;
//                [MsgToolBox showAlert:@"" content:kMsgPaySuccess];
                //            [self showTipMessage:@"订单支付成功"];
            }
            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
//                if (buttonIndex == 0) {
//                    if (resultStatus == 9000) {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kAdvPurchaseSuccessNotification object:nil];
//                    }
//                    else if (resultStatus == 4000) {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kAdvPurchaseFailureNotification object:nil];
//                    }
//                }
//            }];
            
            if (resultStatus == 9000) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kAdvPurchaseSuccessNotification object:nil];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
        return YES;
    }
//    if ([url.scheme.lowercaseString isEqualToString:self.aliPayScheme.lowercaseString]) {
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:callback];
//        return YES;
//    }
    return NO;
}

@end
