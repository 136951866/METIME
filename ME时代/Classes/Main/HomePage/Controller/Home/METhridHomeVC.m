//
//  METhridHomeVC.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeVC.h"
#import "METhridHomeHeaderView.h"
#import "METhridHomeTimeSecionView.h"
#import "MERushBuyCell.h"
#import "MECommondCouponCell.h"
#import "MEPinduoduoCoupleModel.h"
#import "MECoupleHomeMainGoodGoodsCell.h"
#import "METhridHomeNavView.h"
#import "MEShoppingMallVC.h"
#import "MECoupleHomeVC.h"


@interface METhridHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _selectTimeIndex;
    NSArray *_arrRudeBuy;
    NSArray *_arrCommonCoupon;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) METhridHomeHeaderView *headerView;
@property (nonatomic, strong) METhridHomeNavView *navView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@end

@implementation METhridHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    _selectTimeIndex = 0;
    _arrRudeBuy = @[@"",@"",@"",@"",@"",@""];
    _arrCommonCoupon = @[@"",@"",@"",@"",@"",@""];
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView setUIWithModel:@[]];
    [self.refresh addRefreshView];
#warning <#message#>
    MEShoppingMallVC *vc = [[MEShoppingMallVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSDictionary *)requestParameter{
    return @{@"sort_type":@"8"};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[MEPinduoduoCoupleModel mj_objectArrayWithKeyValuesArray:data]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?1:2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            MERushBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MERushBuyCell class]) forIndexPath:indexPath];
            [cell setUIWithArr:_arrRudeBuy];
            return cell;
        }else if (indexPath.row==1){
            MECommondCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECommondCouponCell class]) forIndexPath:indexPath];
            [cell setUIWithArr:_arrCommonCoupon imgUrl:@""];
            return cell;
        }
    }else if (indexPath.section==1){
        MECoupleHomeMainGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class]) forIndexPath:indexPath];
        [cell setPinduoduoUIWithArr:self.refresh.arrData];
        kMeWEAKSELF
        cell.selectBlock = ^{
            kMeSTRONGSELF
        };
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            return [MERushBuyCell getCellHeightWithArr:_arrRudeBuy];
        }else if (indexPath.row==1){
            return [MECommondCouponCell getCellHeight];
        }
    }else if (indexPath.section==1){
        return [MECoupleHomeMainGoodGoodsCell getCellHeightWithArr:self.refresh.arrData];;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section){
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(!section){
        return kMEThridHomeTimeSecionViewHeight;
    }
    return 41;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(!section){
        METhridHomeTimeSecionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([METhridHomeTimeSecionView class])];
        kMeWEAKSELF
        [headview setUIWithArr:@[@"",@"",@"",@"",@"",@"",@""] selectIndex:_selectTimeIndex selectBlock:^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_selectTimeIndex = index;
            [strongSelf.tableView reloadData];
        }];
        return headview;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
        view.backgroundColor = kMEf6f6f6;
        UILabel *lbl = [MEView lblWithFram:CGRectMake(11, 0, SCREEN_WIDTH-22, 41) textColor:kMEblack str:@"拼多多优惠卷" font:kMeFont(16)];
        [view addSubview:lbl];
        return view;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = kMEThridHomeNavViewHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        _navView.hidden = NO;
        CGFloat alpha = scrollView.contentOffset.y/kMEThridHomeNavViewHeight;
        [_navView setBackAlpha:alpha];
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y<0) {
        _navView.hidden = YES;
    }else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        [_navView setBackAlpha:1];
        _navView.hidden = NO;
        scrollView.contentInset = UIEdgeInsetsMake(sectionHeaderHeight, 0, 0, 0);
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MERushBuyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MERushBuyCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECommondCouponCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MECommondCouponCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([METhridHomeTimeSecionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([METhridHomeTimeSecionView class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kMEf6f6f6;
    }
    return _tableView;
}

- (METhridHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"METhridHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [METhridHomeHeaderView getViewHeight]);
    }
    return _headerView;
}

- (METhridHomeNavView *)navView{
    if(!_navView){
        _navView = [[METhridHomeNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMEThridHomeNavViewHeight)];
    }
    return _navView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(MEIPcommonduoduokeGetgetGoodsList)];
        _refresh.delegate = self;
        _refresh.isCoupleMater = NO;
        _refresh.isPinduoduoCoupleMater = YES;
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
    }
    return _refresh;
}

@end
