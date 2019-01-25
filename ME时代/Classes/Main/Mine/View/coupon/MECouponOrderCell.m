//
//  MECouponOrderCell.m
//  ME时代
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import "MECouponOrderCell.h"
#import "MECouponMoneyModel.h"

@interface MECouponOrderCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblCommission;

@end

@implementation MECouponOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(MECouponMoneyModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.goods_thumbnail_url));
    _lblTitle.text = kMeUnNilStr(model.goods_name);
    _lblTime.text = [NSString stringWithFormat:@"下单时间:%@",kMeUnNilStr(model.created_at)];
    
    _lblPrice.text =  [NSString stringWithFormat:@"消费金额¥%@",[MECommonTool changeformatterWithFen:@(model.order_amount)]];
    _lblCommission.text = [NSString stringWithFormat:@"佣金估计¥%@",[MECommonTool changeformatterWithFen:@(model.promotion_amount)]];
}

@end
