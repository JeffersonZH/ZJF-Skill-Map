//
//  LoginViewController.m
//  subwaytrain
//
//  Created by an on 16/3/15.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "LoginViewController.h"
#import "RegularHelp.h"
#import "AppDelegate.h"
#import "RegistViewController.h"
#import "InfoAlert.h"
#import "ForgetPasswordViewController.h"
#import "ThirdLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "AFNetworking.h"


@interface LoginViewController ()
{
    NSUserDefaults * userDefaults;
    ThirdLoginViewController * thirdLogin;

}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //重力感应背景图
    YGGravityImageView * imageView = [[YGGravityImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    imageView.image = [UIImage imageNamed:@"login_bg6.png"];
    [self.view addSubview:imageView];
    [imageView startAnimate];
    
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    thirdLogin = [[ThirdLoginViewController alloc] init];
    
    //设置textField删除按钮
    _phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _loginBtn.layer.cornerRadius = 5;
    _registBtn.layer.cornerRadius = 5;
    self.titleMessage = @"登录";

    
}

- (IBAction)loginBtnClicked:(id)sender {
    if ([RegularHelp validateUserPhone:_phoneNumText.text]) {
        //账号密码都非空-登录成功
        if (_phoneNumText.text.length != 0 && _passwordText.text.length != 0) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:_phoneNumText.text forKey:@"phoneNumber"];
            [dic setObject:_passwordText.text forKey:@"password"];
            NSLog(@"dic:%@", dic);
            
            //登录请求
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            [manager POST:LOGIN_URL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                NSString * encodeStr = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"loginEncodeStr:%@", encodeStr);
                
                if ([encodeStr isEqualToString:@"SUCCESSFUL"]) {
                    [userDefaults setObject:@"loged" forKey:@"loged"];
                    [userDefaults setObject:_phoneNumText.text forKey:@"phoneNum"];
                    [userDefaults synchronize];
                    //回到我的根界面
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else if ([encodeStr isEqualToString:@"USERNAME_DOES_NOT_EXIST"]) {
                    [self showAlertViewWithTitle:@"账号不存在" msg:nil];
                }
                else if ([encodeStr isEqualToString:@"INCORRECT_USERNAME_OR_PASSWORD"]) {
                    [self showAlertViewWithTitle:@"账号或密码错误" msg:nil];
                }
                else if ([encodeStr isEqualToString:@"ERROR"]) {
                    [self showAlertViewWithTitle:@"登录失败，请稍后重试" msg:nil];
                }
                else if ([encodeStr isEqualToString:@"FAILED"]) {
                    [self showAlertViewWithTitle:@"登录失败，请稍后重试" msg:nil];
                }
                else
                    [self showAlertViewWithTitle:@"请输入完整信息" msg:nil];
                
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                NSLog(@"error:%@", error.localizedDescription);
                [self showAlertViewWithTitle:@"登录失败，请稍后重试" msg:nil];
            }];
        }
        else {
            [self showAlertViewWithTitle:@"请输入完整信息" msg:nil];
        }
    }
    else
        [self showAlertViewWithTitle:@"手机号码格式错误" msg:nil];
}

- (IBAction)registBtnClicked:(id)sender {
    setBackTitle
    //进入注册页面
    RegistViewController * regist1 = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:regist1 animated:YES];
}

- (IBAction)forgetPassWordBtnClicked:(id)sender {
    setBackTitle
    ForgetPasswordViewController * forgetPassword = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPassword animated:YES];
}

//QQ登录
- (IBAction)qqBtnClicked:(id)sender {
    setBackTitle
    if ([[userDefaults objectForKey:@"loged"] isEqualToString:@"loged"]) {
        [self showAlertViewWithTitle:@"友情提示" msg:@"账户已在其它平台登录"];
    }
    else {
        [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                NSLog(@"uid=%@", user.uid);
                NSLog(@"credential%@", user.credential);
                NSLog(@"toker=%@", user.credential.token);
                NSLog(@"nickname=%@", user.nickname);
                
                //传递头像图片、用户名
                thirdLogin.headImgStr = user.icon;
                thirdLogin.loginNameStr = user.nickname;
                thirdLogin.loginTypeStr = @"QQ";
                [self.navigationController pushViewController:thirdLogin animated:YES];
            }
            else {
                NSLog(@"error:%@", error);
            }
        }];
    }
}

//微信登录
- (IBAction)weChatBtnClicked:(id)sender {
    setBackTitle
        if ([[userDefaults objectForKey:@"loged"] isEqualToString:@"loged"]) {
            [self showAlertViewWithTitle:@"友情提示" msg:@"账户已在其它平台登录"];
        }
        else {
            [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (state == SSDKResponseStateSuccess) {
                    NSLog(@"uid=%@", user.uid);
                    NSLog(@"credential%@", user.credential);
                    NSLog(@"token=%@", user.credential.token);
                    NSLog(@"nickname=%@", user.nickname);
    
                    //传递头像图片、用户名
                    thirdLogin.headImgStr = user.icon;
                    thirdLogin.loginNameStr = user.nickname;
                    thirdLogin.loginTypeStr = @"微信";
                    [self.navigationController pushViewController:thirdLogin animated:YES];
                }
                else {
                    NSLog(@"error:%@", error);
                }
            }];
        }
}

//微博登录
- (IBAction)microBlogBtnClicked:(id)sender {
    setBackTitle
    if ([[userDefaults objectForKey:@"loged"] isEqualToString:@"loged"]) {
        [self showAlertViewWithTitle:@"友情提示" msg:@"账户已在其它平台登录"];
    }
    else {
        [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                NSLog(@"uid=%@", user.uid);
                NSLog(@"credential%@", user.credential);
                NSLog(@"toker=%@", user.credential.token);
                NSLog(@"nickname=%@", user.nickname);
                
                //传递头像图片、用户名
                thirdLogin.headImgStr = user.icon;
                thirdLogin.loginNameStr = user.nickname;
                thirdLogin.loginTypeStr = @"微博";
                [self.navigationController pushViewController:thirdLogin animated:YES];
            }
            else {
                NSLog(@"error:%@", error);
                //[userDefaults removeObjectForKey:@"loged"];
            }
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneNumText resignFirstResponder];
    [_passwordText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
