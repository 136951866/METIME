//
//  METhridHomeGoodGoodMainCell.m
//  ME时代
//
//  Created by hank on 2019/4/29.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeGoodGoodMainCell.h"
#import "METhridHomeHotGoodModel.h"

@interface METhridHomeGoodGoodMainCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@end

@implementation METhridHomeGoodGoodMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblTitle.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16];
    _lblPrice.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(METhridHomeHotGoodModel *)model{
    kSDLoadImg(_imgPic,kMeUnNilStr(model.product.images));
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblSubTitle.text = kMeUnNilStr(model.product.desc);
//    _lblPrice.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.product.money).floatValue)];
    
//    NSString *commStr = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.product.market_price).floatValue)];
    
    NSString *str = [NSString stringWithFormat:@"¥%@ ¥%@",@(kMeUnNilStr(model.product.money).floatValue),@(kMeUnNilStr(model.product.market_price).floatValue)];
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSUInteger firstLoc = [[aString string] rangeOfString:@" "].location+1;
    NSUInteger secondLoc = str.length;
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    [aString addAttribute:NSForegroundColorAttributeName value:kME999999 range:range];
    [aString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    [aString addAttribute:NSFontAttributeName value:kMeFont(12) range:range];
    
    _lblPrice.attributedText = aString;
    
//    [_lblUnderLinePrice setLineStrWithStr:commStr];
}


@end
