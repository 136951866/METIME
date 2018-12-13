//
//  MEClerkStatisticsVC.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEClerkStatisticsVC.h"
#import "MEGetCaseCell.h"
#import "MEClerkStatisticHeaderView.h"

@interface MEClerkStatisticsVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) MEClerkStatisticHeaderView *headrView;
@end

@implementation MEClerkStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店员佣金统计";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headrView;
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

- (NSDictionary *)requestParameter{
    [self.refresh.arrData addObjectsFromArray:@[@"",@"",@"",@"",@""]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"] = kMeUnNilStr(kCurrentUser.token);
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[NSObject mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MEGetCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEGetCaseCell class]) forIndexPath:indexPath];
    id model = self.refresh.arrData[indexPath.row];
    [cell setUIDataDealWIthModel:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.refresh.arrData[indexPath.row];
    return [MEGetCaseCell getCellDataDealHeightWithModel:model];
}

#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEGetCaseCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEGetCaseCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(@"")];
        _refresh.isDataInside = YES;
        _refresh.isGet = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有佣金";
        }];
    }
    return _refresh;
}

- (MEClerkStatisticHeaderView *)headrView{
    if(!_headrView){
        _headrView = [[[NSBundle mainBundle]loadNibNamed:@"MEClerkStatisticHeaderView" owner:nil options:nil] lastObject];
        _headrView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kMEClerkStatisticHeaderViewHeight);
    }
    return _headrView;
}

@end
