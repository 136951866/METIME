//
//  METhridHomeModel.m
//  ME时代
//
//  Created by hank on 2019/1/24.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeModel.h"

@implementation METhridHomeBuyingGoodsModel


@end

@implementation METhridHomeAdModel


@end

@implementation METhridHomeserviceModel


@end

@implementation METhridHomeBackgroundModel

MEModelIdToIdField

@end

@implementation METhridHomeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{return @{@"member_exclusive" : @"new_member_exclusive"};}

MEModelObjectClassInArrayWithDic((@{@"service" : [METhridHomeserviceModel class],@"top_banner" : [METhridHomeAdModel class],@"scare_buying_goods" : [METhridHomeBuyingGoodsModel class]}))

@end
