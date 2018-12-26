//
//  MECoupleMailHeaderVIew.h
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MECoupleModel;
#define MECoupleMailHeaderVIewHeight (SCREEN_WIDTH + 205)

@interface MECoupleMailHeaderVIew : UIView

- (void)setUIWithModel:(MECoupleModel *)model;
@property (nonatomic ,copy)kMeBasicBlock getCoupleBlock;

@end
