//
//  EncryptAndDecryptViewController.m
//  SkillMapZJF
//
//  Created by zjf on 16/8/3.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "EncryptAndDecryptViewController.h"

@interface EncryptAndDecryptViewController ()

@end

@implementation EncryptAndDecryptViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
//    scrollView.backgroundColor = [UIColor lightGrayColor];
//    scrollView.contentSize = CGSizeMake(KScreenW, KScreenH * 2);
//    //scrollView.contentOffset = CGPointMake(KScreenW, KScreenH * 2);
//    [self.view addSubview:scrollView];
    
    //_scrollview.contentSize = CGSizeMake(KScreenW, KScreenH * 2);
    
//    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH * 2)];
//    imgView.backgroundColor = [UIColor greenColor];
//    [scrollView addSubview: imgView];
//    
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(100, 100, 250, 30);
//    btn.backgroundColor = [UIColor cyanColor];
//    [btn setTitle:@"123" forState:UIControlStateNormal];
//    [scrollView addSubview:btn];
}

- (void)viewDidLayoutSubviews {
    //内容超过scrollView高度
    _scrollview.contentSize = CGSizeMake(KScreenW, 786);
    //内容没有超过scrollView高度
    _scrollview.contentSize = CGSizeMake(KScreenW, KScreenH - 64 - 44);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
