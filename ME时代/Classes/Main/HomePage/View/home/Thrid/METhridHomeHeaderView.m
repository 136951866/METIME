//
//  METhridHomeHeaderView.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeHeaderView.h"
#import "METhridHomeModel.h"
#import "METhridHomeVC.h"
#import "METhridProductDetailsVC.h"
#import "MEServiceDetailsVC.h"
#import "MEMidelButton.h"
#import "MEProductListVC.h"
#import "MECoupleHomeVC.h"
#import "METhridRushSpikeVC.h"
#import "MEFilterVC.h"

typedef NS_ENUM(NSUInteger, METhridHomeHeaderViewActiveType) {
    METhridHomeHeaderViewActiveNewType = 0,
    METhridHomeHeaderViewActiveRudeType =1,
    METhridHomeHeaderViewActiveTbcouponType = 2,
    METhridHomeHeaderViewActivePinduoduoCouponType = 3,
    METhridHomeHeaderViewActiveServiceType =4,
    METhridHomeHeaderViewActiveSortType =5
};
const static CGFloat kSdHeight = 178;
const static CGFloat kSecondImageHeight = 154;
const static CGFloat kThridImageWidth = 177;
const static CGFloat kThridImageHeight = 200;
@interface METhridHomeHeaderView ()<SDCycleScrollViewDelegate>{
    METhridHomeModel *_model;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSdHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSecondImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consThridImageWidth;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet UIImageView *imgFrist;
@property (weak, nonatomic) IBOutlet UIImageView *imgSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imgFristGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgSecondGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgQiao;
@property (weak, nonatomic) IBOutlet UILabel *lblFristGoodTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFristGoodSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSGoodTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSGoodSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRudeTite;
@property (weak, nonatomic) IBOutlet UILabel *lblRudePrice;
@property (weak, nonatomic) IBOutlet UIView *viewFrist;
@property (weak, nonatomic) IBOutlet UIView *sencodView;
@property (weak, nonatomic) IBOutlet UIView *viewforScard;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consServiceHeight;

@end

@implementation METhridHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _sdView.delegate = self;
    _lblFristGoodTitle.adjustsFontSizeToFitWidth = YES;
    _lblSGoodTitle.adjustsFontSizeToFitWidth = YES;

    _consSdHeight.constant = kSdHeight*kMeFrameScaleX();
    _consSecondImageHeight.constant = kSecondImageHeight*kMeFrameScaleX();
    _lblRudePrice.adjustsFontSizeToFitWidth = YES;
    if(kMeFrameScaleX()<1){
       _consThridImageWidth.constant = kThridImageWidth*kMeFrameScaleX();
      _consServiceHeight.constant = kThridImageHeight*kMeFrameScaleX();
    }
    _viewFrist.hidden = YES;
    _sencodView.hidden = YES;
    self.userInteractionEnabled = YES;
    
     //新人专享
    UITapGestureRecognizer *memberExclusiveges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(memberExclusive)];
    _imgFrist.userInteractionEnabled = YES;
    [_imgFrist addGestureRecognizer:memberExclusiveges];
    //抢购商品
    UITapGestureRecognizer *scareBuyingges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scareBuying)];
    _imgSecond.userInteractionEnabled = YES;
    [_imgSecond addGestureRecognizer:scareBuyingges];
    //服务
    
    UITapGestureRecognizer *serviceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(serviceTap)];
    _viewFrist.userInteractionEnabled = YES;
    [_viewFrist addGestureRecognizer:serviceTap];
    
    UITapGestureRecognizer *servicetwoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(servicetwoTap)];
    _sencodView.userInteractionEnabled = YES;
    [_sencodView addGestureRecognizer:servicetwoTap];
    
    //暴抢
    
    UITapGestureRecognizer *scardGoodTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scardGoodTap)];
    _viewforScard.userInteractionEnabled = YES;
    [_viewforScard addGestureRecognizer:scardGoodTap];
}

