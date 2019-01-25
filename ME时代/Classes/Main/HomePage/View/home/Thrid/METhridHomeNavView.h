//
//  METhridHomeNavView.h
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kMEThridHomeNavViewHeight ((kMeStatusBarHeight)+45)

@interface METhridHomeNavView : UIView

- (void)setBackAlpha:(CGFloat)alpha;
- (void)setRead:(BOOL)read;

@end

NS_ASSUME_NONNULL_END
