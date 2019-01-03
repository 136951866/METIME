//
//  MECoupleHomeMainContentCell.m
//  ME时代
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECoupleHomeMainContentCell.h"

@interface MECoupleHomeMainContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblLinePrice;

@end

@implementation MECoupleHomeMainContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    _lblLinePrice.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWIthModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(@"1"));
    _lblTitle.text = kMeUnNilStr(@"11");
    NSString *commStr = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(@"111").floatValue)];
    [_lblLinePrice setLineStrWithStr:commStr];
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(@"100").floatValue)];

    
}

@end
