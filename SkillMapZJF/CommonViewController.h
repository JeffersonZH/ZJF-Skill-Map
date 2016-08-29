//
//  CommonViewController.h
//  subwaytrain
//
//  Created by an on 16/3/18.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController

@property (nonatomic, copy) NSString * titleMessage;

//设置navigationItem
- (void)setNavigationItemLeftItemImageName:(NSString *)leftImgName selector:(SEL)leftSelector rightItemTitle:(NSString *)rightTitle rightItemImageName:(NSString *)rightImgName selector:(SEL)rightSelector;

//navigationItem右侧Item
- (void)setNavigationRightItemWithName:(NSString *)rightTitle image:(NSString *)imageName action:(SEL)action;
//navigationItem左侧Item
- (void)setNavigationLeftItemWithName:(NSString *)rightTitle image:(NSString *)imageName action:(SEL)action;

- (void)showAlertViewWithTitle:(NSString *)title msg:(NSString *)msg;

- (void)setBackButtonWithTitle:(NSString *)title;

@end
