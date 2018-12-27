//
//  MECouponOrderHeaderView.m
//  ME时代
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import "MECouponOrderHeaderView.h"

@interface MECouponOrderHeaderView(){
    kMeBasicBlock _block;
}
//可提现
@property (weak, nonatomic) IBOutlet UILabel *lblCanUserCommsion;
//s已结算
@property (weak, nonatomic) IBOutlet UILabel *lblUsedCommsion;
//未结算
@property (weak, nonatomic) IBOutlet UILabel *lblNotUseCommsion;


@end

@implementation MECouponOrderHeaderView

- (void)setUIWithModel:(id)model block:(kMeBasicBlock)block{
    _lblCanUserCommsion.text = kMeUnNilStr(@"");
    _lblUsedCommsion.text = kMeUnNilStr(@"");
    _lblNotUseCommsion.text = kMeUnNilStr(@"");
    _block = block;
}

- (IBAction)touchAction:(UIButton *)sender {
    kMeCallBlock(_block);
}

@end
