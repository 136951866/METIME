//
//  MEOrderDetailView.m
//  ME时代
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEOrderDetailView.h"
#import "MEOrderDetailModel.h"
#import "MELogisticsVC.h"
#import "MEMyOrderDetailVC.h"
#import "MEAppointDetailModel.h"

@interface MEOrderDetailView(){
    NSArray *_arrType;
    NSArray *_arrAppointType;
    MEOrderDetailModel *_modle;
}
@property (weak, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIView *viewForLogist;
@property (weak, nonatomic) IBOutlet UILabel *lblLogist;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatTime;



@end

@implementation MEOrderDetailView

- (void)awakeFromNib{
    [super awakeFromNib];
   _arrType = MEOrderStyleTitle;
    _arrAppointType = MEAppointmenyStyleTitle;
    _lblName.adjustsFontSizeToFitWidth = YES;
    _viewForLogist.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logistAction:)];
    [_viewForLogist addGestureRecognizer:ges];
}

- (void)logistAction:(UITapGestureRecognizer *)ges{
    MEMyOrderDetailVC *orderVC = (MEMyOrderDetailVC *)[MECommonTool getVCWithClassWtihClassName:[MEMyOrderDetailVC class] targetResponderView:self];
    if(orderVC){
        MELogisticsVC *logistVC = [[MELogisticsVC alloc]initWithmodel:_modle];
        [orderVC.navigationController pushViewController:logistVC animated:YES];
    }
}

- (void)setUIWithModel:(MEOrderDetailModel *)model orderType:(MEOrderStyle)type{
    _modle = model;
    if(type == MEAllNeedReceivedOrder || type == MEAllFinishOrder){
        _viewForLogist.hidden = NO;
        _viewForLogist.userInteractionEnabled = YES;
        MELogistModel *lmodel = model.logistics;
        if(kMeUnArr(lmodel.data).count>0){
            MELogistDataModel *ldModel = [lmodel.data firstObject];
            _lblLogist.text = kMeUnNilStr(ldModel.context);
        }else{
            _lblLogist.text = @"暂无快递信息";
        }
    }else{
        _viewForLogist.hidden = YES;
        _viewForLogist.userInteractionEnabled = NO;
    }
//    _lblOrderStatus.text = [NSString stringWithFormat:@"订单%@",_arrType[type]];
    _lblOrderStatus.text = [NSString stringWithFormat:@"订单%@",kMeUnNilStr(model.order_status_name)];

    _lblOrderNum.text = [NSString stringWithFormat:@"订单编号:%@",kMeUnNilStr(model.order_sn)];
    _lblName.text = kMeUnNilStr(model.address.name);
    _lblPhone.text = kMeUnNilStr(model.address.mobile);
    _lblCreatTime.text = [NSString stringWithFormat:@"创建时间:%@",kMeUnNilStr(model.created_at)];;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.address.province_id),kMeUnNilStr(model.address.city_id),kMeUnNilStr(model.address.area_id),kMeUnNilStr(model.address.detail)];
    _lblAddress.text  = address;
}

- (void)setAppointUIWithModel:(MEAppointDetailModel *)model orderType:(MEAppointmenyStyle)type{
    _viewForLogist.hidden = YES;
    _viewForLogist.userInteractionEnabled = NO;
    _lblOrderStatus.text = [NSString stringWithFormat:@"订单%@",_arrAppointType[type]];
    
//    _lblOrderNum.text = kMeUnNilStr(model.reserve_sn);
    _lblOrderNum.text = [NSString stringWithFormat:@"订单编号:%@",kMeUnNilStr(model.reserve_sn)];
    _lblCreatTime.text = [NSString stringWithFormat:@"创建时间:%@",kMeUnNilStr(model.created_at)];;
    _lblName.text = kMeUnNilStr(model.true_name);
    _lblPhone.text = kMeUnNilStr(model.cellphone);
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.province),kMeUnNilStr(model.city),kMeUnNilStr(model.district),kMeUnNilStr(model.address)];
    _lblAddress.text  = address;
}

+ (CGFloat)getViewHeightWithType:(MEOrderStyle)type{
    if(type == MEAllNeedReceivedOrder || type == MEAllFinishOrder){
        return kMEOrderDetailViewHeight + kMEOrderDetailViewLogistHeight;
    }else{
        return kMEOrderDetailViewHeight;
    }
}

@end
