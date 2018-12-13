//
//  MEBDataDealModel.h
//  ME时代
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEBaseModel.h"

@interface  MEBDataDealmemberModel: MEBaseModel

@property (nonatomic, strong) NSString * man;
@property (nonatomic, strong) NSString * privary;
@property (nonatomic, strong) NSString * today_new_member;
@property (nonatomic, strong) NSString * total;
@property (nonatomic, strong) NSString * women;

@end

@interface MEBDataDealgoodsModel : MEBaseModel
@property (nonatomic, strong) NSString * man_sales;
@property (nonatomic, strong) NSString * privary_sales;
@property (nonatomic, strong) NSString * total_sales;
@property (nonatomic, strong) NSString * women_sales;
@end

@interface  MEBDataDealbrokerageModel: MEBaseModel
@property (nonatomic, strong) NSString * can_use_brokerage;
@property (nonatomic, strong) NSString * settle_accounts_ok;
@property (nonatomic, strong) NSString * settle_accounts_no;
@property (nonatomic, strong) NSString * today_brokerage;
@end

@interface MEBDataDealorderModel : MEBaseModel
@property (nonatomic, strong) NSString * total_order_count;
@property (nonatomic, strong) NSString * today_order_count;
@end

@interface MEBDataDealModel : MEBaseModel

@property (nonatomic, strong) MEBDataDealbrokerageModel * brokerage;
@property (nonatomic, strong) MEBDataDealgoodsModel * goods;
@property (nonatomic, strong) MEBDataDealmemberModel * member;
@property (nonatomic, strong) MEBDataDealorderModel * order;

@end
