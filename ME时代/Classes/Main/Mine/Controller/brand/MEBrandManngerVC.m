//
//  MEBrandManngerVC.m
//  ME时代
//
//  Created by hank on 2019/3/8.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandManngerVC.h"
#import "MEBrandManngerAllContentVC.h"

@interface MEBrandManngerVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong , nonatomic) MEBrandManngerAllContentVC *allVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;

@end

@implementation MEBrandManngerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"品牌管理";
    _consTopMargin.constant = kMeNavBarHeight;
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT-kMeNavBarHeight-kMEBrandManngerVCHeaderHeight);
    [_scrollview addSubview:self.allVC.view];
    // Do any additional setup after loading the view from its nib.
}

- (MEBrandManngerAllContentVC *)allVC{
    if(!_allVC){
        _allVC = [[MEBrandManngerAllContentVC alloc]init];
        _allVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _allVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMEBrandManngerVCHeaderHeight);
        [self addChildViewController:_allVC];
    }
    return _allVC;
}

@end
