//
//  MeMyActityMineCell.m
//  ME时代
//
//  Created by hank on 2019/1/6.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MeMyActityMineCell.h"

@interface MeMyActityMineCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;


@end

@implementation MeMyActityMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    _lblTime.text = [NSString stringWithFormat:@"发起时间:%@",kMeUnNilStr(@"")];
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblTitle.text = kMeUnNilStr(@"");
    _lblStatus.text = kMeUnNilStr(@"");
    _lblMoney.text = [NSString stringWithFormat:@"金额:%@",kMeUnNilStr(@"")];
    _lblNum.text = [NSString stringWithFormat:@"达成条件:%@",kMeUnNilStr(@"")];
}

@end
