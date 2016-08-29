//
//  RegistViewController.m
//  subwaytrain
//
//  Created by an on 16/3/18.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "RegistViewController.h"
#import "AFNetworking.h"
//#import "SelfViewController.h"
#import "ServiceProtocalViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "RegularHelp.h"
#import "TimerHelper.h"

@interface RegistViewController ()
{
    BOOL protocalFlag;
}
@end

@implementation RegistViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [TimerHelper timerCountDownWithKey:kTimerKeyRegister tipLabel:_authenticationLabel forceStart:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleMessage = @"注册";
    
    _registBtn.layer.cornerRadius = 5;
    
    _phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _authenticationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //取消timer
    [TimerHelper cancelTimerByKey:kTimerKeyRegister];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnClicked:(id)sender {
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
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

- (IBAction)registBtnClicked:(id)sender {
    if ([RegularHelp validateUserPhone:_phoneNumText.text]) {
        if ((_phoneNumText.text.length != 0) && (_authenticationTextField.text.length != 0) && (_passwordTextField.text.length != 0) && protocalFlag != NO) {
            NSMutableDictionary * registDic = [[NSMutableDictionary alloc] init];
            [registDic setObject:[_phoneNumText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"phoneNumber"];
            [registDic setObject:[_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"password"];
            NSLog(@"registDic:%@", registDic);
            
            //注册请求
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            [manager POST:REGIST_URL parameters:registDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                NSString * encodeStr = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"registEncodeStr:%@", encodeStr);
                
                if ([encodeStr isEqualToString:@"SUCCESSFUL"]) {
                    //跳转到上级界面
                    //[self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else if ([encodeStr isEqualToString:@"USERNAME_ALREADY_EXIST"]) {
                    [self showAlertViewWithTitle:@"该用户名已经存在" msg:nil];
                }
                else if ([encodeStr isEqualToString:@"ERROR"]) {
                    [self showAlertViewWithTitle:@"注册失败，请稍后重试" msg:nil];
                }
                else {
                    [self showAlertViewWithTitle:@"请输入完整信息" msg:nil];
                }
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                NSLog(@"error:%@",error.localizedDescription);
                [self showAlertViewWithTitle:@"注册失败，请稍后重试" msg:nil];
            }];
        }
        else if (protocalFlag == NO) {
            [self showAlertViewWithTitle:@"请阅读服务协议" msg:nil];
        }
        else {
            [self showAlertViewWithTitle:@"请输入完整信息" msg:nil];
        }
    }
    else
        [self showAlertViewWithTitle:@"手机号码格式错误" msg:nil];
}

- (void)authCodeTouched:(id)sender {
    if ([RegularHelp validateUserPhone:_phoneNumText.text]) {
        [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:_authenticationLabel];
        //调用
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
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
    [_phoneNumText resignFirstResponder];
    [_authenticationTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

@end
