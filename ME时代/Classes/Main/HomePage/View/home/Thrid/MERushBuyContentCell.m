//
//  MERushBuyContentCell.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MERushBuyContentCell.h"

@interface MERushBuyContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consRateWdith;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblUnderLinePrice;


@end

@implementation MERushBuyContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblTitle.text = kMeUnNilStr(@"test");
    _lblSubTitle.text = kMeUnNilStr(@"test");
    CGFloat rate = 0.355;
    NSInteger rateNum = 100*rate;
    _lblRate.text = [NSString stringWithFormat:@"%ld%%",(long)rateNum];
    _consRateWdith.constant = rateNum;
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(@"10000")];
    NSString *commStr = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(@"100").floatValue)];
    [_lblUnderLinePrice setLineStrWithStr:commStr];
    
}

@end
