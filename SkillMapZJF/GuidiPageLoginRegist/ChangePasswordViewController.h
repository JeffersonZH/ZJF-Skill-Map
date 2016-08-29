//
//  ChangePasswordViewController.h
//  subwaytrain
//
//  Created by an on 16/5/5.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "CommonViewController.h"

@interface ChangePasswordViewController : CommonViewController


@property (weak, nonatomic) IBOutlet UITextField *originalPasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *nNewPasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *confirmNewPasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

- (IBAction)doneBtnClicked:(id)sender;

@end
