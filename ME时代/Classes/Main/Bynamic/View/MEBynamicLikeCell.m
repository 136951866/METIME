//
//  MEBynamicLikeCell.m
//  ME时代
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBynamicLikeCell.h"

#define kMEBynamicLikeCelllMagin (10+36+10+10+10+10+10+14)

@interface MEBynamicLikeCell (){
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;

@end


@implementation MEBynamicLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    NSString *str = kMeUnNilStr(@"hank,时代大厦,时代,时代的,说三道四,的撒的撒");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kMEBynamicLikeCelllMagin lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
    _lblTitle.text = nil;
    _lblTitle.attributedText = [str attributeWithRangeOfString:@"hank:" color:kME466889];
}

+ (CGFloat)getCellHeightWithhModel:(id)model{
    CGFloat height = 8;
    NSString *str = kMeUnNilStr(@"hank,时代大厦,时代,时代的,说三道四,的撒的撒");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kMEBynamicLikeCelllMagin lineH:0 maxLine:0];
    height+=titleHeight>17?titleHeight:17;
    return height;
}



@end
