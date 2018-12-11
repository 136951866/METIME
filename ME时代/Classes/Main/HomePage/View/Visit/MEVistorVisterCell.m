//
//  MEVistorVisterCell.m
//  ME时代
//
//  Created by hank on 2018/11/28.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEVistorVisterCell.h"
#import "MEVisterDetailVC.h"
#import "MEVisiterHomeVC.h"
#import "MEVistorPathVC.h"
#import "MEArticleDetailVC.h"
#import "MEVistorUserModel.h"
#import "MEArticelModel.h"

@interface MEVistorVisterCell (){
    MEVistorUserModel *_model;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UIImageView *imgArticel;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnInvite;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblComing;

@end

@implementation MEVistorVisterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblName.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(MEVistorUserModel *)model{
    _model = model;
    kSDLoadImg(_imgHeader, kMeUnNilStr(model.user.header_pic));
    kSDLoadImg(_imgArticel, kMeUnNilStr(model.article.images_url));
    NSString *intentStr = @"访客";
    if(model.is_intention==2){
        intentStr = @"意向客户";
    }
    _lblName.text = [NSString stringWithFormat:@"%@ %@",kMeUnNilStr(model.user.nick_name),intentStr];
    _lblDesc.text = [NSString stringWithFormat:@"第%@次访问",@(model.browse).description];
    _lblTitle.text = kMeUnNilStr(model.article.title);
    _lblTime.text = kMeUnNilStr(model.updated_at);
    _lblComing.text = [NSString stringWithFormat:@"%@ >",kMeUnNilStr(model.source.nick_name)];
    if(model.is_intention==2){
        [_btnInvite setTitle:@"取消意向客户" forState:UIControlStateNormal];
//        _btnInvite.hidden = YES;
    }else{
        [_btnInvite setTitle:@"置为意向客户" forState:UIControlStateNormal];
//        _btnInvite.hidden = NO;
    }
}

- (IBAction)toVisterDetalAction:(UIButton *)sender {
    MEVisiterHomeVC *homeVC = [MECommonTool getVCWithClassWtihClassName:[MEVisiterHomeVC class] targetResponderView:self];
    if(homeVC){
        MEVisterDetailVC *detaliVC =[[MEVisterDetailVC alloc]initWithModel:_model];
        [homeVC.navigationController pushViewController:detaliVC animated:YES];
    }
}

- (IBAction)setIntentAction:(UIButton *)sender {
    kMeWEAKSELF
    if(_model.is_intention==2){
        [MEPublicNetWorkTool postSetIntentioUserId:@(_model.idField).description intentio:@"1" SuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_setIntenBlock);
        } failure:^(id object) {
            
        }];
    }else{
        [MEPublicNetWorkTool postSetIntentioUserId:@(_model.idField).description intentio:@"2" SuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_setIntenBlock);
        } failure:^(id object) {
            
        }];
    }

}

- (IBAction)toArticelAction:(UIButton *)sender {
    MEVisiterHomeVC *homeVC = [MECommonTool getVCWithClassWtihClassName:[MEVisiterHomeVC class] targetResponderView:self];
    if(homeVC){
        MEArticelModel *modela = [MEArticelModel new];
        modela.article_id = _model.article_id;
        modela.images_url = _model.article.images_url;
        modela.title = _model.article.title;
        MEArticleDetailVC *pathVC = [[MEArticleDetailVC alloc]initWithModel:modela];
        [homeVC.navigationController pushViewController:pathVC animated:YES];
    }
}

- (IBAction)toPathAction:(UIButton *)sender {
    MEVisiterHomeVC *homeVC = [MECommonTool getVCWithClassWtihClassName:[MEVisiterHomeVC class] targetResponderView:self];
    if(homeVC){
        MEVistorPathVC *pathVC = [[MEVistorPathVC alloc]initWithModel:_model];
        [homeVC.navigationController pushViewController:pathVC animated:YES];
    }
}

@end
