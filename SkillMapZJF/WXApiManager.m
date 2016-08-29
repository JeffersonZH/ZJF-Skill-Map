//
//  WXApiManager.m
//  SkillMapZJF
//
//  Created by zjf on 16/7/19.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate

//- (void)onResp:(BaseResp *)resp {
//    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
//        NSLog(@"111");
//    }
//    else if ([resp isKindOfClass:[SendAuthResp class]]) {
//        NSLog(@"222");
//    }
//    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
//        NSLog(@"333");
//    }
//    else if([resp isKindOfClass:[PayResp class]]){
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
//        
//        switch (resp.errCode) {
//            case WXSuccess: {
//                strMsg = @"支付结果：成功！";
//                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                
//                NSNotification * notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"  object:@"success"];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//            }
//            break;
//                
//            default: {
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//
//                NSNotification * notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"  object:@"fail"];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//            }
//            break;
//        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}



@end
