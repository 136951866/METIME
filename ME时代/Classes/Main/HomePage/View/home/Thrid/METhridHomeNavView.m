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
@interface METhridHomeNavView ()

@property (nonatomic, strong)UIView *viewForBack;
@property (nonatomic, strong)UIButton *btnNotice;
@property (nonatomic, strong)UIView *viewForSearch;
@property (nonatomic, strong)UIImageView *imageForSearch;
@property (nonatomic, strong)UIView *viewForUnread;
@end

@implementation METhridHomeNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubUIView];
    }
    return self;
}

- (void)addSubUIView{
    self.userInteractionEnabled = YES;
    [self addSubview:self.viewForBack];
    [self addSubview:self.viewForSearch];
    [self.viewForSearch addSubview:self.imageForSearch];
    [self addSubview:self.btnNotice];
    [self addSubview:self.viewForUnread];
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
        _viewForUnread = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20, self.btnNotice.top+5,6, 6)];
        _viewForUnread.backgroundColor = [UIColor redColor];
        _viewForUnread.cornerRadius = 3;
        _viewForUnread.clipsToBounds = YES;
    }
    return _viewForUnread;
}

- (UIView *)viewForBack{
    if(!_viewForBack){
        _viewForBack = [[UIView alloc]initWithFrame:self.bounds];
        _viewForBack.backgroundColor = kMEea3782;
        _viewForBack.alpha = 0;
    }
    return _viewForBack;
}

- (UIView *)viewForSearch{
    if(!_viewForSearch){
        CGFloat top = ((IS_iPhoneX==YES||IS_IPHONE_Xr==YES||IS_IPHONE_Xs==YES||IS_IPHONE_Xs_Max==YES) ? 36 : 25);
        _viewForSearch = [[UIView alloc]initWithFrame:CGRectMake(10, top, self.width-65, 35)];
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
        _btnNotice = [MEView btnWithFrame:CGRectMake(self.viewForSearch.right+10, self.viewForSearch.top, 35, 35) Img:[UIImage imageNamed:@"thirdHomeNotice"]];
        [_btnNotice addTarget:self action:@selector(noticeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNotice;
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

- (void)toNotice{
    METhridHomeVC *homeVC = (METhridHomeVC *)[MECommonTool getVCWithClassWtihClassName:[METhridHomeVC class] targetResponderView:self];
//        if([kCurrentUser.mobile isEqualToString:AppstorePhone]){
//            MERCConversationListVC *svc = [[MERCConversationListVC alloc]init];
//            [homeVC.navigationController pushViewController:svc animated:YES];
//        }else{
//        if(homeVC){
            MENoticeVC *svc = [[MENoticeVC alloc]init];
            [homeVC.navigationController pushViewController:svc animated:YES];
//        }
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
    if(alpha>1){
        _viewForBack.alpha = 1;
    }
    if(alpha<0){
        _viewForBack.alpha = 0;
    }
}

@end
