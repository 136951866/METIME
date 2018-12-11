//
//  MEMyPosterContentCell.h
//  ME时代
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEPosterChildrenModel;
const static CGFloat kMEMyPosterContentIMageHeight  = 152;
const static CGFloat kMEMyPosterContentCellOrgialHeight  = 220;
//#define kMEMyPosterContentIMageWdith (102 *kMeFrameScaleX())
#define kMEMyPosterContentCellWdith ((SCREEN_WIDTH - (k10Margin*4))/3)

@interface MEMyPosterContentCell : UICollectionViewCell
//我的分享
- (void)setiWithModel:(MEPosterChildrenModel *)Model;
//更多
- (void)setiWitMorehModel:(MEPosterChildrenModel *)Model;

+ (CGFloat)getCellHeight;

@property (nonatomic, copy) kMeBasicBlock delBlock;
@property (nonatomic, copy) kMeBasicBlock btnBlock;

@end
