//
//  MEClerksSortCell.m
//  ME时代
//
//  Created by hank on 2019/1/6.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEClerksSortCell.h"

@interface MEClerksSortCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@property (weak, nonatomic) IBOutlet UILabel *lblZfNNum;
@property (weak, nonatomic) IBOutlet UILabel *lblReadNum;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;

@end

@implementation MEClerksSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblTitle.text = kMeUnNilStr(@"");
    _lblTel.text = [NSString stringWithFormat:@"手机号:%@",kMeUnNilStr(@"")];
    _lblZfNNum.text = kMeUnNilStr(@"0");
    _lblReadNum.text = kMeUnNilStr(@"0");
    _lblMoney.text = kMeUnNilStr(@"0");
}

@end
