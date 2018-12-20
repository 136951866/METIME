//
//  MEGiftVC.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGiftVC.h"
#import "MEGiftMainCell.h"
#import "MEGiftHeaderView.h"
#import "MEGiftFooterView.h"
#import "MEGiftMainNilCell.h"

@interface MEGiftVC ()<UITableViewDelegate,UITableViewDataSource>{
    id _model;
    BOOL _isNil;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MEGiftHeaderView         *headerView;
@property (nonatomic, strong) MEGiftFooterView         *footerView;
@end

@implementation MEGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"许愿屋";
    _isNil =YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
    [self.tableView.mj_header beginRefreshing];

    // Do any additional setup after loading the view.
}

- (void)requestNetWork{
    [self.view addSubview:self.tableView];
    [self.headerView setUiWithModel:nil];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isNil){
        MEGiftMainNilCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEGiftMainNilCell class]) forIndexPath:indexPath];
        return cell;
    }
    MEGiftMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEGiftMainCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:_model block:^{
        
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isNil){
        return kMEGiftMainNilCellHeight;
    }
    return [MEGiftMainCell getCellHeightWithModel:_model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _isNil = !_isNil;
    [self.headerView setUiWithModel:nil];
    [self.footerView setUIWithModel:nil contentBlock:^(NSString *str) {
        
    }];
    self.tableView.tableHeaderView = self.headerView;
     self.tableView.tableFooterView = self.footerView;
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEGiftMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEGiftMainCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEGiftMainNilCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEGiftMainNilCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = self.footerView;
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (MEGiftHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MEGiftHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, [MEGiftHeaderView getViewHeight]);
    }
    return _headerView;
}

- (MEGiftFooterView *)footerView{
    if(!_footerView){
        _footerView = [[[NSBundle mainBundle]loadNibNamed:@"MEGiftFooterView" owner:nil options:nil] lastObject];
        _footerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kMEGiftFooterViewHeight);
    }
    return _footerView;
}

@end
