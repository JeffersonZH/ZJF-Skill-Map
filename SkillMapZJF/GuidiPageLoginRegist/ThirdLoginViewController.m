//
//  ThirdLoginViewController.m
//  subwaytrain
//
//  Created by an on 16/5/9.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "ThirdLoginViewController.h"

@interface ThirdLoginViewController ()
{
    NSUserDefaults * defaults;
}
@end

@implementation ThirdLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //头像
    _typeImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_headImgStr]]];
    _typeLabel.text = [NSString stringWithFormat:@"%@", _loginNameStr];
    _authLabel.text = [NSString stringWithFormat:@"您已对%@授权", _loginTypeStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    self.titleMessage = @"第三方登录";
    
    _loginingBtn.layer.cornerRadius = 5;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginBtnClicked:(id)sender {
    _loginingBtn.titleLabel.text = @"正在登录中...";
    
    [defaults setObject:@"loged" forKey:@"loged"];
    [defaults synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
