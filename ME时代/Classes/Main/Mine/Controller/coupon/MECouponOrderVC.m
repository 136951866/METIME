//
//  MECouponOrderVC.m
//  ME时代
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import "MECouponOrderVC.h"
#import "MECouponOrderCell.h"
#import "MECouponOrderHeaderView.h"
#import "MECouponMoneyModel.h"
#import "MECouponDetailModel.h"
#import "MECouponOrderSectionView.h"

@interface MECouponOrderVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    MECouponDetailModel *_modeldatil;
    MECouponOrderSectionViewType _type;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) MECouponOrderHeaderView         *headerView;

@end

@implementation MECouponOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券明细";
    _type = MECouponOrderSectionViewPinduoduoType;
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self requestNet];
    }
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)requestNet{
    kMeWEAKSELF
    [MEPublicNetWorkTool postGetPinduoduoBrokerageDetailBaseWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            strongSelf->_modeldatil = [MECouponDetailModel mj_objectWithKeyValues:responseObject.data];
            [strongSelf->_headerView setUIWithModel:strongSelf->_modeldatil block:^{
                
            }];
        }
    } failure:^(id object) {
        
    }];
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[MECouponMoneyModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MECouponMoneyModel *model = self.refresh.arrData[indexPath.row];
    MECouponOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECouponOrderCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMECouponOrderCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MECouponOrderSectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([MECouponOrderSectionView class])];
    kMeWEAKSELF
    headview.type = _type;
    headview.selectBlock = ^(NSInteger index) {
        kMeSTRONGSELF
        strongSelf->_type = index;
        [strongSelf.refresh reload];
    };
    return headview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kMECouponOrderSectionViewHeight;
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECouponOrderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MECouponOrderCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECouponOrderSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([MECouponOrderSectionView class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = kMEededed;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(MEIPcommonduoduokeGetBrokerageDetailGoods)];
        _refresh.delegate = self;
//        _refresh.showFailView = NO;
        _refresh.showMaskView = YES;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.top = failView.top+kMECouponOrderSectionViewHeight;
            failView.backgroundColor = [UIColor clearColor];
            failView.lblOfNodata.text = @"没有订单";
        }];
    }
    return _refresh;
}

- (MECouponOrderHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MECouponOrderHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kMECouponOrderHeaderViewHeight);
    }
    return _headerView;
}

@end
