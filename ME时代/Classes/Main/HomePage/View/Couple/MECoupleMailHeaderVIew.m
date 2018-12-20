//
//  MECoupleMailHeaderVIew.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MECoupleMailHeaderVIew.h"
#import "MECoupleDetailModle.h"

@interface MECoupleMailHeaderVIew (){
    MECoupleDetailModle *_model;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgHeight;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblOralPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuanedPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuan;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSubViewW;


@end

@implementation MECoupleMailHeaderVIew

- (void)awakeFromNib{
    [super awakeFromNib];
    _consImgHeight.constant = SCREEN_WIDTH;
    _consSubViewW.constant = 100 * kMeFrameScaleX();
    
}

- (void)setUIWithModel:(MECoupleDetailModle *)model{
    _model = model;
    kSDLoadImg(_imgPic, kMeUnNilStr(model.Pic));
    _lblTitle.text = kMeUnNilStr(model.Title);
    _lblOralPrice.text =[NSString stringWithFormat:@"原价¥%@",@(kMeUnNilStr(model.Org_Price).floatValue)];
    _lblJuanedPrice.text =[NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.Price).floatValue)];
    _lblJuan.text =[NSString stringWithFormat:@"%@元卷",kMeUnNilStr(model.Quan_price)];
    _lblTime.text =[NSString stringWithFormat:@"有效时间%@",kMeUnNilStr(model.Quan_time)];
}

- (IBAction)coupleAction:(UIButton *)sender {
    kMeCallBlock(_getCoupleBlock);
}




@end
