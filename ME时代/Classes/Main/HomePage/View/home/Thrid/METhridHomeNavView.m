//
//  METhridHomeNavView.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeNavView.h"
#import "METhridHomeVC.h"
#import "MEProductSearchVC.h"
#import "MERCConversationListVC.h"
//#import "MENoticeTypeVC.h"
#import "MENoticeVC.h"
#import "MEFilterVC.h"
#import "MEStoreModel.h"

@interface METhridHomeNavView (){
    CGFloat _top;
}

@property (nonatomic, strong)UIView *viewForBack;
@property (nonatomic, strong)UIButton *btnNotice;
@property (nonatomic, strong)UIButton *btnSort;
@property (nonatomic, strong)UIView *viewForSearch;
@property (nonatomic, strong)UIImageView *imageForSearch;
@property (nonatomic, strong)UIView *viewForUnread;
@property (nonatomic, strong)UIView *viewForStore;

@property (nonatomic, strong)UIImageView *imgStore;
@property (nonatomic, strong)UILabel *lblStoreName;
@end

@implementation METhridHomeNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = NO;
        [self addSubUIView];
    }
    return self;
}

- (void)addSubUIView{
    self.userInteractionEnabled = YES;
    _top = ((IS_iPhoneX==YES||IS_IPHONE_Xr==YES||IS_IPHONE_Xs==YES||IS_IPHONE_Xs_Max==YES) ? 36 : 25);

    [self addSubview:self.viewForBack];
    [self addSubview:self.viewForSearch];
    [self.viewForSearch addSubview:self.imageForSearch];
    [self addSubview:self.btnNotice];
    [self addSubview:self.btnSort];
    [self addSubview:self.viewForUnread];
    [self addSubview:self.viewForStore];
    self.viewForUnread.hidden = YES;
}

- (void)setRead:(BOOL)read{
    self.viewForUnread.hidden = read;
}

- (void)searchProduct{
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        MEProductSearchVC *svc = [[MEProductSearchVC alloc]init];
        [homeVC.navigationController pushViewController:svc animated:NO];
    }
}

- (UIView *)viewForUnread{
    if(!_viewForUnread){
        _viewForUnread = [[UIView alloc]initWithFrame:CGRectMake(self.btnNotice.right-12, self.btnNotice.top+5,6, 6)];
        _viewForUnread.backgroundColor = [UIColor redColor];
        _viewForUnread.cornerRadius = 3;
        _viewForUnread.clipsToBounds = YES;
    }
    return _viewForUnread;
}

- (UIView *)viewForBack{
    if(!_viewForBack){
        _viewForBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMEThridHomeNavViewHeight-kImgStoreMargin-kImgStore)];
        _viewForBack.backgroundColor = kMEea3782;
        _viewForBack.alpha = 0;
    }
    return _viewForBack;
}

- (UIView *)viewForStore{
    if(!_viewForStore){
        _viewForStore.userInteractionEnabled = YES;
        _viewForStore = [[UIView alloc]initWithFrame:CGRectMake(0, self.viewForBack.bottom, SCREEN_WIDTH, kImgStore)];
        _viewForStore.backgroundColor = [UIColor clearColor];
        _viewForStore.alpha = 0;
        
        _imgStore = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, kImgStore, kImgStore)];
        [_viewForStore addSubview:_imgStore];
        
        _lblStoreName = [[UILabel alloc]initWithFrame:CGRectMake(_imgStore.right+10, 5, self.width-kImgStore-(kImgStore *3), kImgStore)];
        _lblStoreName.textColor = [UIColor whiteColor];
        _lblStoreName.font = kMeFont(15);
        [_viewForStore addSubview:_lblStoreName];
    }
    return _viewForStore;
}

