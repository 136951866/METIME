//
//  MEGoodDetailModel.m
//  ME时代
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGoodDetailModel.h"


@implementation MEGoodDetailSpecModel

MEModelObjectClassInArrayWithDic(@{@"spec_value" : [MEGoodSpecModel class]})

@end


@implementation MEGoodDetailModel

MEModelObjectClassInArrayWithDic(@{@"spec" : [MEGoodDetailSpecModel class]})

- (NSMutableArray *)arrSelect{
    if(!_arrSelect){
        _arrSelect = [NSMutableArray array];
    }
    return _arrSelect;
}

- (NSString *)rudeTip{
    return @"等哈记得回家撒谎的";
}

- (NSString *)notice{
    return @"等哈记得回家撒谎的";
}

- (NSString *)tip{
    return @"等哈记得回记得记得记得记得记得记得记得记得记得记得记得记得记得记得记得记得记得记得记得记得家撒谎的";
}

@end


