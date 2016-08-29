//
//  ForgetPasswordViewController.h
//  subwaytrain
//
//  Created by an on 16/5/9.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "CommonViewController.h"

@interface ForgetPasswordViewController : CommonViewController


@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *authenticationTextField;
@property (weak, nonatomic) IBOutlet UITextField *nPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *authenticationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *readProtocalImg;
@property (weak, nonatomic) IBOutlet UIButton *readProtocalBtn;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


- (IBAction)readProtocalBtnClicked:(id)sender;
- (IBAction)serviceProtocalBtnClicked:(id)sender;
- (IBAction)confirmBtnClicked:(id)sender;

@end