- (void)setStoreInfoWithModel:(MEStoreModel *)model{
    if(model){
        kSDLoadImg(_imgStore, kMeUnNilStr(model.mask_img));
        NSShadow *shaow = [[NSShadow alloc]init];
        shaow.shadowBlurRadius = 1.0;
        shaow.shadowOffset = CGSizeZero;
        shaow.shadowColor = [UIColor blackColor];
        NSAttributedString *att = [[NSAttributedString alloc]initWithString:kMeUnNilStr(model.store_name) attributes:@{NSShadowAttributeName:shaow}];
        _lblStoreName.attributedText = att;
    }else{
        _imgStore.image = [UIImage imageNamed:@"icon-wgvilogo"];
        NSShadow *shaow = [[NSShadow alloc]init];
        shaow.shadowBlurRadius = 1.0;
        shaow.shadowOffset = CGSizeZero;
        shaow.shadowColor = [UIColor blackColor];
        NSAttributedString *att = [[NSAttributedString alloc]initWithString:@"ME时代旗舰店" attributes:@{NSShadowAttributeName:shaow}];
        _lblStoreName.attributedText = att;
    }
}


- (UIView *)viewForSearch{
    if(!_viewForSearch){
        _viewForSearch = [[UIView alloc]initWithFrame:CGRectMake(self.btnNotice.right+10, _top, self.width-110, 35)];
        _viewForSearch.backgroundColor = [UIColor whiteColor];
        _viewForSearch.cornerRadius = 35/2;
        _viewForSearch.clipsToBounds = YES;
        UITapGestureRecognizer *search = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchProduct)];
        _viewForSearch.userInteractionEnabled = YES;
        [_viewForSearch addGestureRecognizer:search];
    }
    return _viewForSearch;
}

- (UIButton *)btnNotice{
    if(!_btnNotice){
        _btnNotice = [MEView btnWithFrame:CGRectMake(10, _top, 35, 35) Img:[UIImage imageNamed:@"thirdHomeNotice"]];
        [_btnNotice addTarget:self action:@selector(noticeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNotice;
}

- (UIButton *)btnSort{
    if(!_btnSort){
        _btnSort = [MEView btnWithFrame:CGRectMake(self.viewForSearch.right+10, self.viewForSearch.top, 35, 35) Img:[UIImage imageNamed:@"thirdHomeSort"]];
        [_btnSort addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSort;
}

- (void)noticeAction:(UIButton*)btn{
    if([MEUserInfoModel isLogin]){
        [self toNotice];
    }else{
        kMeWEAKSELF
        [MEWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            [strongSelf toNotice];
        } failHandler:nil];
    }
}

- (void)sortAction:(UIButton*)btn{
     METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
    if(homeVC){
        MEFilterVC *vc = [[MEFilterVC alloc]init];
        [homeVC.navigationController pushViewController:vc animated:YES];
    }
}

- (void)toNotice{
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
//        if([kCurrentUser.mobile isEqualToString:AppstorePhone]){
//            MERCConversationListVC *svc = [[MERCConversationListVC alloc]init];
//            [homeVC.navigationController pushViewController:svc animated:YES];
//        }else{
        if(homeVC){
            MENoticeVC *svc = [[MENoticeVC alloc]init];
            [homeVC.navigationController pushViewController:svc animated:YES];
        }
//    }
}

- (UIImageView *)imageForSearch{
    if(!_imageForSearch){
        _imageForSearch = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchHome"]];
        _imageForSearch.contentMode = UIViewContentModeScaleAspectFit;
        _imageForSearch.frame = CGRectMake(10, 9.5, 16, 16);
    }
    return _imageForSearch;
}

- (void)setBackAlpha:(CGFloat)alpha{
    _viewForBack.alpha = alpha;
//    _viewForStore.alpha = alpha;
    if(alpha>1){
        _viewForBack.alpha = 1;
//        _viewForStore.alpha = 1;
    }
    if(alpha<0){
        _viewForBack.alpha = 0;
//        _viewForStore.alpha = 0;
    }
}

- (void)setStroeBackAlpha:(CGFloat)alpha{
//    _viewForBack.alpha = alpha;
    _viewForStore.alpha = alpha;
    if(alpha>1){
//        _viewForBack.alpha = 1;
        _viewForStore.alpha = 1;
    }
    if(alpha<0){
//        _viewForBack.alpha = 0;
        _viewForStore.alpha = 0;
    }
}


@end
