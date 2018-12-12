//
//  MEGetCaseVC.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGetCaseVC.h"
#import "MEGetCaseContentVC.h"

@interface MEGetCaseVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    MEGetCaseStyle _currentType;
}

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MEGetCaseContentVC *allVC;
@property (nonatomic, strong) MEGetCaseContentVC *getCaseIngVC;
@property (nonatomic, strong) MEGetCaseContentVC *GetCaseedVC;
@property (nonatomic, strong) MEGetCaseContentVC *notGetCaseVC;

@end

@implementation MEGetCaseVC

- (instancetype)initWithType:(MEGetCaseStyle)type{
    if(self = [super init]){
        _currentType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现明细";
    _arrType = MMEGetCaseStyleTitle;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.allVC.view];
    [self.scrollView addSubview:self.getCaseIngVC.view];
    [self.scrollView addSubview:self.GetCaseedVC.view];
    [self.scrollView addSubview:self.notGetCaseVC.view];
    [self.view addSubview:self.scrollView];
    
    //1、初始化JXCategoryTitleView
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, kCategoryViewHeight)];
    self.categoryView.lineStyle = JXCategoryLineStyle_None;
    self.categoryView.titles = _arrType;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kMEPink;
    self.categoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _currentType;
    // Do any additional setup after loading the view.
}

#pragma mark - Setter And Getter

- (MEGetCaseContentVC *)allVC{
    if(!_allVC){
        _allVC = [[MEGetCaseContentVC alloc]initWithType:MEGetCaseAllStyle];
        _allVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _allVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_allVC];
    }
    return _allVC;
}

- (MEGetCaseContentVC *)getCaseIngVC{
    if(!_getCaseIngVC){
        _getCaseIngVC = [[MEGetCaseContentVC alloc]initWithType:MEGetCaseingStyle];
        _getCaseIngVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _getCaseIngVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_getCaseIngVC];
    }
    return _getCaseIngVC;
}

- (MEGetCaseContentVC *)GetCaseedVC{
    if(!_GetCaseedVC){
        _GetCaseedVC = [[MEGetCaseContentVC alloc]initWithType:MEGetCaseedStyle];
        _GetCaseedVC.view.frame = CGRectMake(SCREEN_WIDTH*2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _GetCaseedVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_GetCaseedVC];
    }
    return _GetCaseedVC;
}

- (MEGetCaseContentVC *)notGetCaseVC{
    if(!_notGetCaseVC){
        _notGetCaseVC = [[MEGetCaseContentVC alloc]initWithType:MEGetCasenotStyle];
        _notGetCaseVC.view.frame = CGRectMake(SCREEN_WIDTH*3,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _notGetCaseVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_notGetCaseVC];
    }
    return _notGetCaseVC;
}


@end
