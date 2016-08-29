//
//  PaymentViewController.m
//  SkillMapZJF
//
//  Created by zjf on 16/7/1.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "PaymentViewController.h"
#import "WeChatPayViewController.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleMessage = @"支付方式";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)unionPayBtnClicked:(id)sender {
}

- (IBAction)aliPayBtnClicked:(id)sender {
}

- (IBAction)weChatPayBtnClicked:(id)sender {
    WeChatPayViewController * weChat = [[WeChatPayViewController alloc] init];
    [self.navigationController pushViewController:weChat animated:YES];
}




@end
