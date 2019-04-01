//
//  MENewMineHomeVC.m
//  ME时代
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MENewMineHomeVC.h"
#import "MENewMineHomeHeaderView.h"
#import "MENewMineHomeCell.h"
#import "MEProductListVC.h"


@interface MENewMineHomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrtype;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) MENewMineHomeHeaderView *headerView;

@end

@implementation MENewMineHomeVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
    if([MEUserInfoModel isLogin]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
    }
    NSInteger f = [[[NSUserDefaults standardUserDefaults] objectForKey:kcheckFirstBuy] integerValue];
    if(f){
        HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:@"您有一次免费预约门店服务的机会"];
        alertView.isSupportRotating = YES;
        [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        }];
        kMeWEAKSELF
        [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
            kMeSTRONGSELF
            MEProductListVC *productList = [[MEProductListVC alloc]initWithType:MEGoodsTypeNetServiceStyle];
            [strongSelf.navigationController pushViewController:productList animated:YES];
        }];
        [alertView show];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self getUnMeaasge];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)getUnMeaasge{
    if([MEUserInfoModel isLogin] && _arrtype.count && self.tableView){
        kMeWEAKSELF
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
             [strongSelf.tableView reloadData];
        });
    }
}

- (void)userLogout{
    [self.navigationController popToViewController:self animated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUnMessage object:nil];
    [self.headerView clearUIWithUserInfo];
    _arrtype = @[];
    [self.tableView reloadData];
}

- (void)userLogin{
    [self loadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
}

- (void)loadData{
    kMeWEAKSELF
    [MEPublicNetWorkTool getUserGetUserWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        NSLog(@"%@",kCurrentUser.uid);
        kMeSTRONGSELF
        switch (kCurrentUser.user_type) {
            case 1:{
                //B
                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData),@(MeDynalApply)]];
            }
                break;
            case 2:{
                //
                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData),@(MeDynalApply)]];
            }
                break;
            case 4:{
                //C
                strongSelf->_arrtype = @[@[@(MeMyDistribution),@(MeMyExchange),@(MeMyAppointment),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeStoreApply),@(MeDynalApply)]];
            }
                break;
            case 3:{
                //B
                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData),@(MeDynalApply)]];
            }
                break;
            case 5:{
                //clerk
                strongSelf->_arrtype = @[@[@(MeMyDistribution),@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData),@(MeDynalApply)]];
            }
                break;
            default:{
                strongSelf->_arrtype = @[@[@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeDynalApply)]];
            }
                break;
        }
        [strongSelf.headerView reloadUIWithUserInfo];
        strongSelf.tableView.tableHeaderView = strongSelf.headerView;
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrtype.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MENewMineHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MENewMineHomeCell class]) forIndexPath:indexPath];
    NSArray *arr = _arrtype[indexPath.row];
    [cell setUIWithAtrr:arr];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = _arrtype[indexPath.row];
    return [MENewMineHomeCell getHeightWithArr:arr];;
}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MENewMineHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MENewMineHomeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"fafafa"];
    }
    return _tableView;
}

- (MENewMineHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MENewMineHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kMENewMineHomeHeaderViewHeight);
    }
    return _headerView;
}
@end
