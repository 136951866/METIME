//
//  MECoupleModel.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MECoupleModel.h"

@implementation MECoupleSmallImageModel

@end

@implementation MECoupleModel


- (NSString *)couponPrice{
    if(!_couponPrice){
        if(!self.coupon_info){
            return @"";
        }
        NSRange startRange = [self.coupon_info rangeOfString:@"减"];
        NSRange endRange = NSMakeRange(self.coupon_info.length-1, 1);
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        _couponPrice = [self.coupon_info substringWithRange:range];
    }
    return _couponPrice;
}

- (NSString *)truePrice{
    if(!_truePrice){
        if(!self.couponPrice){
            return @"";
        }
        CGFloat price = [self.zk_final_price floatValue] - [self.couponPrice floatValue];
        return @(price).description;
    }
    return _truePrice;
}

- (NSString *)couponSale{
    if(!_couponSale){
        _couponSale = @((self.coupon_total_count - self.coupon_remain_count)).description;
    }
    return _couponSale;
}

@end
