//
//  MEOrderDetailModel.h
//  ME时代
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEBaseModel.h"
#import "MELogistModel.h"

@interface MEOrderDetailExpressModel : MEBaseModel

@property (nonatomic, strong) NSString * express_company;
@property (nonatomic, strong) NSString * express_num;

@end

@interface MEOrderDetailAddressModel : MEBaseModel

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * detail;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * order_sn;
@property (nonatomic, strong) NSString * updated_at;
@property (nonatomic, strong) NSString * mobile;

@property (nonatomic, assign) NSInteger address_id;
@property (nonatomic, strong) NSString *area_id;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString *province_id;
@property (nonatomic, assign) NSInteger uid;

@end

@interface MEOrderDetailModel : MEBaseModel

@property (nonatomic, strong) NSString * all_freight;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger is_apprise;
@property (nonatomic, assign) NSInteger is_del;
@property (nonatomic, strong) NSString * order_amount;
@property (nonatomic, strong) NSString * order_discountAmount;
@property (nonatomic, assign) NSInteger order_discountNum;
@property (nonatomic, strong) NSString * order_sn;
@property (nonatomic, strong) NSString * order_status;
@property (nonatomic, assign) NSInteger order_type;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString * updated_at;
@property (nonatomic, strong) NSString * order_status_name;
@property (nonatomic, strong) NSArray * children;
@property (nonatomic, strong) MEOrderDetailAddressModel * address;
@property (nonatomic, strong) MEOrderDetailExpressModel * express;
@property (nonatomic, strong) MELogistModel *logistics;

@end
