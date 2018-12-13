//
//  MEBDataDealModel.h
//  ME时代
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEBaseModel.h"

@interface  MEBDataDealmemberModel: MEBaseModel

@property (nonatomic, assign) NSInteger man;
@property (nonatomic, assign) NSInteger privary;
@property (nonatomic, assign) NSInteger today_new_member;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger women;

@end

@interface MEBDataDealgoodsModel : MEBaseModel
@property (nonatomic, assign) NSInteger man_sales;
@property (nonatomic, assign) NSInteger privary_sales;
@property (nonatomic, strong) NSString * total_sales;
@property (nonatomic, assign) NSInteger women_sales;
@end

@interface  MEBDataDealbrokerageModel: MEBaseModel

@end

@interface MEBDataDealorderModel : MEBaseModel

@end

@interface MEBDataDealModel : MEBaseModel

@property (nonatomic, strong) MEBDataDealbrokerageModel * brokerage;
@property (nonatomic, strong) MEBDataDealgoodsModel * goods;
@property (nonatomic, strong) MEBDataDealmemberModel * member;
@property (nonatomic, strong) MEBDataDealorderModel * order;

@end
