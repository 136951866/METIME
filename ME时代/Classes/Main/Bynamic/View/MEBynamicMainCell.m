//
//  MEBynamicMainCell.m
//  ME时代
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBynamicMainCell.h"
#import "MEBynamicCommentView.h"
#import "MENineGridView.h"

#define kmainCommentCellWdith (SCREEN_WIDTH - 10 -36-10-10)

@interface MEBynamicMainCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet MENineGridView *gridView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consGridViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet MEBynamicCommentView *viewCommentAndLike;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consComentHeight;

@end

@implementation MEBynamicMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    kSDLoadImg(_imgHeader, kMeUnNilStr(@""));
    _lblName.text = kMeUnNilStr(@"1111");
    
    NSString *str = kMeUnNilStr(@"对撒更好的骨灰级的感觉啊个电话就啊三个打火机噶伤筋动骨回家啊说过的话就撒过的话就撒过后觉得贵卅很简单噶伤感的");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:kmainCommentCellWdith lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
    [_lblTitle setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    
     _consGridViewHeight.constant = [MENineGridView getDymmaincViewHeightWIth:@[@"",@"",@"",@""]];
    [_gridView setImageDymamicViewWithArr:@[@"",@"",@"",@""]];
   

    _consComentHeight.constant = [MEBynamicCommentView getViewHeightWithArrLike:@[] Arrcomment:@[]];
    [_viewCommentAndLike setUIWithArrLike:@[@"",@""] Arrcomment:@[@"",@"",@"",@"",@"",@""]];
    [self layoutIfNeeded];
}

+ (CGFloat)getCellHeightithModel:(id)model{
    CGFloat height = 11+20+7;
    NSString *str = kMeUnNilStr(@"对撒更好的骨灰级的感觉啊个电话就啊三个打火机噶伤筋动骨回家啊说过的话就撒过的话就撒过后觉得贵卅很简单噶伤感的");
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:kmainCommentCellWdith lineH:0 maxLine:0];
    height += titleHeight>17?titleHeight:17;
    
    NSArray *photo = @[@"",@"",@"",@""];
    if(photo.count){
        height+= [MENineGridView getDymmaincViewHeightWIth:photo];
        height+=14;
    }else{
        height+=14;
    }
    height+=25;
    height+=[MEBynamicCommentView getViewHeightWithArrLike:@[@"",@""] Arrcomment:@[@"",@"",@"",@"",@"",@""]];
    return height;
    
}

@end
