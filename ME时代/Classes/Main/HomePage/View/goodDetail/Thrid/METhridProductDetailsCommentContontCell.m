//
//  METhridProductDetailsCommentContontCell.m
//  ME时代
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridProductDetailsCommentContontCell.h"

@interface METhridProductDetailsCommentContontCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblPhotoNum;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeaderProtail;


@end

@implementation METhridProductDetailsCommentContontCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblPhotoNum.text = [NSString stringWithFormat:@"%@张",kMeUnNilStr(@"2")];
    _lblTitle.text = kMeUnNilStr(@"1111111");
    _lblName.text = kMeUnNilStr(@"1111111");
    kSDLoadImg(_imgHeaderProtail, kMeUnNilStr(@""));
}

@end
