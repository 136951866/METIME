//
//  MEClerkCell.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEClerkCell.h"

@interface MEClerkCell (){
    id _model;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@end

@implementation MEClerkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(id)model{
    _model = model;
    kSDLoadImg(_imgHeader, @"11");
    _lblName.text = kMeUnNilStr(@"1111");
    _lblPhone.text = [NSString stringWithFormat:@"手机号:%@",@"111"];
}

- (void)setUIWithModel:(id )model withKey:(NSString *)key{
    [self setUIWIthModel:model];
    if(kMeUnNilStr(key).length>0){
        _lblName.text = nil;
        _lblName.attributedText = [kMeUnNilStr(@"") attributeWithRangeOfString:key color:kMEPink];
        _lblPhone.text = nil;
        _lblPhone.attributedText = [kMeUnNilStr(@"") attributeWithRangeOfString:key color:kMEPink];
    }
}
@end
