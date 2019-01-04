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
@property (weak, nonatomic) IBOutlet UIImageView *imgJuan;
@property (weak, nonatomic) IBOutlet UILabel *lblMaterSale;

@end

@implementation MECoupleMailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblJuan.adjustsFontSizeToFitWidth = YES;
    _consImgHeight.constant = kMECoupleMailCellWdith;
    // Initialization code
}

- (void)setUIWithModel:(MECoupleModel *)model{
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(model.pict_url)] placeholderImage:kImgPlaceholder];
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblSale.text = [NSString stringWithFormat:@"已售%@",kMeUnNilStr(model.couponSale)];
    //原价
    _lblOrigalPrice.text =[NSString stringWithFormat:@"原价¥%@",@(kMeUnNilStr(model.zk_final_price).floatValue)];
    //卷后价
    _lblJuanPrice.text =[NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.truePrice).floatValue)];
    //卷价格


    if(kMeUnNilStr(model.coupon_info).length){
        _imgJuan.hidden = NO;
        _lblJuan.hidden = NO;
        _lblTitle.numberOfLines = 1;
        _lblJuan.text =[NSString stringWithFormat:@"%@元卷",kMeUnNilStr(model.couponPrice)];
        _lblOrigalPrice.hidden = NO;
        _lblSale.hidden = NO;
        _lblMaterSale.hidden = YES;
    }else{
        _lblTitle.numberOfLines = 2;
        _imgJuan.hidden = YES;
        _lblJuan.hidden = YES;
        _lblJuan.text = @"";
        _lblOrigalPrice.hidden = YES;
        _lblSale.hidden = YES;
        _lblMaterSale.hidden = NO;
        _lblMaterSale.text = [NSString stringWithFormat:@"已售%@",kMeUnNilStr(model.couponSale)];
    }
}

@end
