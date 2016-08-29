//
//  ZJFTableViewCell.m
//  SkillMapZJF
//
//  Created by an on 16/7/14.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "ZJFTableViewCell.h"

@implementation ZJFTableViewCell

- (void)awakeFromNib {
    //超出cell的部分不显示
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//xib创建cell：方法一
//+ (instancetype)perceicedErrorCellFromXib:(UITableView *)tableView {
//    static NSString * ZJFCellIdentifier = @"ZJFCellIdentifier";
//    ZJFTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ZJFCellIdentifier];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
//    }
//    return cell;
//}

//xib创建cell——优化后：方法二
/**
 *  注意：方法一的方法创建cell并没有包含任何重用信息，也就是说，每次拖动tableview，都会一直创建不同的cell，当要显示的cell很多时内存问题就显露出来了。
 *  所以采用方法二进行优化：我们可以看到，红色部分很好地满足了我们的需求：既从nib加载，又能对cell进行重用。
 */
+ (instancetype)perceicedErrorCellFromXib:(UITableView *)tableView {
    static NSString * ZJFCellIdentifier = @"ZJFCellIdentifier";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZJFTableViewCell class]) bundle:nil];
        //优化部分代码
        [tableView registerNib:nib forCellReuseIdentifier:ZJFCellIdentifier];
        
        nibsRegistered = YES;
    }
    ZJFTableViewCell * cell = (ZJFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ZJFCellIdentifier];
    return cell;
}

//解决cell与屏幕不等宽的问题
- (void)setFrame:(CGRect)frame {
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
}

//设置背景图片y值
- (void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view {
    //将cell的frame转换成view的frame
    CGRect rect = [tableView convertRect:self.frame toView:view];
    //以屏幕中心点为0点，获取能看到的每个cell离中心点的距离值（视图frame的一半-看到的每个cell的y高度值）
    float distanceCenter = CGRectGetHeight(view.frame) / 2 - CGRectGetMinY(rect);
    //获取图片超出cell部分的高度值（图片高度-cell高度）
    float difference = CGRectGetHeight(self.backgroundImage.frame) - CGRectGetHeight(self.frame);
    //获取图片移动的距离
    float imageMove = (distanceCenter / CGRectGetHeight(view.frame)) * difference;
    //获取旧图片的frame
    CGRect imageRect = self.backgroundImage.frame;
    //移动图片位置
    imageRect.origin.y = imageMove - (difference / 2);
    //设置新图片的frame
    self.backgroundImage.frame = imageRect;
}


@end
