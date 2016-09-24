//
//  WebViewController.m
//  SkillMapZJF
//
//  Created by ERG－iOS2 on 16/9/21.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation WebViewController

//- (UIWebView *)webView {
//    if (!_webView) {
//        CGRect frame = [UIScreen mainScreen].bounds;
//        _webView = [[UIWebView alloc] initWithFrame:frame];
//        //识别webView中的类型，如有电话号码，点击直接可拨打
//        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
//    }
//    return _webView;
//}


- (void)viewDidLoad {
    [super viewDidLoad];

    if (!_webView) {
        CGRect frame = [UIScreen mainScreen].bounds;
        _webView = [[UIWebView alloc] initWithFrame:frame];
        //识别webView中的类型，如有电话号码，点击直接可拨打
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        [self.view addSubview:_webView];
    }


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //1 加载网址
    if ([_flag isEqualToString:@"URL"]) {
        NSString * urlStr = [NSString stringWithFormat:@"http://www.baidu.com"];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        [_webView loadRequest:request];
    }
    
    //2 加载本地html文件（包含图片）
    else if ([_flag isEqualToString:@"htmlFile"]) {
        //baseURL把项目根目录统一中项目下，加载double.html中的image, css的话，不需要写路径，直接写名字就可以。这样html中的图片就可以正常显示了
        NSURL * baseURL = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
        
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"double" ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlCont baseURL:baseURL];
        
        
    }
    
    //3 加载本地或者从服务器下载的文件，如txt，pdf，word等
    else if ([_flag isEqualToString:@"loclaFile"]) {
        //获取本地文件的url
        NSURL * fileURL = [[NSBundle mainBundle] URLForResource:@"LocalFile.txt" withExtension:nil];
        NSURLRequest * request = [NSURLRequest requestWithURL:fileURL];
        [_webView loadRequest:request];
    }
    
    //4 以二进制数据的方式加载文件 ????
    else if ([_flag isEqualToString:@"asBinaryFile"]) {
        // 最最常见的一种情况
        // 打开IE,访问网站,提示你安装Flash插件
        // 如果没有这个应用程序,是无法用UIWebView打开对应的文件的
        
        // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"LocalFile.txt" withExtension:nil];
        //iOS 7 Programming Cookbook.pdf
        
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        // 服务器的响应对象,服务器接收到请求返回给客户端的
        NSURLResponse *respnose = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respnose error:NULL];
        
        NSLog(@"%@", respnose.MIMEType);
        
        // 在iOS开发中,如果不是特殊要求,所有的文本编码都是用UTF8
        // 先用UTF8解释接收到的二进制数据流
        [_webView loadData:data MIMEType:respnose.MIMEType textEncodingName:@"UTF8" baseURL:nil];
        
    }
    else {
        //获取html文件所在路径
        NSString * path = [[NSBundle mainBundle] bundlePath];
        NSURL * baseURL = [NSURL fileURLWithPath:path];
        //获取该html文件
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
        //解析该html文件
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        //加载html文件
        [_webView loadHTMLString:htmlCont baseURL:baseURL];
    }
}
#pragma mark-UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * url = [request URL];
    NSString * urlStr = [NSString stringWithFormat:@"%@", url];
    NSLog(@"urlStr=%@", urlStr);
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
