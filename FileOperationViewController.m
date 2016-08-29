//
//  FileOperationViewController.m
//  SkillMapZJF
//
//  Created by zjf on 16/7/8.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "FileOperationViewController.h"

@interface FileOperationViewController ()

@end

@implementation FileOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleMessage = @"文件操作";

    _pathLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _pathLabel.layer.borderWidth = 1;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取指定目录的路径
//NSDocumentDirectory
- (IBAction)btn1Clicked:(id)sender {
    NSArray * pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *  documentsDirectory = [pathArr objectAtIndex:0];
    _pathLabel.text = documentsDirectory;
//    [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
}

//NSDocumentationDirectory
- (IBAction)btn2Clicked:(id)sender {
    NSArray * pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[pathArr objectAtIndex:0];
    _pathLabel.text = documentsDirectory;
}

//NSDownloadsDirectory
- (IBAction)btn3Clicked:(id)sender {
    NSArray * pathArr = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory=[pathArr objectAtIndex:0];
    _pathLabel.text = documentsDirectory;
}

#pragma mark - 在指定目录中创建文件
//在Document中创建文件myFile
- (IBAction)createFileBtn1Clicked:(id)sender {
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"好的"];
    
    NSString * content = @"abc";
    //创建ascii编码文本文件
    //NSData * contentData = [content dataUsingEncoding:NSASCIIStringEncoding];
    //如果创建文件名称带汉字
    NSData * contentData = [content dataUsingEncoding:NSUnicodeStringEncoding];
    if ([contentData writeToFile:fileName atomically:YES]) {
        [self showAlertViewWithTitle:@"Write OK！" msg:nil];
    }
    
}

//在其它目录中创建文件
- (IBAction)createFileBtn2Clicked:(id)sender {
    //只需要更换目录工厂常量为NSCachesDirectory
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *fileName=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"cachefile.rtf"];
    NSString * content = @"abc";
    
    // test
    //NSString * filePath = [[NSBundle mainBundle] pathForResource:@"hi3516a" ofType:@"h264"];
    //NSData * fileData = [NSData dataWithContentsOfFile:filePath];
    
    
    //创建ascii编码文本文件
    //NSData * contentData = [content dataUsingEncoding:NSASCIIStringEncoding];
    //如果创建文件名称带汉字
    NSData * contentData = [content dataUsingEncoding:NSUnicodeStringEncoding];
    if ([contentData writeToFile:fileName atomically:YES]) {
        [self showAlertViewWithTitle:@"Write OK！" msg:nil];
    }
}

//在tmp目录中创建文件
- (IBAction)createFileBtn3Clicked:(id)sender {
    //通过NSHomeDirectory()获取根目录
    NSString *fileName=[NSHomeDirectory() stringByAppendingPathComponent:@"tmp/myfileokkk"];
    NSString * content = @"abc-tmp";
    //创建ascii编码文本文件
    NSData * contentData = [content dataUsingEncoding:NSASCIIStringEncoding];
    //如果创建文件名称带汉字
    if ([contentData writeToFile:fileName atomically:YES]) {
        [self showAlertViewWithTitle:@"Write OK！" msg:nil];
    }
}

//读取指定文件，并打印其中的内容
- (IBAction)createFileBtn4Clicked:(id)sender {
    //NSString * myFilePath = [[NSBundle mainBundle] pathForResource:@"PrefixHeader" ofType:@"pch"];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *fileName=[paths objectAtIndex:0];
    NSString * myFileContent = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"bundel file path: %@ \nfile content:%@",fileName,myFileContent);
}



@end
