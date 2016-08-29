//
//  ZJFTableViewCell.h
//  SkillMapZJF
//
//  Created by an on 16/7/14.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJFTableViewCell : UITableViewCell

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

//xib创建cell
+ (instancetype)perceicedErrorCellFromXib:(UITableView *)tableView;

//设置背景图片y值
- (void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view;

@end
