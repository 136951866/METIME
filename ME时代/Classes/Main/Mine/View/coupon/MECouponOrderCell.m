//
//  MECouponOrderCell.m
//  ME时代
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import "MECouponOrderCell.h"

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

- (void)setUIWithModel:(id)model{
    kSDLoadImg(_imgPic, @"");
    _lblTitle.text = kMeUnNilStr(@"");
    _lblTime.text = [NSString stringWithFormat:@"下单时间:%@",kMeUnNilStr(@"")];
    _lblPrice.text =  [NSString stringWithFormat:@"消费金额¥%@",@(kMeUnNilStr(@"11.00").floatValue)];
    _lblCommission.text = [NSString stringWithFormat:@"佣金估计¥%@",@(kMeUnNilStr(@"11.00").floatValue)];
}

@end
