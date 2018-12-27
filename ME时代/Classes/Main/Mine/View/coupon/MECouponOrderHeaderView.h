//
//  MECouponOrderHeaderView.h
//  ME时代
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kMECouponOrderHeaderViewHeight = 160;

NS_ASSUME_NONNULL_BEGIN

@interface MECouponOrderHeaderView : UIView

- (void)setUIWithModel:(id)model block:(kMeBasicBlock)block;

@end

NS_ASSUME_NONNULL_END
