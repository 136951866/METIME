//
//  MeMyActityMineCell.m
//  ME时代
//
//  Created by hank on 2019/1/6.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MeMyActityMineCell.h"
#import "MEMineActiveModel.h"

@interface MeMyActityMineCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;


@end

@implementation MeMyActityMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(MEMineActiveModel *)model{
    _lblMoney.hidden = NO;
    _lblNum.hidden = NO;
    _lblTime.text = [NSString stringWithFormat:@"发起时间:%@",kMeUnNilStr(model.created_at)];
    kSDLoadImg(_imgPic, kMeUnNilStr(model.image));
    _lblTitle.text = kMeUnNilStr(model.activity_name);
    if(model.doing){
        _lblStatus.text = @"未完成";
        _lblMoney.text = [NSString stringWithFormat:@"金额:%@",kMeUnNilStr(model.doing.reward)];
        _lblNum.text = [NSString stringWithFormat:@"达成条件%@:%@",kMeUnNilStr(model.share_number),kMeUnNilStr(model.doing.share_number)];
    }else{
        _lblStatus.text = @"已完成";
        MEMineActiveLeveModel *lmodel = [model.complete lastObject];
        if(lmodel){
            _lblMoney.text = [NSString stringWithFormat:@"金额:%@",kMeUnNilStr(lmodel.reward)];
            _lblNum.text = [NSString stringWithFormat:@"达成条件%@:%@",kMeUnNilStr(model.share_number),kMeUnNilStr(model.share_number)];
        }else{
            _lblMoney.hidden = YES;
            _lblNum.hidden = YES;
        }
    }
}

@end
