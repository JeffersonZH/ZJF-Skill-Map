//
//  FirstViewController.m
//  SkillMapZJF
//
//  Created by zjf on 16/7/1.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "FirstViewController.h"
#import "LoginViewController.h"
#import "PaymentViewController.h"
#import "EncryptAndDecryptViewController.h"
#import "FileOperationViewController.h"
#import "TableViewAndCollectionView.h"

#import "GCDViewController.h"

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * firstTableView;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleMessage = @"11";
    
    firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    firstTableView.delegate = self;
    firstTableView.dataSource = self;
    
    [self.view addSubview:firstTableView];
    
    [self setNavigationRightItemWithName:@"登陆注册" image:nil action:@selector(rightNavigationItemClicked)];
}

- (void)rightNavigationItemClicked {
    LoginViewController * login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * firstIdentifier = @"firstIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstIdentifier];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"支付方式";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"语音输入";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"加密解密";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"文件操作";
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"TableView操作";
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"GCD多线程";
    }
    else
        cell.textLabel.text = @"....";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PaymentViewController * payment = [[PaymentViewController alloc] init];
        [self.navigationController pushViewController:payment animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.row == 1) {
        
    }
    if (indexPath.row == 2) {
        EncryptAndDecryptViewController * encryptAndDecrypt = [[EncryptAndDecryptViewController alloc] init];
        [self.navigationController pushViewController:encryptAndDecrypt animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.row == 3) {
        FileOperationViewController * file = [[FileOperationViewController alloc] init];
        [self.navigationController pushViewController:file animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.row == 4) {
        TableViewAndCollectionView * TCView = [[TableViewAndCollectionView alloc] init];
        [self.navigationController pushViewController:TCView animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.row == 5) {
        GCDViewController * GCDView = [[GCDViewController alloc] init];
        [self.navigationController pushViewController:GCDView animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
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
