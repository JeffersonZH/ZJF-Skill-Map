//
//  WeChatPayViewController.m
//  SkillMapZJF
//
//  Created by an on 16/7/18.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#import "WeChatPayViewController.h"
#import "WXApi.h"
#import "AFNetworking.h"

@interface WeChatPayViewController () <WXApiDelegate>

@end

@implementation WeChatPayViewController

- (void)viewWillAppear:(BOOL)animated {
    if([WXApi isWXAppInstalled]) // 判断用户是否安装微信
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];//监听一个通知
    }
    else {
        [self showAlertViewWithTitle:@"提示" msg:@"您未安装微信客户端!"];
    }
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self weiXinPay];
}

- (void)weiXinPay {
    //判断用户是否安装微信
    if (![WXApi isWXAppInstalled]) {
        [self showAlertViewWithTitle:@"提示" msg:@"您未安装微信客户端!"];
    }
    else {
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [manager POST:WEIXINPAYURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSError *error;
            
            NSMutableDictionary *dic = NULL;
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            dic = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingMutableLeaves error:&error];
            if(dic != nil){
                NSMutableString *retcode = [dic objectForKey:@"retcode"];
                    NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dic objectForKey:@"partnerid"];
                req.prepayId            = [dic objectForKey:@"prepayid"];
                req.nonceStr            = [dic objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dic objectForKey:@"package"];
                req.sign                = [dic objectForKey:@"sign"];
                [WXApi sendReq:req];
            }else{
                NSLog(@"%@", @"服务器返回错误，未获取到json对象");
            }
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"error:%@",error.localizedDescription);
        }];
    }
}



- (void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"])
    {
        NSLog(@"支付成功");
        //[self creatPaySuccess];
        
    }
    else
    {
        NSLog(@"支付失败");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
