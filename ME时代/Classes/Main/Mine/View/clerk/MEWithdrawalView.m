//
//  MEWithdrawalView.m
//  ME时代
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEWithdrawalView.h"
#import "MEWithdrawalTextField.h"
#import "MEWithdrawalParamModel.h"

@interface MEWithdrawalView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBtnTopMargin;
@property (nonatomic, strong) MEWithdrawalParamModel *parModel;

@property (weak, nonatomic) IBOutlet MEWithdrawalTextField *tfName;
@property (weak, nonatomic) IBOutlet MEWithdrawalTextField *tfBankName;
@property (weak, nonatomic) IBOutlet MEWithdrawalTextField *tfBnkNo;
@property (weak, nonatomic) IBOutlet MEWithdrawalTextField *tfBankBelong;

@end

@implementation MEWithdrawalView

- (void)awakeFromNib{
    [super awakeFromNib];
    _consBtnTopMargin.constant = 125 * kMeFrameScaleX();
    kMeWEAKSELF
    _tfName.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.name = str;
    };
    _tfBankName.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.bankName = str;
    };
    _tfBnkNo.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.bankNo = str;
    };
    _tfBankBelong.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.bankBelong = str;
    };
}


- (IBAction)applyAction:(UIButton *)sender {
    NSDictionary *dic = [self.parModel mj_keyValues];
    NSLog(@"----%@",dic);
    kMeCallBlock(_applyFinishBlock);
}


+ (CGFloat)getViewHeight{
    CGFloat height = 586 - 125;
    height +=(125 * kMeFrameScaleX());
    return height;
}

- (MEWithdrawalParamModel*)parModel{
    if(!_parModel){
        _parModel = [MEWithdrawalParamModel new];
    }
    return _parModel;
}

@end
