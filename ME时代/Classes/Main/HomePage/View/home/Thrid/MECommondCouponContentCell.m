//
//  MECommondCouponContentCell.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECommondCouponContentCell.h"

@interface MECommondCouponContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuan;


@end

@implementation MECommondCouponContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    _lblJuan.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWithModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(@"111")];
    _lblJuan.text = [NSString stringWithFormat:@"%@元卷",kMeUnNilStr(@"111")];
//    [NSString stringWithFormat:@"原价¥%@", [MECommonTool changeformatterWithFen:@(model.min_group_price)]];
//         _lblJuan.text =[NSString stringWithFormat:@"%@元卷",[MECommonTool changeformatterWithFen:@(model.coupon_discount)]];
    
}

@end
