//
//  GuidePageViewController.m
//  subwaytrain
//
//  Created by an on 16/3/15.
//  Copyright © 2016年 combuilder. All rights reserved.
//

#import "GuidePageViewController.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface GuidePageViewController () <UIScrollViewDelegate>
{
    UIScrollView * scrollView;
}
@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initScrollView];
    
    // Do any additional setup after loading the view.
}

- (void)initScrollView {
    scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //加载image
    NSArray * picArr = [NSArray arrayWithObjects:@"image1@2x.jpg", @"image2@2x.jpg", @"image3@2x.jpg", nil];
    scrollView.contentSize = CGSizeMake(FRAME_WIDTH * picArr.count, FRAME_HEIGHT);
    
    for (NSInteger i = 0; i < picArr.count; i++) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(FRAME_WIDTH * i, 0, FRAME_WIDTH, FRAME_HEIGHT)];
        imgView.image = [UIImage imageNamed:picArr[i]];
        imgView.tag = 500 + i;
        imgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
        [imgView addGestureRecognizer:tap];
        [scrollView addSubview:imgView];
        
        //右上角关闭按钮
        UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(FRAME_WIDTH - CANCEL_BTN_WIDTH, CANCEL_BTN_WIDTH, CANCEL_BTN_WIDTH, CANCEL_BTN_WIDTH)];
        [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:cancelBtn];
    }
    
    
}

- (void)imageTaped:(UIGestureRecognizer *)gestureRecongnizer {
    UIView * gesView = [gestureRecongnizer view];
    if (gesView.tag == 500) {
        return;
        //scrollView.contentOffset = CGPointMake(FRAME_WIDTH, 0);
    }
    if (gesView.tag == 501) {
        return;
        //scrollView.contentOffset = CGPointMake(FRAME_WIDTH * 2, 0);
    }
    else {
        //进入主页面
        [((AppDelegate *)[[UIApplication sharedApplication] delegate])showViewController:HOME_VIEW_CONTROLLER];
        //[[[AppDelegate alloc] init] showViewController:HOME_VIEW_CONTROLLER];
    }
}

- (void)cancelBtnClicked {
    [((AppDelegate *)[[UIApplication sharedApplication] delegate])showViewController:HOME_VIEW_CONTROLLER];
    
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
