//
//  MEJDCouponMoneyModel.h
//  ME时代
//
//  Created by hank on 2019/2/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface MEJDCouponMoneyModel : MEBaseModel

@property (nonatomic, strong) NSString * actualFee;
@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) NSString * orderTime;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * skuId;
@property (nonatomic, strong) NSString * skuName;
//0未结算佣金 1可提现佣金 2已结算佣金
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * statusStr;
@end

NS_ASSUME_NONNULL_END
