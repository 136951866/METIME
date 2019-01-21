//
//  METhridHomeNavView.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeNavView.h"

@interface METhridHomeNavView ()

@property (nonatomic, strong)UIView *viewForBack;
@property (nonatomic, strong)UIButton *btnNotice;
@property (nonatomic, strong)UIView *viewForSearch;
@property (nonatomic, strong)UIImageView *imageForSearch;

@end

@implementation METhridHomeNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubUIView];
    }
    return self;
}

- (void)addSubUIView{
    [self addSubview:self.viewForBack];
    [self addSubview:self.viewForSearch];
    [self.viewForSearch addSubview:self.imageForSearch];
    [self addSubview:self.btnNotice];
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
        _viewForSearch = [[UIView alloc]initWithFrame:CGRectMake(10, kMeStatusBarHeight+5, self.width-65, 35)];
        _viewForSearch.backgroundColor = [UIColor whiteColor];
        _viewForSearch.cornerRadius = 35/2;
        _viewForSearch.clipsToBounds = YES;
    }
    return _viewForSearch;
}

- (UIButton *)btnNotice{
    if(!_btnNotice){
        _btnNotice = [MEView btnWithFrame:CGRectMake(self.viewForSearch.right+10, self.viewForSearch.top, 35, 35) Img:[UIImage imageNamed:@"thirdHomeNotice"]];
    }
    return _btnNotice;
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
