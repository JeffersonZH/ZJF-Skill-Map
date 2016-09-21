//
//  AppDelegate.m
//  SkillMapZJF
//
//  Created by zjf on 16/7/1.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "AppDelegate.h"
#import "STTabBarController.h"
#import "GuidePageViewController.h"
#import "RegistViewController.h"
#import "LoginViewController.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
//#import "WXApiManager.h"
#import <TencentOpenAPI/TencentOAuth.h> // QQ和QQ空间
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h" //新浪微博



@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //改变状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;

    //向微信注册
    [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"weixin demo"];

    //初始化第三方登录
    [self thirdPartyLoginInit];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    STTabBarController * tabBar = [[STTabBarController alloc] init];
    self.window.rootViewController = tabBar;
    
    [self.window makeKeyAndVisible];
    return YES;
}

//ShareSDK 3.x版本
- (void)thirdPartyLoginInit {
    [ShareSDK registerApp:@"iosv1101"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                             //新浪微博
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                             //QQ
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                             //微信
                         case SSDKPlatformTypeWechat:
//                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                             
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                              redirectUri:@"http://www.sharesdk.cn"
//                                                 authType:SSDKAuthTypeWeb];
                      break;
                      //QQ登录信息
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282" appKey:@"aed9b0303e3ed1e27bae87c33761161d" authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      //微信
//                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885" appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      break;
                      
                  default:
                      break;
              }
          }];
}

//跳转处理：回到本应用界面的方法
//方法一：
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}

//方法二：
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}

//方法三：iOS 9.0之后使用该方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    //有WXApiManager类需要如下
    //return [WXApi handleOpenURL:url delegate:[WXApiManager  sharedManager]];
    return [WXApi handleOpenURL:url delegate:self];
    //|| [TencentOAuth HandleOpenURL:url]
}

//
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        NSLog(@"111");
    }
    else if ([resp isKindOfClass:[SendAuthResp class]]) {
        NSLog(@"222");
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        NSLog(@"333");
    }
    else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess: {
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                NSNotification * notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"  object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
                break;
                
            default: {
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                
                NSNotification * notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"  object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)showViewController:(NSInteger)type {
    switch (type) {
        case 31:
        {
            self.window.rootViewController = [[GuidePageViewController alloc] init];
        }
            break;
        case 32:
        {
            self.window.rootViewController = [[LoginViewController alloc] init];
        }
            break;
        case 33:
        {
            self.window.rootViewController = [[STTabBarController alloc]init];
        }
            break;
        default:
            break;
    }
}

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
//                break;
//                
//            default: {
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                
//                NSNotification * notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"  object:@"fail"];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//            }
//                break;
//        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
