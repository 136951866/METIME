//
//  MECoupleMailHeaderVIew.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MECoupleMailHeaderVIew.h"
#import "MECoupleModel.h"
#import "MEPinduoduoCoupleInfoModel.h"

@interface MECoupleMailHeaderVIew (){
    MECoupleModel *_model;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgHeight;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblOralPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuanedPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuan;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSubViewW;


@end

@implementation MECoupleMailHeaderVIew

- (void)awakeFromNib{
    [super awakeFromNib];
    _consImgHeight.constant = SCREEN_WIDTH;
    _consSubViewW.constant = 100 * kMeFrameScaleX();
    
}

- (void)setUIWithModel:(MECoupleModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.pict_url));
    _lblTitle.text = kMeUnNilStr(model.title);
    //原价
    _lblOralPrice.text =[NSString stringWithFormat:@"原价¥%@",@(kMeUnNilStr(model.zk_final_price).floatValue)];
    ////卷后价
    _lblJuanedPrice.text =[NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.truePrice).floatValue)];
    //卷价格
    _lblJuan.text =[NSString stringWithFormat:@"%@元券",kMeUnNilStr(model.couponPrice)];
    _lblTime.text =[NSString stringWithFormat:@"有效时间%@~%@",kMeUnNilStr(model.coupon_start_time),kMeUnNilStr(model.coupon_end_time)];
}

- (void)setPinduoduoUIWithModel:(MEPinduoduoCoupleInfoModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.goods_thumbnail_url));
    _lblTitle.text = kMeUnNilStr(model.goods_name);
    //原价
    _lblOralPrice.text =[NSString stringWithFormat:@"原价¥%@",[MECommonTool changeformatterWithFen:@(model.min_group_price)]];
    ////卷后价
    _lblJuanedPrice.text =[NSString stringWithFormat:@"¥%@",[MECommonTool changeformatterWithFen:@(model.min_group_price-model.coupon_discount)]];
    //卷价格
    _lblJuan.text =[NSString stringWithFormat:@"%@元券",[MECommonTool changeformatterWithFen:@(model.coupon_discount)]];

    _lblTime.text =[NSString stringWithFormat:@"有效时间%@~%@",[METimeTool timestampSwitchTime:model.coupon_start_time  andFormatter:@"yyyy-MM-dd"],[METimeTool timestampSwitchTime:model.coupon_end_time andFormatter:@"yyyy-MM-dd"]];
}

- (IBAction)coupleAction:(UIButton *)sender {
    kMeCallBlock(_getCoupleBlock);
}




@end
