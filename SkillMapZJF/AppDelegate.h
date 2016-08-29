//
//  AppDelegate.h
//  SkillMapZJF
//
//  Created by zjf on 16/7/1.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showViewController:(NSInteger)type;

@end

