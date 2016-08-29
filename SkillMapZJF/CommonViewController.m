//
//  CommonViewController.m
//  subwaytrain
//
//  Created by an on 16/3/18.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitleMessage:(NSString *)title {
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
}

//设置navigationItem
- (void)setNavigationItemLeftItemImageName:(NSString *)leftImgName selector:(SEL)leftSelector rightItemTitle:(NSString *)rightTitle rightItemImageName:(NSString *)rightImgName selector:(SEL)rightSelector {
    //左Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:leftImgName] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:leftSelector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    leftBtn.frame = CGRectMake(0, 0, 20, 15);
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右Item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [rightBtn setTitleColor:[UIColor colorWithRed:0.30f green:0.77f blue:0.82f alpha:1.00f] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:rightSelector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    if ([rightTitle isEqualToString:@"注册"]) {
        rightBtn.frame = CGRectMake(0,0,50,20);
    }
    else
        rightBtn.frame = CGRectMake(0, 5, 80, 20);
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

//navigationItem右侧Item
- (void)setNavigationRightItemWithName:(NSString *)rightTitle image:(NSString *)imageName action:(SEL)action {
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(0, 0, 60, 20);
    [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //button文字对齐方式
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
}

//navigationItem左侧Item
- (void)setNavigationLeftItemWithName:(NSString *)rightTitle image:(NSString *)imageName action:(SEL)action {
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 60, 20);
    [leftBtn setTitle:rightTitle forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //button文字对齐方式
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
}

//alert
- (void)showAlertViewWithTitle:(NSString *)title msg2:(NSString *)msg {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    [alertController addAction:OKAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title msg:(NSString *)msg {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action")  style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)setBackButtonWithTitle:(NSString *)title {
    //自定义注册页面的返回按钮（需要在此事先定义）
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

@end
