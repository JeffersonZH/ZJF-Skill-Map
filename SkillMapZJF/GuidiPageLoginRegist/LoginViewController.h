//
//  LoginViewController.h
//  subwaytrain
//
//  Created by an on 16/3/15.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "CommonViewController.h"
#import "YGGravity.h"
#import "YGGravityImageView.h"

@interface LoginViewController:CommonViewController

//@property (weak, nonatomic) IBOutlet YGGravityImageView *backGroundImg;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordBBtn;

//第三方登录
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *microBlogBtn;

- (IBAction)loginBtnClicked:(id)sender;
- (IBAction)registBtnClicked:(id)sender;
- (IBAction)forgetPassWordBtnClicked:(id)sender;
//第三方登录
- (IBAction)qqBtnClicked:(id)sender;
- (IBAction)weChatBtnClicked:(id)sender;
- (IBAction)microBlogBtnClicked:(id)sender;


@end
