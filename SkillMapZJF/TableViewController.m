//
//  TableViewController.m
//  SkillMapZJF
//
//  Created by an on 16/7/14.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "TableViewController.h"
#import "ZJFTableViewCell.h"
#import "UIView+Frame.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView * iconImageView;
    UITableView * tableView;
    
}
//@property(nonatomic,strong)UIImageView * iconImageView;
//@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, weak)UITableView * perceivedErrorTableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleMessage = @"滚动视觉差效果";
    iconImageView = [[UIImageView alloc] init];
    UIImage * image = [UIImage imageNamed:@"yishu.png"];
    iconImageView.image = image;
    CGSize size = image.size;
    iconImageView.frame = CGRectMake(0, 64, KScreenW, size.height);
    //NSLog(@"KScreenW *size.height /(size.width + 39):%f", KScreenW *size.height /(size.width + 39));
    NSLog(@"size.height:%f", size.height);
    
    iconImageView.backgroundColor = [UIColor clearColor];
    
    //NSLog(@"CGRectGetMaxY(iconImageView.frame):%f", CGRectGetMaxY(iconImageView.frame));
    
    tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, CGRectGetMaxY(iconImageView.frame), KScreenW, KScreenH);
    tableView.showsVerticalScrollIndicator = NO;
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [self.view addSubview:iconImageView];
    
    self.perceivedErrorTableView = tableView;

}

- (UITableView *)tableview {
    if (tableView == nil) {
        tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    return tableView;
}

- (UIImageView *)iconImageView {
    if (iconImageView == nil) {
        iconImageView = [[UIImageView alloc] init];
    }
    return iconImageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJFTableViewCell * cell = [ZJFTableViewCell perceicedErrorCellFromXib:tableView];
    cell.backgroundImage.image = [UIImage imageNamed:@"9"];
    //[NSString stringWithFormat:@"%d", indexPath.row + 1]
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //imageView缩放
    CGFloat offSetY = scrollView.contentOffset.y;
    UIImage * image =[UIImage imageNamed:@"yishu.png"];
    if (offSetY >= 0) {
        tableView.contentOffset = CGPointMake(0, 0);
    }
    else {
        iconImageView.height = image.size.height - offSetY;
        NSLog(@"iconImageView.height:%f", iconImageView.height);
    }
    
    //tbleView滑动时，其cell中图片的动态效果
    NSArray * visibleCells = [self.perceivedErrorTableView visibleCells];
    
    for (ZJFTableViewCell * cell in visibleCells) {
        //设置可见视图的背景图片
        [cell cellOnTableView:self.perceivedErrorTableView didScrollView:self.view];
    }
}

//视图加载完在调用scrollViewDidScroll方法
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self scrollViewDidScroll:[[UIScrollView alloc]init]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
