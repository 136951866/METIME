//
//  MEBrandAiCell.m
//  ME时代
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandAiCell.h"

@interface MEBrandAiCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSortNum;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAINum;
@property (weak, nonatomic) IBOutlet UIImageView *imgSort;


@end

@implementation MEBrandAiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblSortNum.adjustsFontSizeToFitWidth  = YES;
    _lblAINum.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(id)model sortNum:(NSInteger)sortNum{
    _lblSortNum.text = @(sortNum+1).description;
    kSDLoadImg(_imgPic, @"");
    _lblName.text = kMeUnNilStr(@"ME时代");
    _lblAINum.text = kMeUnNilStr(@"111");
    switch (sortNum) {
        case 0:
        {
            _imgSort.hidden = NO;
            _imgSort.image = [UIImage imageNamed:@"icon_brandAi_one"];
        }
            break;
        case 1:
        {
            _imgSort.hidden = NO;
            _imgSort.image = [UIImage imageNamed:@"icon_brandAi_two"];
        }
            break;
        case 2:
        {
            _imgSort.hidden = NO;
            _imgSort.image = [UIImage imageNamed:@"icon_brandAi_three"];
        }
            break;
        default:{
            _imgSort.hidden = YES;
        }
            break;
    }
}


@end
