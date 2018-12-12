//
//  MEGetCaseMainCell.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGetCaseMainCell.h"

@interface MEGetCaseMainCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblBankNo;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lnlFee;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;


@end

@implementation MEGetCaseMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUIWithModel:(id)model{
    _lblOrderNo.text = [NSString stringWithFormat:@"提现单号:%@",kMeUnNilStr(@"")];
    _lblName.text = [NSString stringWithFormat:@"真实姓名:%@",kMeUnNilStr(@"")];
    _lblBankNo.text = [NSString stringWithFormat:@"银行卡号:%@",kMeUnNilStr(@"")];
    _lblMoney.text = [NSString stringWithFormat:@"提现金额:%@",kMeUnNilStr(@"")];
    _lnlFee.text = [NSString stringWithFormat:@"手续费:%@",kMeUnNilStr(@"")];
    _lblTime.text = [NSString stringWithFormat:@"申请时间:%@",kMeUnNilStr(@"")];
}


@end
