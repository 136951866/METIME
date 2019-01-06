//
//  MECoupleHomeVC.m
//  ME时代
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECoupleHomeVC.h"
#import "MECoupleHomeHeaderView.h"
#import "MECoupleHomeNavView.h"
#import "MECoupleHomeMainCell.h"
#import "MECoupleHomeMainGoodGoodsCell.h"
#import "MECoupleModel.h"
#import "MECouponSearchVC.h"
#import "MENavigationVC.h"
#import "MECoupleMailVC.h"
#import "MEAdModel.h"

@interface MECoupleHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSArray *_todayBuy;
    NSArray *_99BuyBuy;
//    NSArray *_BigJuanBuy;
    NSArray *_advArr;
}

@property (nonatomic, strong) MECoupleHomeHeaderView         *headerView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) MECoupleHomeNavView *navView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MECoupleHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor = kMEfbfbfb;
    _todayBuy = [NSArray array];
    _99BuyBuy = [NSArray array];
//    _BigJuanBuy = [NSArray array];
    _advArr = [NSArray array];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.headerView;
    [self.refresh addRefreshView];
}

- (void)requestNetWork{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        kMeWEAKSELF
        [MEPublicNetWorkTool postAgetTbkBannerWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_advArr = [MEAdModel mj_objectArrayWithKeyValuesArray:responseObject.data];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        kMeWEAKSELF
        [MEPublicNetWorkTool postCoupledgMaterialOptionalWithType:MECouponSearchTopBuyType successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            id arrDIc = responseObject.data[@"tbk_dg_material_optional_response"][@"result_list"][@"map_data"];
            if([arrDIc isKindOfClass:[NSArray class]]){
                strongSelf->_todayBuy = [MECoupleModel mj_objectArrayWithKeyValuesArray:arrDIc];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    //9.9
    dispatch_group_async(group, queue, ^{
        kMeWEAKSELF
        [MEPublicNetWorkTool postCoupledgMaterialOptionalWithType:MECouponSearch99BuyType successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            id arrDIc = responseObject.data[@"tbk_dg_material_optional_response"][@"result_list"][@"map_data"];
            if([arrDIc isKindOfClass:[NSArray class]]){
                strongSelf->_99BuyBuy = [MECoupleModel mj_objectArrayWithKeyValuesArray:arrDIc];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    //大额券
//    dispatch_group_async(group, queue, ^{
//        kMeWEAKSELF
//        [MEPublicNetWorkTool postCoupledgMaterialOptionalWithType:MECouponSearchBigJuanType successBlock:^(ZLRequestResponse *responseObject) {
//            kMeSTRONGSELF
//            id arrDIc = responseObject.data[@"tbk_dg_material_optional_response"][@"result_list"][@"map_data"];
//            if([arrDIc isKindOfClass:[NSArray class]]){
//                strongSelf->_BigJuanBuy = [MECoupleModel mj_objectArrayWithKeyValuesArray:arrDIc];
//            }
//            dispatch_semaphore_signal(semaphore);
//        } failure:^(id object) {
//            dispatch_semaphore_signal(semaphore);
//        }];
//    });
    kMeWEAKSELF
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            [strongSelf->_headerView setUiWithModel:strongSelf->_advArr];
//            [strongSelf.tableView.mj_header endRefreshing];
            [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:0];
        });
    });
}


- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self requestNetWork];
    }
    return @{@"type":@(MECouponSearchGoodGoodsType)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[MECoupleModel mj_objectArrayWithKeyValuesArray:data]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return [UIView new];
    }
    CGFloat imageh = (SCREEN_WIDTH*80)/750;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goodgoods"]];
    img.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageh);
    return img;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.1;
    }
    return (SCREEN_WIDTH*80)/750;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            MECoupleHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECoupleHomeMainCell class]) forIndexPath:indexPath];
            [cell setUIWithArr:_todayBuy type:indexPath.row];
            return cell;
        }else if(indexPath.row == 1){
            MECoupleHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECoupleHomeMainCell class]) forIndexPath:indexPath];
            [cell setUIWithArr:_99BuyBuy type:indexPath.row];
            return cell;
        }else{
            return [UITableViewCell new];
        }
//        else if(indexPath.row == 2){
//            MECoupleHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECoupleHomeMainCell class]) forIndexPath:indexPath];
//            [cell setUIWithArr:_BigJuanBuy type:indexPath.row];
//            return cell;
//        }
    }else{
        MECoupleHomeMainGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:self.refresh.arrData];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
           return [MECoupleHomeMainCell getCellHeightWithArr:_todayBuy];
        }else if(indexPath.row == 1){
           return [MECoupleHomeMainCell getCellHeightWithArr:_99BuyBuy];
        }else{
            return 0;
        }
//        else if(indexPath.row == 2){
//            return [MECoupleHomeMainCell getCellHeightWithArr:_BigJuanBuy];
//        }
    }else{
       return [MECoupleHomeMainGoodGoodsCell getCellHeightWithArr:self.refresh.arrData];
    }
}

- (void)searchCoupon{
    MECouponSearchVC *searchViewController = [MECouponSearchVC searchViewControllerWithHotSearches:@[] searchBarPlaceholder:@"搜索优惠卷" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        MECoupleMailVC *dataVC = [[MECoupleMailVC alloc]initWithQuery:searchText];
        [searchViewController.navigationController pushViewController:dataVC animated:YES];
    }];
    [searchViewController setSearchHistoriesCachePath:kMECouponSearchVCSearchHistoriesCachePath];
    MENavigationVC *nav = [[MENavigationVC alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECoupleHomeMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MECoupleHomeMainCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kMEfbfbfb;
    }
    return _tableView;
}

- (MECoupleHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MECoupleHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, [MECoupleHomeHeaderView getViewHeight]);
    }
    return _headerView;
}

- (MECoupleHomeNavView *)navView{
    if(!_navView){
        _navView = [[[NSBundle mainBundle]loadNibNamed:@"MECoupleHomeNavView" owner:nil options:nil] lastObject];
        _navView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kMeNavBarHeight);
        kMeWEAKSELF
        _navView.backBlock = ^{
            kMeSTRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
        _navView.searchBlock = ^{
            kMeSTRONGSELF
            [strongSelf searchCoupon];
        };
    }
    return _navView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(MEIPcommonTaobaokeGetDgMaterialOptional)];
        _refresh.delegate = self;
        _refresh.isCoupleMater = YES;
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
    }
    return _refresh;
}



@end
