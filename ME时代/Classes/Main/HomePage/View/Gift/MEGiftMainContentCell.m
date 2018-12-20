//
//  MEGiftMainContentCell.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGiftMainContentCell.h"

@interface MEGiftMainContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblSku;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//数量
@property (weak, nonatomic) IBOutlet UIButton *cutBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation MEGiftMainContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _priceLabel.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWIthModel:(id )model{
    
}

//减
- (IBAction)cut:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
    
//    kMeWEAKSELF
//    [MEPublicNetWorkTool posteditCartNumWithShopCartId:_goodsModel.product_cart_id num:count successBlock:^(ZLRequestResponse *responseObject) {
//        kMeSTRONGSELF
        NSString *countStr = [NSString stringWithFormat:@"%ld", count];
        self.countLabel.text = countStr;
        kMeCallBlock(self.CutBlock,self.countLabel);
//    } failure:^(id object) {
//
//    }];
}

//加
- (IBAction)add:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count++;
//    if(count>_goodsModel.stock){
//        [MEShowViewTool showMessage:@"库存不足" view:kMeCurrentWindow];
//        return;
//    }
//    kMeWEAKSELF
//    [MEPublicNetWorkTool posteditCartNumWithShopCartId:_goodsModel.product_cart_id num:count successBlock:^(ZLRequestResponse *responseObject) {
//        kMeSTRONGSELF
        NSString *countStr = [NSString stringWithFormat:@"%ld", count];
        self.countLabel.text = countStr;
        kMeCallBlock(self.AddBlock,self.countLabel);
//    } failure:^(id object) {
//
//    }];
}


@end
