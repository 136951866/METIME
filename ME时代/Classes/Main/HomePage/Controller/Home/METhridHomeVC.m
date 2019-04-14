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
#import "MEStoreModel.h"
#import "MENewStoreDetailsVC.h"
#import "MEAIHomeVC.h"
#import "MEAIDataHomeTimeVC.h"
#import "METhridHomeHotCell.h"
//#import <MediaPlayer/MediaPlayer.h>
#import "MEBasePlayerVC.h"
#import "METhridHomeHotGoodModel.h"

const static CGFloat kImgStore = 50;
@interface METhridHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _selectTimeIndex;
    NSArray *_arrRudeBuy;
    NSArray *_arrRudeTime;
    NSArray *_arrCommonCoupon;
    NSArray *_arrHot;
    METhridHomeModel *_homeModel;
    CGFloat _sectionHeaderHeight;
    CGFloat _alphaNum;
    MEStoreModel *_stroeModel;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) METhridHomeHeaderView *headerView;
@property (nonatomic, strong) METhridHomeNavView *navView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIImageView *imgStore;
@end

@implementation METhridHomeVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor = kMEf5f4f4;
    _sectionHeaderHeight = kMEThridHomeNavViewHeight;
    _alphaNum = (kSdHeight*kMeFrameScaleX())+80;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.imgStore];
    _selectTimeIndex = 0;
    _arrHot = [NSArray array];
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
    _stroeModel = nil;
    [_headerView setUIWithModel:_homeModel stroeModel:_stroeModel];
    _imgStore.image = [UIImage imageNamed:@"icon-wgvilogo"];
//    [_navView setStoreInfoWithModel:_stroeModel];
}

