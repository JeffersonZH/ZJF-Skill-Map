//
//  ChangePasswordViewController.m
//  subwaytrain
//
//  Created by an on 16/5/5.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "RegularHelp.h"
#import "AFNetworking.h"

@interface ChangePasswordViewController ()
{
    NSUserDefaults * userDefaults;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.titleMessage = @"修改密码";
    
    _doneBtn.layer.cornerRadius = 5;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
}


- (IBAction)doneBtnClicked:(id)sender {
    //所有信息输入完整
    if (_originalPasswordTextField.text.length != 0 && _nNewPasswordTextField.text.length != 0 && _confirmNewPasswordTextField.text != 0) {
        
        if ([_nNewPasswordTextField.text isEqualToString:_confirmNewPasswordTextField.text]) {
            //注：对于存入NSUserDefaults中的NSString数据，需要stringForKey：方法获取
            NSString * phoneNumStr = [userDefaults stringForKey:@"phoneNum"];
            
            NSMutableDictionary * changePasswordDic = [[NSMutableDictionary alloc] init];
            
            [changePasswordDic setObject:phoneNumStr forKey:@"phoneNumber"];
            [changePasswordDic setObject:_originalPasswordTextField.text forKey:@"originalPassword"];
            [changePasswordDic setObject:_nNewPasswordTextField.text forKey:@"nNewPassword"];
            NSLog(@"changePasswordDic:%@", changePasswordDic);
            
            //修改密码请求
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            [manager POST:RESET_PASSWORD_URL parameters:changePasswordDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                NSString * encodeStr = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"changePasswordEncodeStr:%@", encodeStr);

                if ([encodeStr isEqualToString:@"SUCCESSFUL"]) {
                    [userDefaults removeObjectForKey:@"loged"];
                    //回到我的根界面
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else if ([encodeStr isEqualToString:@"INCORRECT_USERNAME_OR_PASSWORD"]) {
                    [self showAlertViewWithTitle:@"账号或密码错误" msg:nil];
                }
                else {
                    [self showAlertViewWithTitle:@"重置失败，请稍后重试" msg:nil];
                }
                
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                NSLog(@"error:%@", error.localizedDescription);
                [self showAlertViewWithTitle:@"修改密码失败，请稍后重试" msg:nil];
            }];
        }
        else {
            [self showAlertViewWithTitle:@"两次输入密码不一致" msg:nil];
        }
    }
    else {
        [self showAlertViewWithTitle:@"请输入完整信息" msg:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_originalPasswordTextField resignFirstResponder];
    [_nNewPasswordTextField resignFirstResponder];
    [_confirmNewPasswordTextField resignFirstResponder];
    
}

@end
