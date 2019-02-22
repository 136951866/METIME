//
//  METhridHomeNavView.h
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MEStoreModel;
const static CGFloat kImgStoreMargin = 7;
const static CGFloat kImgStore = 44;
#define kMEThridHomeNavViewHeight (((IS_iPhoneX==YES||IS_IPHONE_Xr==YES||IS_IPHONE_Xs==YES||IS_IPHONE_Xs_Max==YES) ? 76 : 65)+kImgStore+kImgStoreMargin)

@interface METhridHomeNavView : UIView

- (void)setStroeBackAlpha:(CGFloat)alpha;
- (void)setBackAlpha:(CGFloat)alpha;
- (void)setRead:(BOOL)read;
- (void)setStoreInfoWithModel:(MEStoreModel *)model;

@end

NS_ASSUME_NONNULL_END
