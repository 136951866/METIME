//
//  MEAddGoodDetailModel.m
//  ME时代
//
//  Created by hank on 2019/3/29.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEAddGoodDetailModel.h"


@implementation MEAddGoodDetailGroupModel : MEBaseModel

@end

@implementation MEAddGoodDetailSpecIdsValueModel : MEBaseModel
MEModelIdToIdField
@end

@implementation MEAddGoodDetailSpecIdsModel : MEBaseModel
MEModelObjectClassInArrayWithDic(@{@"spec_ids_value":[MEAddGoodDetailSpecIdsValueModel class]})

@end

@implementation MEAddGoodDetailSpecNameModel : MEBaseModel

@end

@implementation MEAddGoodDetailModel
MEModelObjectClassInArrayWithDic((@{@"spec_ids" : [MEAddGoodDetailSpecIdsModel class],@"spec_name" : [MEAddGoodDetailSpecNameModel class]}))
@end
