//
//  ForgetPasswordViewController.m
//  subwaytrain
//
//  Created by an on 16/5/9.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ServiceProtocalViewController.h"
#import "ThirdLoginViewController.h"
#import "AFNetworking.h"
#import <SMS_SDK/SMSSDK.h>
#import "RegularHelp.h"
#import "TimerHelper.h"

@interface ForgetPasswordViewController ()
{
    BOOL protocalFlag;
    //NSUserDefaults * userDefaults;
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleMessage = @"找回密码";
    
    _confirmBtn.layer.cornerRadius = 5;
    
    //userDefaults = [NSUserDefaults standardUserDefaults];
    
    _phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _authenticationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _readProtocalImg.hidden = YES;
    
    //添加边框
    _readProtocalBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _readProtocalBtn.layer.borderWidth = 1.0f;
    //设置圆角
    _readProtocalBtn.layer.cornerRadius = 5.0f;
    _readProtocalBtn.layer.masksToBounds = YES;
    
    //获取验证码
    _authenticationLabel.layer.cornerRadius = 5.0;
    _authenticationLabel.layer.masksToBounds = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(authCodeTouched:)];
    _authenticationLabel.userInteractionEnabled = YES;
    [_authenticationLabel addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)readProtocalBtnClicked:(id)sender {
    setBackTitle
    if (!protocalFlag) {
        _readProtocalImg.hidden = NO;
        protocalFlag = YES;
    }
    else {
        _readProtocalImg.hidden = YES;
        protocalFlag = NO;
    }
}

- (IBAction)serviceProtocalBtnClicked:(id)sender {
    setBackTitle
    ServiceProtocalViewController * serviceProtocal = [[ServiceProtocalViewController alloc] init];
    [self.navigationController pushViewController:serviceProtocal animated:YES];
}

- (IBAction)confirmBtnClicked:(id)sender {
    if ([RegularHelp validateUserPhone:_phoneNumberTextField.text]) {
        if ((_phoneNumberTextField.text.length != 0) && (_authenticationTextField.text.length != 0) && (_nPasswordTextField.text.length != 0) && protocalFlag != NO) {
            NSMutableDictionary * forgetPasswordDic = [[NSMutableDictionary alloc] init];
            [forgetPasswordDic setObject:[_phoneNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"phoneNumber"];
            [forgetPasswordDic setObject:[_nPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"password"];
            NSLog(@"forgetPasswordDic:%@", forgetPasswordDic);
            
            //注册请求 
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            [manager POST:FORGET_PASSWORD_URL parameters:forgetPasswordDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                NSString * enCodeStr = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"forgetEnCodeStr:%@", enCodeStr);
                
                if ([enCodeStr isEqualToString:@"SUCCESSFUL"]) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else if ([enCodeStr isEqualToString:@"USERNAME_DOES_NOT_EXIST"]) {
                    [self showAlertViewWithTitle:@"用户名不存在" msg:nil];
                }
                else if ([enCodeStr isEqualToString:@"ERROR"]) {
                    [self showAlertViewWithTitle:@"找回密码失败，请稍后重试" msg:nil];
                }
                else {
                    [self showAlertViewWithTitle:@"请输入完整信息" msg:nil];
                }
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                NSLog(@"error:%@",error.localizedDescription);
            }];
        }
        else if ((_phoneNumberTextField.text.length == 0) || (_authenticationTextField.text.length == 0) || (_nPasswordTextField.text.length == 0)) {
            [self showAlertViewWithTitle:@"请输入完整信息" msg:nil];
        }
        else {
            [self showAlertViewWithTitle:@"请阅读服务协议" msg:nil];
        }
    }
    else
        [self showAlertViewWithTitle:@"手机号码格式错误" msg:nil];
}

- (void)authCodeTouched:(id)sender {
    if ([RegularHelp validateUserPhone:_phoneNumberTextField.text]) {
        [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:_authenticationLabel];
        //调用
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumberTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                NSLog(@"获取验证码成功");
            }
            else {
                NSLog(@"错误信息:%@", error);
            }
        }];
    }
    else
        [self showAlertViewWithTitle:@"手机号码格式错误" msg:@"请输入正确的手机号码"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneNumberTextField resignFirstResponder];
    [_authenticationTextField resignFirstResponder];
    [_nPasswordTextField resignFirstResponder];
}


@end
