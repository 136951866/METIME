//
//  MEProductDetailCommentCell.m
//  ME时代
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEProductDetailCommentCell.h"
#import "MENineGridView.h"
#import "MEStarControl.h"
#import "YBImageBrowser.h"

@interface MEProductDetailCommentCell()<YBImageBrowserDataSource>{
    NSArray *_model;
    NSInteger _currentIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet MEStarControl *starView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet MENineGridView *viewForPhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consPhotoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblSku;

@end

@implementation MEProductDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUiWIthModel:(id)model{
    _model = model;
    _currentIndex = 0;
    kSDLoadImg(_imgHeader, kMeUnNilStr(@""));
    _lblName.text = kMeUnNilStr(@"1111");
    _lblSku.text = kMeUnNilStr(@"1111");
    _starView.score = 3;
    [_viewForPhoto setImageViewWithArr:model];
    kMeWEAKSELF
    _viewForPhoto.selectBlock = ^(NSInteger index) {
        kMeSTRONGSELF
        strongSelf->_currentIndex = index;
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSource = strongSelf;
        browser.currentIndex = index;
        [browser show];
    };
    _consPhotoHeight.constant = [MENineGridView getViewHeightWIth:model];
    NSString *str = kMeUnNilStr(@"对撒更好的骨灰级的感觉啊个电话就啊三个打火机噶伤筋动骨回家啊说过的话就撒过的话就撒过后觉得贵卅很简单噶伤感的");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:(SCREEN_WIDTH - 20) lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
    [_lblTitle setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    [self layoutIfNeeded];
}

//YBImageBrowserDataSource 代理实现赋值数据
- (NSInteger)numberInYBImageBrowser:(YBImageBrowser *)imageBrowser {
    return _model.count;
}
- (YBImageBrowserModel *)yBImageBrowser:(YBImageBrowser *)imageBrowser modelForCellAtIndex:(NSInteger)index {
    NSString *urlStr = [_model objectAtIndex:index];
    YBImageBrowserModel *model = [YBImageBrowserModel new];
    model.url = [NSURL URLWithString:urlStr];
    //model.sourceImageView = [imageViewArray objectAtIndex:index];
    return model;
}
- (UIImageView *)imageViewOfTouchForImageBrowser:(YBImageBrowser *)imageBrowser {
    return [_viewForPhoto.arrImageView objectAtIndex:_currentIndex];
}

+ (CGFloat)getCellHeightWithModel:(id)model{
    CGFloat height = 10+10+40+10+15+10+10;
    NSString *str = kMeUnNilStr(@"对撒更好的骨灰级的感觉啊个电话就啊三个打火机噶伤筋动骨回家啊说过的话就撒过的话就撒过后觉得贵卅很简单噶伤感的");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:(SCREEN_WIDTH - 20) lineH:0 maxLine:0];
    height+=titleHeight>17?titleHeight:17;
    CGFloat photoheight = [MENineGridView getViewHeightWIth:model];
    if(photoheight>0){
        height+=(14+photoheight);
    }else{
        height+=10;
    }
    return height;
}


@end
