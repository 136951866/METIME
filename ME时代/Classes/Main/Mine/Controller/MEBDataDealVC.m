//
//  MEBDataDealVC.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEBDataDealVC.h"
#import "MEBDataDealView.h"

@interface MEBDataDealVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) MEBDataDealView *cview;
@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation MEBDataDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据统计";
    self.view.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:self.cview];
    self.scrollerView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
    [self.scrollerView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)requestNetWork{
    [self.cview setUIWithModel:nil];
    [self.scrollerView.mj_header endRefreshing];
}

- (UIScrollView *)scrollerView{
    if(!_scrollerView){
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight)];
        _scrollerView.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
        _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, kMEBDataDealViewHeight);
        _scrollerView.bounces = YES;
        _scrollerView.showsVerticalScrollIndicator =NO;
        _scrollerView.delegate = self;
    }
    return _scrollerView;
}

- (MEBDataDealView *)cview{
    if(!_cview){
        _cview = [[[NSBundle mainBundle]loadNibNamed:@"MEBDataDealView" owner:nil options:nil] lastObject];
        _cview.frame = CGRectMake(0, 0, SCREEN_WIDTH, kMEBDataDealViewHeight);
    }
    return _cview;
}

@end
