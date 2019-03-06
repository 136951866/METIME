//
//  MERCConversationListVC.m
//  ME时代
//
//  Created by hank on 2018/9/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MERCConversationListVC.h"
#import "AppDelegate.h"

@interface MERCConversationListVC (){
    NSString *_customId;
}

@property (nonatomic, strong) UIButton *btnRight;

@end

@implementation MERCConversationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ME聊";
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
////    [[RCIM sharedRCIM] setUserInfoDataSource:self];
//    self.isShowNetworkIndicatorView = NO;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)toCustom{
//    if(kMeUnNilStr(_customId).length){
//        MERCConversationVC *conversationVC = [[MERCConversationVC alloc]init];
//        conversationVC.conversationType = ConversationType_PRIVATE;
//        conversationVC.targetId =  kMeUnNilStr(_customId);//RONGYUNCUSTOMID;
//        conversationVC.title = @"客服";
//        if([kMeUnNilStr(_customId) isEqualToString:kCurrentUser.uid]){
//            [MEShowViewTool showMessage:@"暂不支持和自己聊天" view:self.view];
//        }else{
//            [self.navigationController pushViewController:conversationVC animated:YES];
//        }
//    }else{
//        kMeWEAKSELF
//        [MEPublicNetWorkTool postGetCustomIdWithsuccessBlock:^(ZLRequestResponse *responseObject) {
//            kMeSTRONGSELF
//            NSNumber *custom =kMeUnNilNumber(responseObject.data);
//            strongSelf->_customId = kMeUnNilStr(custom.description);
//            MERCConversationVC *conversationVC = [[MERCConversationVC alloc]init];
//            conversationVC.conversationType = ConversationType_PRIVATE;
//            conversationVC.targetId = strongSelf->_customId ;//RONGYUNCUSTOMID;
//            conversationVC.title = @"客服";
//            if([kMeUnNilStr(strongSelf->_customId) isEqualToString:kCurrentUser.uid]){
//                [MEShowViewTool showMessage:@"暂不支持和自己聊天" view:self.view];
//            }else{
//                [self.navigationController pushViewController:conversationVC animated:YES];
//            }
//        } failure:^(id object) {
//
//        }];
//    }
    
}

//- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
//{
//    if([model.targetId isEqualToString:kCurrentUser.uid]){
//        [MEShowViewTool showMessage:@"暂不支持和自己聊天" view:self.view];
//    }else{
////        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////        appDelegate.unMessageCount = appDelegate.unMessageCount - model.unreadMessageCount;
//        MERCConversationVC *conversationVC = [[MERCConversationVC alloc]init];
//        conversationVC.conversationType = ConversationType_PRIVATE;
//        conversationVC.conversationType = model.conversationType;
//        conversationVC.targetId = model.targetId;
//        conversationVC.title = model.conversationTitle;
//        [self.navigationController pushViewController:conversationVC animated:YES];
//        kNoticeReloadkUnMessage
//    }
//}

- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(-20, 0, 30, 25);
        [_btnRight setTitle:@"客服" forState:UIControlStateNormal];
        _btnRight.titleLabel.font = kMeFont(14);
        [_btnRight setTitleColor:kMEblack forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(toCustom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

@end
