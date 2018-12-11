//
//  MEVistorPathMainCell.m
//  ME时代
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEVistorPathMainCell.h"
#import "MEVistorUserModel.h"

@interface MEVistorPathMainCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UIView *viewForContent;

@end

@implementation MEVistorPathMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _viewForContent.layer.shadowColor = [UIColor colorWithHexString:@"f0f5fe"].CGColor;
    _viewForContent.layer.shadowOpacity = 1;
    _viewForContent.layer.shadowOffset = CGSizeMake(0, 0);
    _viewForContent.layer.shadowRadius = 5;;
    // Initialization code
}

- (void)setUiWIthModle:(MEVistorUserModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.article.images_url));
    _lblTitle.text = kMeUnNilStr(model.article.title);
    _lblTime.text =  kMeUnNilStr(model.updated_at);
}
@end
