//
//  MEProductDetailsBottomView.m
//  ME时代
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEProductDetailsBottomView.h"
#import "MEProductDetailsVC.h"
#import "MEHomePageVC.h"
#import "MEStoreHomeVC.h"
#import "MEMidelButton.h"

@interface MEProductDetailsBottomView(){
    NSString *_paoductIdEndoceStr;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consPurchaseWdith;
@property (weak, nonatomic) IBOutlet MEMidelButton *btnShare;


@end

@implementation MEProductDetailsBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    _consPurchaseWdith.constant = 226 * kMeFrameScaleX();
    _btnShare.hidden = ![WXApi isWXAppInstalled];
}

- (IBAction)homeAction:(UIButton *)sender {
    MEProductDetailsVC *detailVC = (MEProductDetailsVC *)[MECommonTool getVCWithClassWtihClassName:[MEProductDetailsVC class] targetResponderView:self];
    if(detailVC){
        detailVC.tabBarController.selectedIndex = 0;
        [detailVC.navigationController popToRootViewControllerAnimated:YES];
//        MEHomePageVC *homeVC = (MEHomePageVC *)[MECommonTool getClassWtihClassName:[MEHomePageVC class] targetVC:detailVC];
//        if(homeVC){
//            [detailVC.navigationController popToViewController:homeVC animated:YES];
//        }else{
//            MEStoreHomeVC *shomeVC = (MEStoreHomeVC *)[MECommonTool getClassWtihClassName:[MEStoreHomeVC class] targetVC:detailVC];
//            if(shomeVC){
//                [detailVC.navigationController popToViewController:shomeVC animated:YES];
//            }
//        }
    }
}
- (IBAction)shareWxFriendAction:(UIButton *)sender {
    if([MEUserInfoModel isLogin]){
        [self sharAction];
    }else{
        kMeWEAKSELF
        [MEWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            [strongSelf sharAction];
        } failHandler:nil];
    }
}

- (void)sharAction{
    if(self.is_clerk_share){
        if(kCurrentUser.client_type == MEClientTypeClerkStyle){
            [self getShareEncode];
        }else{
            MEShareTool *shareTool = [MEShareTool me_instanceForTarget:self];
            shareTool.sharWebpageUrl = MEIPShare;
            NSLog(@"%@",MEIPShare);
            shareTool.shareTitle = @"睁着眼洗的洁面慕斯,你见过吗?";
            shareTool.shareDescriptionBody = @"你敢买我就敢送,ME时代氨基酸洁面慕斯(邮费10元)";
            shareTool.shareImage = kMeGetAssetImage(@"icon-wgvilogo");
            
            [shareTool shareWebPageToPlatformType:UMSocialPlatformType_WechatSession success:^(id data) {
                NSLog(@"分享成功%@",data);
                [MEPublicNetWorkTool postAddShareWithSuccessBlock:nil failure:nil];
                [MEShowViewTool showMessage:@"分享成功" view:kMeCurrentWindow];
            } failure:^(NSError *error) {
                NSLog(@"分享失败%@",error);
                [MEShowViewTool showMessage:@"分享失败" view:kMeCurrentWindow];
            }];
        }
    }else{
        MEShareTool *shareTool = [MEShareTool me_instanceForTarget:self];
        shareTool.sharWebpageUrl = MEIPShare;
        NSLog(@"%@",MEIPShare);
        shareTool.shareTitle = @"睁着眼洗的洁面慕斯,你见过吗?";
        shareTool.shareDescriptionBody = @"你敢买我就敢送,ME时代氨基酸洁面慕斯(邮费10元)";
        shareTool.shareImage = kMeGetAssetImage(@"icon-wgvilogo");
        
        [shareTool shareWebPageToPlatformType:UMSocialPlatformType_WechatSession success:^(id data) {
            NSLog(@"分享成功%@",data);
            [MEPublicNetWorkTool postAddShareWithSuccessBlock:nil failure:nil];
            [MEShowViewTool showMessage:@"分享成功" view:kMeCurrentWindow];
        } failure:^(NSError *error) {
            NSLog(@"分享失败%@",error);
            [MEShowViewTool showMessage:@"分享失败" view:kMeCurrentWindow];
        }];
    }
}

- (void)getShareEncode{
    MEShareTool *shareTool = [MEShareTool me_instanceForTarget:self];
    if(kMeUnNilStr(_paoductIdEndoceStr).length){
        shareTool.shareTitle = kMeUnNilStr(_paoductIdEndoceStr);
        [shareTool showShareView:kShareTextContentType success:^(id data) {
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        kMeWEAKSELF
        [MEPublicNetWorkTool postGoodsEncodeWithProductrId:self.productId successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_paoductIdEndoceStr = kMeUnNilStr(responseObject.data[@"share_text"]);
            shareTool.shareTitle = kMeUnNilStr(strongSelf->_paoductIdEndoceStr);
            [shareTool showShareView:kShareTextContentType success:^(id data) {
                
            } failure:^(NSError *error) {
                
            }];
        } failure:^(id object) {
            
        }];
    }
}


- (IBAction)shareWxCrial:(UIButton *)sender {
//    MEShareTool *shareTool = [MEShareTool me_instanceForTarget:self];
//    shareTool.sharWebpageUrl = @"http://www.baidu.com";
//    shareTool.shareTitle = @"test";
//    shareTool.shareDescriptionBody = @"test";
//    shareTool.shareImage = kMeGetAssetImage(@"icon-wgvilogo");
//
//    [shareTool shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine success:^(id data) {
//        NSLog(@"分享成功%@",data);
//        [MEShowViewTool showMessage:@"分享成功" view:kMeCurrentWindow];
//    } failure:^(NSError *error) {
//        NSLog(@"分享失败%@",error);
//        [MEShowViewTool showMessage:@"分享失败" view:kMeCurrentWindow];
//    }];
}

- (IBAction)addShopcart:(UIButton *)sender {
    kMeCallBlock(self.addShopcartBlock);
}

- (IBAction)buyAction:(UIButton *)sender {
    kMeCallBlock(self.buyBlock);
}

- (IBAction)customAction:(UIButton *)sender {
    kMeCallBlock(self.customBlock);
}

- (IBAction)giftAction:(UIButton *)sender {
    kMeCallBlock(self.addShopcartBlock);
}


@end
