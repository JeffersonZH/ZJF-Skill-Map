//
//  TestViewController.m
//  SkillMapZJF
//
//  Created by ERG－iOS2 on 16/9/21.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#define PUSHTOWEBVIEW [self.navigationController pushViewController:webViewVC animated:YES];

#import "TestViewController.h"
#import "WebViewController.h"

@interface TestViewController ()
{
    WebViewController * webViewVC;
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleMessage = @"UIWebView操作";
    //    self.view.backgroundColor = [UIColor yellowColor];
    
    webViewVC = [[WebViewController alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loadURLBtnClicked:(id)sender {
    webViewVC.flag = @"URL";
    PUSHTOWEBVIEW
}

- (IBAction)loadHTMLBtnClicked:(id)sender {
    webViewVC.flag = @"htmlFile";
    PUSHTOWEBVIEW
}

- (IBAction)loadLocalFileBtnClicked:(id)sender {
    webViewVC.flag = @"loclaFile";
    PUSHTOWEBVIEW
}

- (IBAction)loadBinaryFileBtnClicked:(id)sender {
    webViewVC.flag = @"asBinaryFile";
    PUSHTOWEBVIEW
}




@end


