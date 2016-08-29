//
//  FileOperationViewController.h
//  SkillMapZJF
//
//  Created by zjf on 16/7/8.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "CommonViewController.h"

@interface FileOperationViewController : CommonViewController
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UILabel *pathLabel;

- (IBAction)btn1Clicked:(id)sender;
- (IBAction)btn2Clicked:(id)sender;
- (IBAction)btn3Clicked:(id)sender;

- (IBAction)createFileBtn1Clicked:(id)sender;
- (IBAction)createFileBtn2Clicked:(id)sender;
- (IBAction)createFileBtn3Clicked:(id)sender;
- (IBAction)createFileBtn4Clicked:(id)sender;


@end