//新人专享
- (void)memberExclusive{
    if(!_model.member_exclusive){
        return;
    }
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        METhridProductDetailsVC *details = [[METhridProductDetailsVC alloc]initWithId:_model.member_exclusive.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

//抢购商品
- (void)scareBuying{
    if(!_model.scare_buying_banner){
        return;
    }
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        METhridProductDetailsVC *details = [[METhridProductDetailsVC alloc]initWithId:_model.scare_buying_banner.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

//服务
- (void)serviceTap{
    if(kMeUnArr(_model.service).count==0){
        return;
    }
    METhridHomeserviceModel *smodel = _model.service[0];
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        MEServiceDetailsVC *details = [[MEServiceDetailsVC alloc]initWithId:smodel.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

- (void)servicetwoTap{
    if(kMeUnArr(_model.service).count!=2){
        return;
    }
    METhridHomeserviceModel *smodel = _model.service[1];
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
         MEServiceDetailsVC *details = [[MEServiceDetailsVC alloc]initWithId:smodel.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

//暴抢
- (void)scardGoodTap{
    if(!kMeUnArr(_model.scare_buying_goods).count){
        return ;
    }
    METhridHomeBuyingGoodsModel *scare_buying_good = _model.scare_buying_goods[0];
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        METhridProductDetailsVC *details = [[METhridProductDetailsVC alloc]initWithId:scare_buying_good.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    METhridHomeAdModel *model = kMeUnArr(_model.top_banner)[index];
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        METhridProductDetailsVC *dvc = [[METhridProductDetailsVC alloc]initWithId:model.product_id];
        [homeVC.navigationController pushViewController:dvc animated:YES];
    }
}

- (void)setUIWithModel:(METhridHomeModel *)model{
    _model = model;
    //sd
    __block NSMutableArray *arrImage = [NSMutableArray array];
    [kMeUnArr(model.top_banner) enumerateObjectsUsingBlock:^(METhridHomeAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrImage addObject:kMeUnNilStr(model.ad_img)];
    }];
    _sdView.contentMode = UIViewContentModeScaleAspectFill;
    _sdView.clipsToBounds = YES;
    _sdView.imageURLStringsGroup = arrImage;
    
    //新人专享
    kSDLoadImg(_imgFrist, kMeUnNilStr(model.member_exclusive.img));
    
    //抢购商品
    kSDLoadImg(_imgSecond, kMeUnNilStr(model.scare_buying_banner.img));

    //服务
    for (NSInteger i=0; i<kMeUnArr(model.service).count; i++) {
        METhridHomeserviceModel *smodel = model.service[i];
        if(i==0){
            _viewFrist.hidden = NO;
            kSDLoadImg(_imgFristGood, MELoadQiniuImagesWithUrl(kMeUnNilStr(smodel.images)));
            _lblFristGoodTitle.text = kMeUnNilStr(smodel.title);
            _lblSGoodSubtitle.text = kMeUnNilStr(smodel.desc);
        }
        if(i==1){
            _sencodView.hidden = NO;
            kSDLoadImg(_imgSecondGood, MELoadQiniuImagesWithUrl(kMeUnNilStr(smodel.images)));
            _lblSGoodTitle.text = kMeUnNilStr(smodel.title);
            _lblSGoodSubtitle.text = kMeUnNilStr(smodel.desc);
        }
    }
    //暴抢
    if(kMeUnArr(model.scare_buying_goods).count){
        METhridHomeBuyingGoodsModel *scare_buying_good = model.scare_buying_goods[0];
        kSDLoadImg(_imgQiao,MELoadQiniuImagesWithUrl(kMeUnNilStr(scare_buying_good.images)));
        _lblRudeTite.text = kMeUnNilStr(scare_buying_good.title);
        _lblRudePrice.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(scare_buying_good.money).floatValue)];
    }else{
        kSDLoadImg(_imgQiao,@"");
        _lblRudeTite.text = @"";
        _lblRudePrice.text = @"";
    }
    
}

- (IBAction)activeAction:(MEMidelMiddelImageButton *)sender {
    NSInteger index = sender.tag-kMeViewBaseTag;
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        switch (index) {
            case METhridHomeHeaderViewActiveNewType:
            {
                [self memberExclusive];
            }
                break;
            case METhridHomeHeaderViewActiveRudeType:
            {
                METhridRushSpikeVC *vc= [[METhridRushSpikeVC alloc]init];
                [homeVC.navigationController pushViewController:vc animated:YES];
            }
                break;
            case METhridHomeHeaderViewActiveTbcouponType:
            {
                MECoupleHomeVC *vc= [[MECoupleHomeVC alloc]initWithIsTbK:YES];
                [homeVC.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case METhridHomeHeaderViewActivePinduoduoCouponType:
            {
                MECoupleHomeVC *vc= [[MECoupleHomeVC alloc]initWithIsTbK:NO];
                [homeVC.navigationController pushViewController:vc animated:YES];
            }
                break;
            case METhridHomeHeaderViewActiveServiceType:
            {
                MEProductListVC *vc= [[MEProductListVC alloc]initWithType:MEGoodsTypeNetServiceStyle];
                [homeVC.navigationController pushViewController:vc animated:YES];
            }
                break;
            case METhridHomeHeaderViewActiveSortType:
            {
                MEFilterVC *vc= [[MEFilterVC alloc]init];
                [homeVC.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}




+ (CGFloat)getViewHeight{
    CGFloat heigth = 785 - kSdHeight - kSecondImageHeight;
    heigth+=(kSdHeight*kMeFrameScaleX());
    heigth+=(kSecondImageHeight*kMeFrameScaleX());
    if(kMeFrameScaleX()<1){
        heigth-=kThridImageHeight;
        heigth+=(kThridImageHeight * kMeFrameScaleX());
    }
    return heigth;
}

@end
