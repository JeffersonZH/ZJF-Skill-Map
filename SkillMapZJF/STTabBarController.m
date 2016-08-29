//
//  STTabBarController.m
//  SkillMapZJF
//
//  Created by zjf on 16/7/1.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "STTabBarController.h"
#import "STTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface STTabBarController ()

@end

@implementation STTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1
    FirstViewController * firstVC = [[FirstViewController alloc] init];
    [self addChildController:firstVC imageName:@"" selectedImageName:@"" viewName:@"1"];
    //2
    SecondViewController * secondVC = [[SecondViewController alloc] init];
    [self addChildController:secondVC imageName:@"" selectedImageName:@"" viewName:@"2"];
    //3
    ThirdViewController * thirdVC = [[ThirdViewController alloc] init];
    [self addChildController:thirdVC imageName:@"" selectedImageName:@"" viewName:@"3"];
    //4
    FourthViewController * fourthVC = [[FourthViewController alloc] init];
    [self addChildController:fourthVC imageName:@"" selectedImageName:@"" viewName:@"4"];
}

- (void)addChildController:(UIViewController *)controller imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName viewName:(NSString *)viewName {
    controller.title = viewName;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
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

@end
