//
//  WXApiManager.h
//  SkillMapZJF
//
//  Created by zjf on 16/7/19.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>



@end

@interface WXApiManager : NSObject <WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;


@end
