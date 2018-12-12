//
//  MEAddClerkCell.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEAddClerkCell.h"

@interface MEAddClerkCell (){
    id _model;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end

@implementation MEAddClerkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(id)model{
    _model = model;
    kSDLoadImg(_imgHeader, @"11");
    _lblName.text = kMeUnNilStr(@"1111");
    _lblTime.text = kMeUnNilStr(@"22222");
}

- (IBAction)updatClerkAction:(UIButton *)sender {
    kMeCallBlock(_updateBlock);
}

@end
