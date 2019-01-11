//
//  MENewMineHomeContentCell.m
//  ME时代
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MENewMineHomeContentCell.h"

@interface MENewMineHomeContentCell (){
    NSArray *_arrTitle;
    NSArray *_arrImage;
    MEMineHomeCellStyle _type;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@end

@implementation MENewMineHomeContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _arrTitle = MEMineHomeCellStyleTitle;
    _arrImage = MEMineHomeCellStyleImage;
    // Initialization code
}

- (void)setUIWithType:(MEMineHomeCellStyle )type{
    _type = type;
    _imgPic.image =  kMeGetAssetImage(_arrImage[type]);
    _lblTitle.text = _arrTitle[type];
}

@end
