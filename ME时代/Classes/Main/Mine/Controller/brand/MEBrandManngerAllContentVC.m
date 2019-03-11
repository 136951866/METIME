//
//  MEBrandManngerAllContentVC.m
//  ME时代
//
//  Created by hank on 2019/3/8.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandManngerAllContentVC.h"
#import "MEBrandManngerVC.h"
#import "MEBrandAllDataCell.h"
#import "MEBrandTriangleCell.h"
#import "MEBrandAreasplineCell.h"
#import "MEBrandPieCell.h"
#import "MEPolarChartMixedCell.h"

@interface MEBrandManngerAllContentVC ()<UITableViewDelegate, UITableViewDataSource,JXCategoryViewDelegate>{
    NSInteger _currentType;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@end

@implementation MEBrandManngerAllContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    _currentType = 0;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefresh)];
    [self.tableView.mj_header beginRefreshing];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, kCategoryViewHeight)];
    //    self.categoryView.lineStyle = JXCategoryLineStyle_None;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    
    self.categoryView.titles = @[@"全部",@"昨天",@"7天",@"30天"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kMEPink;
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _currentType;
    // Do any additional setup after loading the view.
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    _currentType = index;
}

- (void)headrefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        MEBrandAllDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandAllDataCell class]) forIndexPath:indexPath];
         return cell;
    }else if (indexPath.row == 1){
        MEBrandTriangleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandTriangleCell class]) forIndexPath:indexPath];
        return cell;
    }else if(indexPath.row == 2){
        MEBrandAreasplineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandAreasplineCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:@"" title:@"近7日客户活跃度"];
        return cell;
    }else if(indexPath.row == 3){
        MEBrandPieCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandPieCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:@""];
        return cell;
    }else if(indexPath.row == 4){
        MEBrandAreasplineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandAreasplineCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:@"" title:@"近7日新增客户数"];
        return cell;
    }else if(indexPath.row == 5){
        MEPolarChartMixedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEPolarChartMixedCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:@""];
        return cell;
    }else{
        MEBrandAllDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandAllDataCell class]) forIndexPath:indexPath];
        return cell;
    }
    
//
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return kMEBrandAllDataCellHeight;
    }else if (indexPath.row == 1){
        return kMEBrandTriangleCellHeight;
    }else  if(indexPath.row == 2){
        return kMEBrandAreasplineCellHeight;
    }else  if(indexPath.row == 3){
        return kMEBrandPieCellHeight;
    }else  if(indexPath.row == 4){
        return kMEBrandAreasplineCellHeight;
    }else  if(indexPath.row == 5){
        return kMEPolarChartMixedCellHeight;
    }else{
        return kMEBrandAllDataCellHeight;
    }


}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMEBrandManngerVCHeaderHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBrandAllDataCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBrandAllDataCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBrandTriangleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBrandTriangleCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBrandAreasplineCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBrandAreasplineCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBrandPieCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBrandPieCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEPolarChartMixedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEPolarChartMixedCell class])];
//
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


@end
