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

@interface MEProductDetailCommentCell()

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
    kSDLoadImg(_imgHeader, kMeUnNilStr(@""));
    _lblName.text = kMeUnNilStr(@"1111");
    _lblSku.text = kMeUnNilStr(@"1111");
    _starView.score = 3;
    [_viewForPhoto setImageViewWithArr:model];
    _consPhotoHeight.constant = [MENineGridView getViewHeightWIth:model];
    NSString *str = kMeUnNilStr(@"对撒更好的骨灰级的感觉啊个电话就啊三个打火机噶伤筋动骨回家啊说过的话就撒过的话就撒过后觉得贵卅很简单噶伤感的");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:(SCREEN_WIDTH - 20) lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
    [_lblTitle setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    [self layoutIfNeeded];
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
