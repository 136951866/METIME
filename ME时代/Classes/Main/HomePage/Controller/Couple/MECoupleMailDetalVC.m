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
#import "MECoupleModel.h"
#import "MECoupleMailDetalImageCell.h"

#define MECoupleMailDetalVCbottomViewHeight 50

@interface MECoupleMailDetalVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *_detailId;
    MECoupleModel *_detailModel;
    NSString *_Tpwd;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic,strong) MECoupleMailHeaderVIew *headerView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *btnShare;
@property (nonatomic,strong) UIButton *btnBuy;
@end

@implementation MECoupleMailDetalVC

- (instancetype)initWithModel:(MECoupleModel *)model{
    if(self = [super init]){
        _detailModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
//    kMeWEAKSELF
//    [MEPublicNetWorkTool postCoupleDetailWithProductrId:_detailId successBlock:^(ZLRequestResponse *responseObject) {
//        kMeSTRONGSELF
//        if([responseObject.data isKindOfClass:[NSDictionary class]]){
//            strongSelf->_detailModel = [MECoupleDetailModle mj_objectWithKeyValues:responseObject.data[@"tbk_item_info_get_response"][@"results"][@"n_tbk_item"]];
            [self.view addSubview:self.tableView];
            [self.view addSubview:self.bottomView];
            self.tableView.tableHeaderView = self.headerView;
            [self.headerView setUIWithModel:_detailModel];
            [self.tableView reloadData];
//        }else{
//             [strongSelf.navigationController popViewControllerAnimated:YES];
//        }
//    } failure:^(id object) {
//        kMeSTRONGSELF
//        [strongSelf.navigationController popViewControllerAnimated:YES];
//    }];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailModel.small_images.string.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MECoupleMailDetalImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MECoupleMailDetalImageCell class]) forIndexPath:indexPath];
    kSDLoadImg(cell.imageView, kMeUnNilStr(_detailModel.small_images.string[indexPath.row]));
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *viewGary = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    viewGary.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-160)/2, 22.5, 160, 1)];
    viewLine.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 0, 80, 44)];
    lbl.text = @"宝贝详情";
    lbl.font = kMeFont(12);
    lbl.textColor = [UIColor colorWithHexString:@"333333"];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewLine];
    [view addSubview:lbl];
    [view addSubview:viewGary];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (void)buyAction:(UIButton *)btn{
    if(kMeUnNilStr(_Tpwd).length){
        [self openTb];
    }else{
        kMeWEAKSELF
        [MEPublicNetWorkTool postTaobaokeGetTpwdWithTitle:kMeUnNilStr(_detailModel.title) url:kMeUnNilStr(_detailModel.coupon_click_url) logo:kMeUnNilStr(_detailModel.pict_url) successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_Tpwd = kMeUnNilStr(responseObject.data[@"tbk_tpwd_create_response"][@"data"][@"model"]);
            [strongSelf openTb];
        } failure:^(id object) {
            
        }];
    }
}

- (void)shareAction:(UIButton *)btn{
    
}

- (void)openTb{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = kMeUnNilStr(_Tpwd);
    NSURL *url = [NSURL URLWithString:@"taobao://"];
    // 判断当前系统是否有安装淘宝客户端
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        // 如果已经安装淘宝客户端，就使用客户端打开链接
        [[UIApplication sharedApplication] openURL:url];
    } else {
        NSURL *url = [NSURL URLWithString:kMeUnNilStr(_detailModel.coupon_click_url)];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-MECoupleMailDetalVCbottomViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECoupleMailDetalImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MECoupleMailDetalImageCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = SCREEN_WIDTH;
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
            [strongSelf buyAction:nil];
//            ZLWebViewVC *vc = [[ZLWebViewVC alloc]init];
//            [vc loadURL:[NSURL URLWithString:kMeUnNilStr(strongSelf->_detailModel.Quan_link)]];
//            vc.title = @"优惠卷";
//            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}

- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-MECoupleMailDetalVCbottomViewHeight, SCREEN_WIDTH, MECoupleMailDetalVCbottomViewHeight)];
        [_bottomView addSubview:self.btnShare];
        [_bottomView addSubview:self.btnBuy];
    }
    return _bottomView;
}

- (UIButton *)btnBuy{
    if(!_btnBuy){
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBuy.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, MECoupleMailDetalVCbottomViewHeight);
        [_btnBuy addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnBuy.backgroundColor =[UIColor colorWithHexString:@"F70054"];
        [_btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnBuy setTitle:@"立即购买" forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = kMeFont(15);
    }
    return _btnBuy;
}

- (UIButton *)btnShare{
    if(!_btnShare){
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnShare.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, MECoupleMailDetalVCbottomViewHeight);
        [_btnShare addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnShare.backgroundColor = [UIColor colorWithHexString:@"FC8F0C"];
        [_btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnShare setTitle:@"马上分享" forState:UIControlStateNormal];
        _btnShare.titleLabel.font = kMeFont(15);
    }
    return _btnShare;
}

@end
