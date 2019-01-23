//
//  MEBynamicCommentCell.m
//  ME时代
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBynamicCommentCell.h"

#define kMEBynamicCommentCellMagin (10+36+10+10+10+10)

@interface MEBynamicCommentCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;

@end

@implementation MEBynamicCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    NSString *str = kMeUnNilStr(@"hank:更好的骨灰级的感觉啊个电话就啊三个打火机噶伤筋动骨回家啊说过的话就撒过的话就撒过后觉得贵卅很简单噶伤感的");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kMEBynamicCommentCellMagin lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
    _lblTitle.text = nil;
    _lblTitle.attributedText = [str attributeWithRangeOfString:@"hank:" color:kME466889];
}

+ (CGFloat)getCellHeightWithhModel:(id)model{
    CGFloat height = 8;
    NSString *str = kMeUnNilStr(@"hank:更好的骨灰级的感觉啊个电话就啊三个打火机噶伤筋动骨回家啊说过的话就撒过的话就撒过后觉得贵卅很简单噶伤感的");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kMEBynamicCommentCellMagin lineH:0 maxLine:0];
    height+=titleHeight>17?titleHeight:17;
    return height;
}



@end
