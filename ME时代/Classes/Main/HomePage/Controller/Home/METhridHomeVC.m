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
#import "MEAdModel.h"
#import "MERushBuyView.h"
#import "METhridProductDetailsVC.h"
#import "METhridHomeModel.h"
#import "MEPinduoduoCoupleModel.h"
#import "METhridHomeRudeTimeModel.h"
#import "METhridHomeRudeGoodModel.h"
#import "MECoupleMailDetalVC.h"
#import "MENetListModel.h"


@interface METhridHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _selectTimeIndex;
    NSArray *_arrRudeBuy;
    NSArray *_arrRudeTime;
    NSArray *_arrCommonCoupon;
    METhridHomeModel *_homeModel;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) METhridHomeHeaderView *headerView;
@property (nonatomic, strong) METhridHomeNavView *navView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@end

@implementation METhridHomeVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor = kMEf5f4f4;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    _selectTimeIndex = 0;
    _arrRudeBuy = [NSArray array];
    _arrCommonCoupon = [NSArray array];
    _arrRudeTime = [NSArray array];
    _homeModel = [METhridHomeModel new];
    self.tableView.tableHeaderView = self.headerView;
    [self.refresh addRefreshView];
    [self getRushGood];
    [self getUnInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUnInfo) name:kUnNoticeMessage object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
}

- (void)userLogout{
    [self.navView setRead:YES];
}

- (void)userLogin{
    [self getUnInfo];
}

- (void)getUnInfo{
    if([MEUserInfoModel isLogin]){
        kMeWEAKSELF
        [MEPublicNetWorkTool getUserCountListWithSuccessBlock:^(ZLRequestResponse *responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    kMeSTRONGSELF
                    if(strongSelf->_navView){
                        NSInteger unread = [responseObject.data integerValue];
                        [strongSelf.navView setRead:!unread];
                    }
                });
        } failure:^(id object) {
        }];
    }
}

- (void)getNetWork{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    kMeWEAKSELF
    dispatch_group_async(group, queue, ^{
        [MEPublicNetWorkTool postThridHomeStyleWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_homeModel = [METhridHomeModel mj_objectWithKeyValues:responseObject.data];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_async(group, queue, ^{
        [MEPublicNetWorkTool postGetPinduoduoCommondPoductWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_arrCommonCoupon =[MEPinduoduoCoupleModel mj_objectArrayWithKeyValuesArray:responseObject.data[@"goods_search_response"][@"goods_list"]];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_async(group, queue, ^{
        [MEPublicNetWorkTool postThridHomeGetSeckillTimeSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_arrRudeTime =[METhridHomeRudeTimeModel mj_objectArrayWithKeyValuesArray:responseObject.data];
            for (NSInteger i =0; i<strongSelf->_arrRudeTime.count; i++) {
                METhridHomeRudeTimeModel *model = strongSelf->_arrRudeTime[i];
                if(model.status==1){
                    strongSelf->_selectTimeIndex = i;
                }
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            [strongSelf->_headerView setUIWithModel:strongSelf->_homeModel];
            strongSelf->_headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [METhridHomeHeaderView getViewHeightWithModel:strongSelf->_homeModel]);
            [strongSelf getRushGoods];
            strongSelf.tableView.tableHeaderView = strongSelf->_headerView;
            [strongSelf.tableView reloadData];
        });
    });
}
-(void)getRushGoods{
    if(!kMeUnArr(_arrRudeTime).count){
        _arrRudeBuy = @[];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    METhridHomeRudeTimeModel *model = _arrRudeTime[_selectTimeIndex];
    kMeWEAKSELF
    [MEPublicNetWorkTool postThridHomegetSeckillGoodsWithSeckillTime:kMeUnNilStr(model.time) SuccessBlock:^(ZLRequestResponse *responseObject) {
        MENetListModel *nlModel = [MENetListModel mj_objectWithKeyValues:responseObject.data];
        kMeSTRONGSELF
        strongSelf->_arrRudeBuy =[METhridHomeRudeGoodModel mj_objectArrayWithKeyValuesArray:nlModel.data];
        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(id object) {
        kMeSTRONGSELF
        strongSelf->_arrRudeBuy = @[];
        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

//弹窗
- (void)getRushGood{
    kMeWEAKSELF
    [MEPublicNetWorkTool postRushGoodWithsuccessBlock:^(ZLRequestResponse *responseObject) {
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            MEAdModel *model = [MEAdModel mj_objectWithKeyValues:responseObject.data];
            [MERushBuyView ShowWithModel:model tapBlock:^{
                if(model.product_id!=0){
                    kMeSTRONGSELF
                    strongSelf.tabBarController.selectedIndex = 0;
                    METhridProductDetailsVC *dvc = [[METhridProductDetailsVC alloc]initWithId:model.product_id];
                    [strongSelf.navigationController pushViewController:dvc animated:YES];
                }
            } cancelBlock:^{
                
            } superView:weakSelf.view];
        }
    } failure:^(id object) {
        
    }];
}

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self getNetWork];
    }
    return @{@"sort_type":@"12"};
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
            if(kMeUnArr(_arrRudeTime).count){
                METhridHomeRudeTimeModel *model = _arrRudeTime[_selectTimeIndex];
                cell.time = kMeUnNilStr(model.time);
            }
            [cell setUIWithArr:_arrRudeBuy];
            return cell;
        }else if (indexPath.row==1){
            MECommondCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECommondCouponCell class]) forIndexPath:indexPath];
            [cell setUIWithArr:_arrCommonCoupon imgUrl:kMeUnNilStr(_homeModel.coupon_background.img)];
            return cell;
        }
    }else if (indexPath.section==1){
        MECoupleHomeMainGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class]) forIndexPath:indexPath];
        [cell setPinduoduoUIWithArr:self.refresh.arrData];
        kMeWEAKSELF
        cell.selectBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            MEPinduoduoCoupleModel *model = strongSelf.refresh.arrData[index];
            MECoupleMailDetalVC *vc = [[MECoupleMailDetalVC alloc]initWithPinduoudoModel:model];
            [strongSelf.navigationController pushViewController:vc animated:YES];
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
    if(indexPath.section == 0 && indexPath.row == 1){
        if(_homeModel && _homeModel.coupon_background && _homeModel.coupon_background.product_id){
            METhridProductDetailsVC *details = [[METhridProductDetailsVC alloc]initWithId:_homeModel.coupon_background.product_id];
            [self.navigationController pushViewController:details animated:YES];
        }
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
        [headview setUIWithArr:_arrRudeTime selectIndex:_selectTimeIndex selectBlock:^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_selectTimeIndex = index;
            [strongSelf getRushGoods];
        }];
        return headview;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
        view.backgroundColor = kMEf6f6f6;
        UILabel *lbl = [MEView lblWithFram:CGRectMake(11, 0, SCREEN_WIDTH-22, 41) textColor:kMEblack str:@"拼多多优惠券" font:kMeFont(16)];
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
        _tableView.backgroundColor = kMEf5f4f4;
    }
    return _tableView;
}

- (METhridHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"METhridHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [METhridHomeHeaderView getViewHeightWithModel:_homeModel]);
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
