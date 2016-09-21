//
//  GCDViewController.m
//  SkillMapZJF
//
//  Created by zjf on 16/8/1.
//  Copyright © 2016年 ctfo. All rights reserved.
//

#define ROW_WIDTH 100
#define ROW_HEIGHT 100
#define ROW_COUNT 3
#define COLUMN_COUNT 4

#import "GCDViewController.h"

@interface GCDViewController ()
{
    UIImageView * imgView;
    NSMutableArray * imgViewsArr;
    NSMutableArray * imgNamesArr;
}
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleMessage = @"GCD多线程";
    imgViewsArr = [NSMutableArray array];
    [self createImgViews];
}

- (void)createImgViews {
    [self initImages];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(0, 500, 220, 25);
    [button setTitle:@"串行加载图片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadImageWithMultiThreadSDQ) forControlEvents:UIControlEventTouchUpInside]; [self.view addSubview:button];

    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(170, 500, 220, 25);
    [button2 setTitle:@"并行加载图片" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(loadImageWithMultiThreadCDQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    //创建图片链接
    imgNamesArr = [NSMutableArray array];
    for (NSInteger i = 0; i < ROW_COUNT * COLUMN_COUNT; i++) {
        [imgNamesArr addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%ld.jpg", i]];
    }
}

- (void)initImages {
    if (imgViewsArr.count != 0) {
        [imgViewsArr removeAllObjects];
    }
    for (NSInteger i = 0; i < ROW_COUNT; i++) {
        for (NSInteger j = 0; j < COLUMN_COUNT; j++) {
            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(j * (ROW_WIDTH + 5), i * (ROW_HEIGHT + 30) + 100, ROW_WIDTH, ROW_HEIGHT)];
            imgView.backgroundColor = [UIColor cyanColor];
            [self.view addSubview:imgView];
            [imgViewsArr addObject:imgView];
        }
    }
}

//Serial Dispatch Queue,串行队列
- (void)loadImageWithMultiThreadSDQ {
    [self initImages];
    
    NSInteger count = ROW_COUNT * COLUMN_COUNT;
    //创建多线程队列对象
    dispatch_queue_t serialQueue = dispatch_queue_create("myQueue1", DISPATCH_QUEUE_SERIAL);
    //创建多个线程填充图片
    for (NSInteger i = 0; i < count; i++) {
        dispatch_async(serialQueue, ^{
            NSLog(@"Thread is :%@", [NSThread currentThread]);
            [self loadImage:i];
        });
    }
}

//Concurrent Dispatch Queue并行队列
- (void)loadImageWithMultiThreadCDQ {
    [self initImages];
    
    NSInteger count = ROW_COUNT * COLUMN_COUNT;
    //获取全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (NSInteger i = 0; i < count; i++) {
        dispatch_async(globalQueue, ^{
            NSLog(@"Thread is :%@", [NSThread currentThread]);
            [self loadImage:i];
        });
    }
}

- (void)loadImage:(NSInteger)index {
    //请求数据
    NSURL * url = [NSURL URLWithString:imgNamesArr[index]]; // NSString ——> NSUrl
    NSData * imgData = [NSData dataWithContentsOfURL:url]; // NSUrl ——> NSData
    
    //更新UI界面
    dispatch_queue_t mainQuue = dispatch_get_main_queue();
    dispatch_sync(mainQuue, ^{
        UIImageView * imageView = imgViewsArr[index];
        imageView.image = [UIImage imageWithData:imgData]; // NSData ——> UIImageView
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
