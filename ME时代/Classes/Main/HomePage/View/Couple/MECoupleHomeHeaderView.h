//
//  MECoupleHomeHeaderView.h
//  ME时代
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECoupleHomeHeaderView : UIView

- (void)setUiWithModel:(NSArray *)Model;
+ (CGFloat)getViewHeight;
@property (nonatomic, copy) kMeBOOLBlock isSelectTbkBlock;


@end

NS_ASSUME_NONNULL_END