- (void)userLogin{
    [self getUnInfo];
    [self.refresh reload];
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
        [MEPublicNetWorkTool postGetappHomePageDataWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
                strongSelf->_stroeModel = [MEStoreModel mj_objectWithKeyValues:responseObject.data];
            }else{
                strongSelf->_stroeModel = nil;
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf->_stroeModel = nil;
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
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
    
    dispatch_group_async(group, queue, ^{
        [MEPublicNetWorkTool postGetappThridHomePagHotGoodWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if ([responseObject.data isKindOfClass:[NSArray class]]) {
                strongSelf->_arrHot =[METhridHomeHotGoodModel mj_objectArrayWithKeyValuesArray:responseObject.data];
            }else{
                strongSelf->_arrHot = [NSArray array];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf->_arrHot = [NSArray array];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            [strongSelf->_headerView setUIWithModel:strongSelf->_homeModel stroeModel:strongSelf->_stroeModel];
            if(strongSelf->_stroeModel){
                 kSDLoadImg(strongSelf->_imgStore, kMeUnNilStr(strongSelf->_stroeModel.mask_img));
            }else{
                strongSelf->_imgStore.image = [UIImage imageNamed:@"icon-wgvilogo"];
            }
            strongSelf->_imgStore.hidden = YES;
//            [strongSelf->_navView setStoreInfoWithModel:strongSelf->_stroeModel];
//            strongSelf->_headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [METhridHomeHeaderView getViewHeightWithModel:strongSelf->_homeModel]);
            [strongSelf getRushGoods];
            strongSelf.tableView.tableHeaderView = strongSelf->_headerView;
            [strongSelf.tableView reloadData];
        });
    });
}
-(void)getRushGoods{
    if(!kMeUnArr(_arrRudeTime).count){
        _arrRudeBuy = @[];
        [_tableView reloadData];
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    METhridHomeRudeTimeModel *model = _arrRudeTime[_selectTimeIndex];
    kMeWEAKSELF
    [MEPublicNetWorkTool postThridHomegetSeckillGoodsWithSeckillTime:kMeUnNilStr(model.time) SuccessBlock:^(ZLRequestResponse *responseObject) {
        MENetListModel *nlModel = [MENetListModel mj_objectWithKeyValues:responseObject.data];
        kMeSTRONGSELF
        strongSelf->_arrRudeBuy =[METhridHomeRudeGoodModel mj_objectArrayWithKeyValuesArray:nlModel.data];
        [strongSelf.tableView reloadData];
//        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(id object) {
        kMeSTRONGSELF
        strongSelf->_arrRudeBuy = @[];
        [strongSelf.tableView reloadData];
//        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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

- (void)toStore{
//    if(_stroeModel){
//        MENewStoreDetailsVC *details = [[MENewStoreDetailsVC alloc]initWithId:_stroeModel.store_id];
//        [self.navigationController pushViewController:details animated:YES];
//    }else{
//        self.tabBarController.selectedIndex = 1;
//    }
}

- (void)payWithModel:(NSString *)model{
    MEBasePlayerVC *vc = [[MEBasePlayerVC alloc]initWithFileUrl:model];
    [self.navigationController pushViewController:vc animated:YES];
//    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:model]];
//    [[vc moviePlayer] prepareToPlay];
//    [self presentMoviePlayerViewControllerAnimated:vc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?1:kMeUnArr(_arrHot).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section== 0){
        METhridHomeHotCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([METhridHomeHotCell class]) forIndexPath:indexPath];
        METhridHomeHotGoodModel *model = _arrHot[indexPath.row];
        kMeWEAKSELF
        [cell setUIWIthModel:model payBlock:^{
            kMeSTRONGSELF
            [strongSelf payWithModel:kMeUnNilStr(model.is_index_hot_video_url)];
        }];
        return cell;
    }else if(indexPath.section==1){
        MERushBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MERushBuyCell class]) forIndexPath:indexPath];
        if(kMeUnArr(_arrRudeTime).count){
            METhridHomeRudeTimeModel *model = _arrRudeTime[_selectTimeIndex];
            cell.time = kMeUnNilStr(model.time);
        }
        [cell setUIWithArr:_arrRudeBuy];
        return cell;
    }else if (indexPath.section==2){
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
        return kMEThridHomeHotCellHeight;
    }else if(indexPath.section==1){
        return [MERushBuyCell getCellHeightWithArr:_arrRudeBuy];
    }else if (indexPath.section==2){
        return [MECoupleHomeMainGoodGoodsCell getCellHeightWithArr:self.refresh.arrData];;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        METhridHomeHotGoodModel *model = _arrHot[indexPath.row];
        METhridProductDetailsVC *details = [[METhridProductDetailsVC alloc]initWithId:model.product_id];
        [self.navigationController pushViewController:details animated:YES];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *arrTitle = @[@"爆款区",@"限时抢购",@"拼多多卷"];
    NSString *str = arrTitle[section];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
    view.backgroundColor = kMEf6f6f6;
    UILabel *lbl = [MEView lblWithFram:CGRectMake(11, 0, SCREEN_WIDTH-22, 52) textColor:kMEblack str:str font:kMeFont(18)];
    [view addSubview:lbl];
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = _sectionHeaderHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        _navView.hidden = NO;
        CGFloat alpha = scrollView.contentOffset.y/kMEThridHomeNavViewHeight;
        [_navView setBackAlpha:alpha];
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y<0) {
        _navView.hidden = YES;
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        [_navView setBackAlpha:1];
        _navView.hidden = NO;
        scrollView.contentInset = UIEdgeInsetsMake(sectionHeaderHeight, 0, 0, 0);
    }
    
    if(scrollView.contentOffset.y>=_alphaNum){
        _imgStore.hidden = NO;
    }else if (scrollView.contentOffset.y<0){
        _imgStore.hidden = YES;
    }else{
         _imgStore.hidden = YES;
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MERushBuyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MERushBuyCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MECoupleHomeMainGoodGoodsCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([METhridHomeHotCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([METhridHomeHotCell class])];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kMEf5f4f4;
        _tableView.scrollsToTop = NO;
    }
    return _tableView;
}

- (UIImageView *)imgStore{
    if(!_imgStore){
        _imgStore = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-k15Margin-kImgStore, SCREEN_HEIGHT-kMeTabBarHeight-k15Margin-kImgStore, kImgStore, kImgStore)];
        _imgStore.cornerRadius = kImgStore/2;
        _imgStore.clipsToBounds = YES;
        _imgStore.hidden = YES;
        _imgStore.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toStore)];
        [_imgStore addGestureRecognizer:ges];
    }
    return _imgStore;
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
