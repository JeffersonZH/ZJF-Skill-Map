//
//  ThirdLoginViewController.h
//  subwaytrain
//
//  Created by an on 16/5/9.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "CommonViewController.h"

@interface ThirdLoginViewController : CommonViewController

@property (nonatomic, strong) NSString * headImgStr;
@property (nonatomic, strong) NSString * loginNameStr;
@property (nonatomic, strong) NSString * loginTypeStr;


@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *authLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginingBtn;


- (IBAction)loginBtnClicked:(id)sender;

@end
