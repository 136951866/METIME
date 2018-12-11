//
//  MEGoodModel.h
//  ME时代
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEBaseModel.h"

@interface MEGoodModel : MEBaseModel

@property (nonatomic, strong) NSString * images;
@property (nonatomic, strong) NSString * market_price;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic, strong) NSString * title;

//推荐
@property (nonatomic, strong) NSString *image_rec;
//热门
@property (nonatomic, strong) NSString *images_hot;
//美豆相关
@property (nonatomic, strong) NSString * list_order;
@property (nonatomic, strong) NSString * integral_lines;

//预约
@property (nonatomic, strong) NSString * reserve_num;


@end
