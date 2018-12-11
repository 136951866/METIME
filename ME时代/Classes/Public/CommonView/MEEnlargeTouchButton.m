//
//  MEEnlargeTouchButton.m
//  ME时代
//
//  Created by hank on 2018/10/22.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEEnlargeTouchButton.h"

@implementation MEEnlargeTouchButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = bounds.size.width;//MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = bounds.size.height;//MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
