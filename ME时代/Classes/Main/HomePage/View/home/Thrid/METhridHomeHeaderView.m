//
//  METhridHomeHeaderView.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeHeaderView.h"

const static CGFloat kSdHeight = 178;
const static CGFloat kSecondImageHeight = 154;
const static CGFloat kThridImageWidth = 200;

@interface METhridHomeHeaderView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSdHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSecondImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consThridImageWidth;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet UIImageView *imgFrist;
@property (weak, nonatomic) IBOutlet UIImageView *imgSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imgFristGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgSecondGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgQiao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;

@end

@implementation METhridHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _consSdHeight.constant = kSdHeight*kMeFrameScaleX();
    _consSecondImageHeight.constant = kSecondImageHeight*kMeFrameScaleX();
    if(kMeFrameScaleX()<1){
       _consThridImageWidth.constant = kThridImageWidth*kMeFrameScaleX();
    }
    _consTopMargin.constant = kMeStatusBarHeight+5;
}

- (void)setUIWithModel:(id)model{
    kSDLoadImg(_imgFrist, kMeUnNilStr(@""));
    kSDLoadImg(_imgSecond, kMeUnNilStr(@""));
    kSDLoadImg(_imgFristGood, kMeUnNilStr(@""));
    kSDLoadImg(_imgSecondGood, kMeUnNilStr(@""));
    kSDLoadImg(_imgQiao, kMeUnNilStr(@""));
}

+ (CGFloat)getViewHeight{
    CGFloat heigth = 785 - kSdHeight - kSecondImageHeight;
    heigth+=(kSdHeight*kMeFrameScaleX());
    heigth+=(kSecondImageHeight*kMeFrameScaleX());
    return heigth;
}

@end
