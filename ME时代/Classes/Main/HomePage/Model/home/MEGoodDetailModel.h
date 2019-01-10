//
//  MEGoodDetailModel.h
//  ME时代
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEBaseModel.h"
#import "MEPriceAndStockModel.h"
#import "MEGoodSpecModel.h"

@interface MEGoodDetailSpecModel : MEBaseModel

@property (nonatomic, strong) NSString * spec_name;
@property (nonatomic, strong) NSArray * spec_value;


@end

@interface MEGoodDetailModel : MEBaseModel

@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic, strong) NSString * images;
@property (nonatomic, strong) NSString * title;
//市场价
@property (nonatomic, strong) NSString * market_price;
//原价
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSArray *spec;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * custom_uid;
//区间价 2.0.2
@property (nonatomic, strong) NSString * interval_price;
//美豆相关
@property (nonatomic, strong) NSString * integral_lines;//美豆数
@property (nonatomic, strong) NSString * postage;//邮费
//预约
@property (nonatomic, strong) NSString *reserve_num;
@property (nonatomic, assign) NSInteger is_first_buy;

//销量
@property (nonatomic, strong) NSString *sales;
//访问量
@property (nonatomic, strong) NSString *browse;
//购买数量
@property (nonatomic,assign) NSInteger buynum;
//选中的price和stock
@property (nonatomic, strong) MEPriceAndStockModel * psmodel;
//当前选中 【@（1），@（0）】
@property (nonatomic, strong) NSMutableArray *arrSelect;
//选中的sku 规格 dfdsfds+dfsdf
@property (nonatomic, strong) NSString * skus;
//属性id 1,2
@property (nonatomic, strong) NSString * spec_ids;

//0 不能分享 1 可以
@property (nonatomic, strong) NSString *is_clerk_share;
@end


