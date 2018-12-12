//
//  MEClerkManngerVC.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEClerkManngerVC.h"
#import "MEClerkCell.h"
#import "MEClerkSearchVC.h"
#import "MENavigationVC.h"
#import "MEClerkSearchDataVC.h"
#import "MEAddClerkVC.h"
#import "MEClerkStatisticsVC.h"

@interface MEClerkManngerVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIButton *btnRight;
@end

@implementation MEClerkManngerVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
}

- (void)initSomeThing{
    self.title = @"店员管理";
    _consTopMargin.constant = kMeNavBarHeight;
    [_tableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([MEClerkCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEClerkCell class])];
    _tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableVIew.showsVerticalScrollIndicator = NO;
    _tableVIew.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    [self.refresh addRefreshView];
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    [self.refresh.arrData addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    return @{};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[NSObject mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.refresh.arrData[indexPath.row];
    MEClerkCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEClerkCell class]) forIndexPath:indexPath];
    [cell setUIWIthModel:model];
    kMeWEAKSELF
    cell.moreBlock = ^{
        MECustomActionSheet *sheet = [[MECustomActionSheet alloc]initWithTitles:@[@"删除",@"查看店员佣金统计"]];
        sheet.blockBtnTapHandle = ^(NSInteger index){
            if(index){
                kMeSTRONGSELF
                MEClerkStatisticsVC *vc = [[MEClerkStatisticsVC alloc]init];
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }else{
                MEAlertView *aler = [[MEAlertView alloc] initWithTitle:@"" message:@"确定删除该员工?"];
                [aler addButtonWithTitle:@"确定" block:^{
                    kMeSTRONGSELF
                   
                }];
                [aler addButtonWithTitle:@"取消"];
                [aler show];
            }
        };
        [sheet show];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMEClerkCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)toAddClerk:(UIButton *)btn{
    MEAddClerkVC *vc = [[MEAddClerkVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toSearchClerk:(UIButton *)sender {
    MEClerkSearchVC *searchViewController = [MEClerkSearchVC searchViewControllerWithHotSearches:@[] searchBarPlaceholder:@"搜索店员" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        MEClerkSearchDataVC *dataVC = [[MEClerkSearchDataVC alloc]initWithKey:searchText];
        [searchViewController.navigationController pushViewController:dataVC animated:YES];
    }];
    MENavigationVC *nav = [[MENavigationVC alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}


- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableVIew url:kGetApiWithUrl(@"")];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有店员";
        }];
    }
    return _refresh;
}

- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(-20, 0, 30, 25);
        [_btnRight setTitle:@"添加" forState:UIControlStateNormal];
        _btnRight.titleLabel.font = kMeFont(14);
        [_btnRight setTitleColor:kMEPink forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(toAddClerk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}


@end
