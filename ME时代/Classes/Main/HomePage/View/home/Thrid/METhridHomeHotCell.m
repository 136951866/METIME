//
//  METhridHomeHotCell.m
//  ME时代
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeHotCell.h"

@interface METhridHomeHotCell (){
    kMeBasicBlock _payBlock;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgPalyGood;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;


@end

@implementation METhridHomeHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(id)model payBlock:(kMeBasicBlock)payBlock{
    _payBlock = payBlock;
    kSDLoadImg(_imgGood, kMeUnNilStr(@""));
    kSDLoadImg(_imgPalyGood, kMeUnNilStr(@""));
}

- (IBAction)playAction:(UIButton *)sender {
    kMeCallBlock(_payBlock);
}

@end
