//
//  MECoupleHomeHeaderView.m
//  ME时代
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECoupleHomeHeaderView.h"
#import "MECoupleHomeVC.h"
#import "MECoupleMailVC.h"
#import "MECoupleFilterVC.h"
#import "MEAdModel.h"
#import "MECoupleMailVC.h"

@interface MECoupleHomeHeaderView ()<SDCycleScrollViewDelegate>{
    NSArray *_Model;
}

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSdViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImageH;
@property (weak, nonatomic) IBOutlet UIButton *btnT;
@property (weak, nonatomic) IBOutlet UIButton *btnP;
@property (weak, nonatomic) IBOutlet UIView *viewForSel;

@end

@implementation MECoupleHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = kMEf5f4f4;
    _consSdViewHeight.constant = 150 *kMeFrameScaleX();
    [self initSD];
    CGFloat imageW = (SCREEN_WIDTH - 12)/2;
    CGFloat imageH = (imageW * 178)/364;
    _consImageH.constant = imageH;
    _btnT.selected = YES;
    _btnP.selected = NO;
    [self layoutIfNeeded];
}

- (void)setUiWithModel:(NSArray *)Model{
    _Model = Model;
    __block NSMutableArray *arrImage =[NSMutableArray array];
    [_Model enumerateObjectsUsingBlock:^(MEAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrImage addObject:kMeUnNilStr(model.ad_img)];
    }];
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


//好卷
- (IBAction)haoJuanAction:(UIButton *)sender {
    MECoupleHomeVC *homevc = [MECommonTool getVCWithClassWtihClassName:[MECoupleHomeVC class] targetResponderView:self];
    if(homevc){
        MECoupleMailVC *vc = [[MECoupleMailVC alloc]initWithType:MECouponSearchGoodGoodsType];
        [homevc.navigationController pushViewController:vc animated:YES];
    }
}
//特惠
- (IBAction)topBuyAction:(UIButton *)sender {
    MECoupleHomeVC *homevc = [MECommonTool getVCWithClassWtihClassName:[MECoupleHomeVC class] targetResponderView:self];
    if(homevc){
        MECoupleMailVC *vc = [[MECoupleMailVC alloc]initWithType:MECouponSearchTeHuiType];
        [homevc.navigationController pushViewController:vc animated:YES];
    }

}
//时尚
- (IBAction)shishangAction:(UIButton *)sender {
    MECoupleHomeVC *homevc = [MECommonTool getVCWithClassWtihClassName:[MECoupleHomeVC class] targetResponderView:self];
    if(homevc){
        MECoupleMailVC *vc = [[MECoupleMailVC alloc]initWithType:MECouponSearchShiShangType];
        [homevc.navigationController pushViewController:vc animated:YES];
    }
}
//分类
- (IBAction)teHuiAction:(UIButton *)sender {
    MECoupleHomeVC *homevc = [MECommonTool getVCWithClassWtihClassName:[MECoupleHomeVC class] targetResponderView:self];
    if(homevc){
        MECoupleFilterVC *vc = [[MECoupleFilterVC alloc]init];
        [homevc.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)tcouPonAction:(UIButton *)sender {
    if(_btnT.selected){
        return;
    }
    _viewForSel.centerX = sender.centerX;
    _btnT.selected = YES;
    _btnP.selected = NO;
    kMeCallBlock(_isSelectTbkBlock,YES);
}

- (IBAction)pCouponAction:(UIButton *)sender {
    if(_btnP.selected){
        return;
    }
    _viewForSel.centerX = sender.centerX;
    _btnT.selected = NO;
    _btnP.selected = YES;
     kMeCallBlock(_isSelectTbkBlock,NO);
}



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if(index>_Model.count){
        return;
    }
    MECoupleHomeVC *homevc = [MECommonTool getVCWithClassWtihClassName:[MECoupleHomeVC class] targetResponderView:self];
    if(homevc){
        MEAdModel *model = _Model[index];
        MECoupleMailVC *vc = [[MECoupleMailVC alloc]initWithQuery:kMeUnNilStr(model.keywork)];
        [homevc.navigationController pushViewController:vc animated:YES];
    }
}

+ (CGFloat)getViewHeight{
    CGFloat height = 0;
    CGFloat sdHeight = 150 *kMeFrameScaleX();
    CGFloat imageW = (SCREEN_WIDTH - 12)/2;
    CGFloat imageH = (imageW * 178)/364;
    height = sdHeight + (imageH*2) +8+51;
    return height;
}



@end
