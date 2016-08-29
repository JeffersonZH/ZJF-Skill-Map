//
//  RegistViewController.h
//  subwaytrain
//
//  Created by an on 16/3/18.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "CommonViewController.h"

@interface RegistViewController : CommonViewController


@property (weak, nonatomic) IBOutlet UILabel *authenticationLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *authenticationTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *readProtocalImg;
@property (weak, nonatomic) IBOutlet UIButton *readProtocalBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

- (IBAction)readProtocalBtnClicked:(id)sender;
- (IBAction)serviceProtocalBtnClicked:(id)sender;
- (IBAction)registBtnClicked:(id)sender;
- (IBAction)loginBtnClicked:(id)sender;



@end
