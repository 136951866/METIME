//
//  MEOrderModel.m
//  ME时代
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEOrderModel.h"

@implementation MEOrderGoodModel
MEModelIdToIdField
@end

@implementation MEOrderModel

MEModelObjectClassInArrayWithDic(@{@"children" : [MEOrderGoodModel class]})

@end
