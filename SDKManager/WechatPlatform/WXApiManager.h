//
//  WXApiManager.h
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

#define kMsgPaySuccess @"支付成功"
#define kMsgPayUserCancelled @"用户取消"
#define kMsgPayFailue @"支付失败"
#define kAdvPurchaseSuccessNotification @"kAdvPurchaseSuccessNotification"
//static const NSString *kMsgPaySuccess = @"支付成功";
//static const NSString *kMsgPayUserCancelled = @"用户取消";
//static const NSString *kMsgPayFailue = @"支付失败";
//static const NSString *kAdvPurchaseSuccessNotification = @"kAdvPurchaseSuccessNotification";

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;

@end
