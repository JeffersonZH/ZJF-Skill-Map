//
//  TableViewAndCollectionView.m
//  SkillMapZJF
//
//  Created by an on 16/7/14.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "TableViewAndCollectionView.h"
#import "TableViewController.h"

@interface TableViewAndCollectionView ()

@end

@implementation TableViewAndCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)tableViewBtnClicked:(id)sender {
    TableViewController * tableView = [[TableViewController alloc] init];
    [self.navigationController pushViewController:tableView animated:YES];
}
@end
