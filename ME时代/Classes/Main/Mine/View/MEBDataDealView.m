//
//  MEBDataDealView.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEBDataDealView.h"

@interface MEBDataDealView ()

@property (weak, nonatomic) IBOutlet UILabel *lblGengerRate;
@property (weak, nonatomic) IBOutlet UILabel *lblAllUserCount;
@property (weak, nonatomic) IBOutlet UILabel *lblTodayUserCount;
@property (weak, nonatomic) IBOutlet UILabel *lblAllCost;
@property (weak, nonatomic) IBOutlet UILabel *lblGenerCostRate;
@property (weak, nonatomic) IBOutlet UILabel *lblAllOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblTodayOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblCanUserMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblNotUseMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblUsedMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblTodayMoney;

@end

@implementation MEBDataDealView

- (void)setUIWithModel:(id)Model{
    _lblGengerRate.text = kMeUnNilStr(@"");
    _lblAllUserCount.text = kMeUnNilStr(@"");
    _lblTodayUserCount.text = kMeUnNilStr(@"");
    _lblAllCost.text = kMeUnNilStr(@"");
    _lblGenerCostRate.text = kMeUnNilStr(@"");
    _lblAllOrder.text = kMeUnNilStr(@"");
    _lblTodayOrder.text = kMeUnNilStr(@"");
    _lblCanUserMoney.text = kMeUnNilStr(@"");
    _lblNotUseMoney.text = kMeUnNilStr(@"");
    _lblUsedMoney.text = kMeUnNilStr(@"");
    _lblTodayMoney.text = kMeUnNilStr(@"");
}

@end
