//
//  MECouponOrderSectionView.m
//  ME时代
//
//  Created by hank on 2019/2/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECouponOrderSectionView.h"


@interface MECouponOrderSectionView ()

@property (weak, nonatomic) IBOutlet UIView *viewForLine;
@property (weak, nonatomic) IBOutlet UIButton *btnPinduoduo;
@property (weak, nonatomic) IBOutlet UIButton *btnJd;
@property (weak, nonatomic) IBOutlet UIView *viewForJdLine;


@end

@implementation MECouponOrderSectionView


- (IBAction)pinduoduoAction:(UIButton *)sender {
    if(sender.selected == YES){
        return;
    }
    [self reloadUIWIthType:MECouponOrderSectionViewPinduoduoType];
    kMeCallBlock(_selectBlock,MECouponOrderSectionViewPinduoduoType);
}

- (IBAction)jdAction:(UIButton *)sender {
    if(sender.selected == YES){
        return;
    }
    [self reloadUIWIthType:MECouponOrderSectionViewJDType];
    kMeCallBlock(_selectBlock,MECouponOrderSectionViewJDType);
}

- (void)setType:(MECouponOrderSectionViewType)type{
    _type = type;
    [self reloadUIWIthType:type];
}

- (void)reloadUIWIthType:(MECouponOrderSectionViewType)type{
    if(type==MECouponOrderSectionViewPinduoduoType){
        _viewForJdLine.hidden = YES;
        _viewForLine.hidden = NO;
        _btnPinduoduo.selected = YES;
        _btnJd.selected = NO;
    }else{
        _viewForJdLine.hidden = NO;
        _viewForLine.hidden = YES;
        _btnPinduoduo.selected = NO;
        _btnJd.selected = YES;
    }
}


@end
