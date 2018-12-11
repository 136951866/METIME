//
//  MEAppointmentDetailVC.m
//  ME时代
//
//  Created by hank on 2018/9/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEAppointmentDetailVC.h"
#import "MEMyOrderDetailCell.h"
#import "MEOrderDetailView.h"
#import "MEOrderDetailContentCell.h"
#import "MEAppointDetailModel.h"

@interface MEAppointmentDetailVC ()<UITableViewDelegate, UITableViewDataSource>{
    MEAppointmenyStyle _appointType;
    NSString *_reserve_sn;
    MEAppointDetailModel *_detaliModel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) MEOrderDetailView *headerView;
@property (nonatomic, strong) NSArray *arrDataStr;
//@property (nonatomic, strong) NSArray *arrChild;
@end

@implementation MEAppointmentDetailVC

- (instancetype)initWithOrderreserve_sn:(NSString *)reserve_sn{
    if(self = [super init]){
        _reserve_sn = reserve_sn;
    }
    return self;
}

- (instancetype)initWithType:(MEAppointmenyStyle)type reserve_sn:(NSString *)reserve_sn{
    if(self = [super init]){
        _appointType = type;
        _reserve_sn = reserve_sn;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约详情";
    kMeWEAKSELF
    [MEPublicNetWorkTool postAppointDetailWithReserve_sn:_reserve_sn successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_detaliModel =  [MEAppointDetailModel mj_objectWithKeyValues:responseObject.data];
        if( strongSelf->_detaliModel.is_first_buy){
            strongSelf->_arrData = @[@(MEAppointmentSettlmentTime),@(MEAppointmentSettlmentFristBuy)];
            strongSelf.arrDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.arrive_time),@""];
        }else{
            strongSelf->_arrData = @[@(MEAppointmentSettlmentTime)];
            strongSelf.arrDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.arrive_time)];
        }

//        strongSelf.arrChild = @[strongSelf->_detaliModel];
        strongSelf.tableView.tableHeaderView =strongSelf.headerView;
        [strongSelf.view addSubview:strongSelf.tableView];
        [strongSelf.tableView reloadData];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section){
        return _arrData.count;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section){
        MEMyOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEMyOrderDetailCell class]) forIndexPath:indexPath];
        ;
        [cell setAppointUIWithModel:_arrDataStr[indexPath.row] appointType:[_arrData[indexPath.row] integerValue] orderType:_appointType];
        return cell;
    }else{
        MEOrderDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEOrderDetailContentCell class]) forIndexPath:indexPath];
//        id model = _arrChild[indexPath.row];
        [cell setAppointUIWithChildModel:_detaliModel];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section?kMEMyOrderDetailCellHeight:kMEOrderDetailContentCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?kMEMyOrderDetailCellHeight:0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMEMyOrderDetailCellHeight)];
    UILabel *lblTitle = [[UILabel alloc]init];
    [sectionView addSubview:lblTitle];
    lblTitle.text = @"预约信息";
    lblTitle.font = [UIFont systemFontOfSize:16];
    lblTitle.textColor = kMEHexColor(@"333333");
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(15);
        make.right.equalTo(sectionView.mas_right).offset(15);
        make.top.equalTo(sectionView);
        make.bottom.equalTo(sectionView);
    }];
    return sectionView;
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEMyOrderDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEMyOrderDetailCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEOrderDetailContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEOrderDetailContentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (MEOrderDetailView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MEOrderDetailView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kMEOrderDetailViewHeight);
        [_headerView setAppointUIWithModel:_detaliModel orderType:_appointType];
    }
    return _headerView;
}


@end
