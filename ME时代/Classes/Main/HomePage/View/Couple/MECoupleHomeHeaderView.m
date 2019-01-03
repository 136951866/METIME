//
//  MECoupleHomeHeaderView.m
//  ME时代
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECoupleHomeHeaderView.h"


@interface MECoupleHomeHeaderView ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSdViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImageH;

@end

@implementation MECoupleHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = kMEfbfbfb;
    _consSdViewHeight.constant = 150 *kMeFrameScaleX();
    [self initSD];
    CGFloat imageW = (SCREEN_WIDTH - 12)/2;
    CGFloat imageH = (imageW * 178)/364;
    _consImageH.constant = imageH;
    [self layoutIfNeeded];
}

- (void)setUiWithModel:(id)Model{
    __block NSMutableArray *arrImage = @[@"",@"",@""];//[NSMutableArray array];
//    [model enumerateObjectsUsingBlock:^(MEAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arrImage addObject:kMeUnNilStr(model.ad_img)];
//    }];
    _sdView.contentMode = UIViewContentModeScaleAspectFill;
    _sdView.clipsToBounds = YES;
    _sdView.imageURLStringsGroup = arrImage;
}

- (void)initSD{
    _sdView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _sdView.pageControlStyle =SDCycleScrollViewPageContolStyleClassic;
    _sdView.autoScrollTimeInterval = 4;
    _sdView.delegate =self;
    _sdView.backgroundColor = [UIColor clearColor];
    _sdView.placeholderImage = kImgBannerPlaceholder;
    _sdView.currentPageDotColor = kMEPink;
}



- (IBAction)haoJuanAction:(UIButton *)sender {
    
}

- (IBAction)topBuyAction:(UIButton *)sender {
    
}
- (IBAction)shishangAction:(UIButton *)sender {
}

- (IBAction)teHuiAction:(UIButton *)sender {
    
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
}

+ (CGFloat)getViewHeight{
    CGFloat height = 0;
    CGFloat sdHeight = 150 *kMeFrameScaleX();
    CGFloat imageW = (SCREEN_WIDTH - 12)/2;
    CGFloat imageH = (imageW * 178)/364;
    height = sdHeight + (imageH*2) +8;
    return height;
}

@end
