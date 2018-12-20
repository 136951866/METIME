//
//  MECoupleMailCell.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MECoupleMailCell.h"
#import "MECoupleModel.h"

@interface MECoupleMailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblOrigalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSale;
@property (weak, nonatomic) IBOutlet UILabel *lblJuanPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuan;

@end

@implementation MECoupleMailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblJuan.adjustsFontSizeToFitWidth = YES;
    _consImgHeight.constant = kMECoupleMailCellWdith;
    // Initialization code
}

- (void)setUIWithModel:(MECoupleModel *)model{
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(model.Pic)] placeholderImage:kImgPlaceholder];
    _lblTitle.text = kMeUnNilStr(model.D_title);
    _lblSale.text = [NSString stringWithFormat:@"已售%@",kMeUnNilStr(model.Sales_num)];
    _lblOrigalPrice.text =[NSString stringWithFormat:@"原价¥%@",@(kMeUnNilStr(model.Org_Price).floatValue)];
    _lblJuanPrice.text =[NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.Price).floatValue)];
    _lblJuan.text =[NSString stringWithFormat:@"%@元卷",kMeUnNilStr(model.Quan_price)];
    
}

@end
