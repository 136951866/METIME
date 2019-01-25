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

- (NSString*)rudeTip{
    if(self.restrict_num!=0){
        return [NSString stringWithFormat:@"限时秒杀(每人限购%ld件,超出的部分按原价购买)",self.restrict_num];
    }else{
        return @"";
    }
}

@end


