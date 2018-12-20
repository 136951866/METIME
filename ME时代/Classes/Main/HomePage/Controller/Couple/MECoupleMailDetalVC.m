//
//  MECoupleMailDetalVC.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MECoupleMailDetalVC.h"
#import "MECoupleMailHeaderVIew.h"
#import "MECoupleDetailModle.h"
#import "ZLWebViewVC.h"

@interface MECoupleMailDetalVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *_detailId;
    MECoupleDetailModle *_detailModel;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic,strong) MECoupleMailHeaderVIew *headerView;

@end

@implementation MECoupleMailDetalVC

- (instancetype)initWithDetailId:(NSString *)detailId{
    if(self = [super init]){
        _detailId = detailId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    kMeWEAKSELF
    [MEPublicNetWorkTool postCoupleDetailWithProductrId:_detailId successBlock:^(NSDictionary *dic) {
        kMeSTRONGSELF
        if([dic isKindOfClass:[NSDictionary class]]){
            strongSelf->_detailModel = [MECoupleDetailModle mj_objectWithKeyValues:dic[@"result"]];
            [strongSelf.view addSubview:strongSelf.tableView];
            strongSelf.tableView.tableHeaderView = strongSelf.headerView;
            [strongSelf.headerView setUIWithModel:strongSelf->_detailModel];
            [strongSelf.tableView reloadData];
        }else{
             [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEHomeMiaoDongCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEHomeMiaoDongCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (MECoupleMailHeaderVIew *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MECoupleMailHeaderVIew" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MECoupleMailHeaderVIewHeight);
        kMeWEAKSELF
        _headerView.getCoupleBlock = ^{
            kMeSTRONGSELF
            ZLWebViewVC *vc = [[ZLWebViewVC alloc]init];
            [vc loadURL:[NSURL URLWithString:kMeUnNilStr(strongSelf->_detailModel.Quan_link)]];
            vc.title = @"优惠卷";
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}


@end
