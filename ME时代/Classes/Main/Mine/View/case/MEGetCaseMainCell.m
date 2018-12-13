//
//  MEGetCaseMainCell.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGetCaseMainCell.h"
#import "MEGetCaseMainModel.h"

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

- (void)setUIWithModel:(MEGetCaseMainModel *)model{
    _lblOrderNo.text = [NSString stringWithFormat:@"提现单号:%@",kMeUnNilStr(model.order_sn)];
    _lblName.text = [NSString stringWithFormat:@"真实姓名:%@",kMeUnNilStr(model.true_name)];
    _lblBankNo.text = [NSString stringWithFormat:@"银行卡号:%@",kMeUnNilStr(model.account)];
    _lblMoney.text = [NSString stringWithFormat:@"提现金额:%@",kMeUnNilStr(model.all_money)];
    _lnlFee.text = [NSString stringWithFormat:@"手续费:%@",kMeUnNilStr(model.service_money)];
    _lblTime.text = [NSString stringWithFormat:@"申请时间:%@",kMeUnNilStr(model.created_at)];
}


@end
