//
//  MEGetCaseContentCell.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGetCaseContentCell.h"

@interface MEGetCaseContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblSku;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblDataDealMoney;

@end

@implementation MEGetCaseContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(id)model{
    _lblDataDealMoney.hidden = YES;
    kSDLoadImg(_imgHeader, @"");
    _lblTitle.text = kMeUnNilStr(@"");
    _lblSku.text = kMeUnNilStr(@"");
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(@"")];
    _lblMoney.text =  [NSString stringWithFormat:@"获得的佣金:%@",kMeUnNilStr(@"")];
}

- (void)setUIDataDealWIthModel:(id)model{
    _lblPrice.hidden = YES;
    _lblMoney.hidden = YES;
    kSDLoadImg(_imgHeader, @"");
    _lblTitle.text = kMeUnNilStr(@"");
    _lblSku.text = kMeUnNilStr(@"");
    _lblDataDealMoney.text =  [NSString stringWithFormat:@"获得的佣金:%@",kMeUnNilStr(@"")];
}

@end
