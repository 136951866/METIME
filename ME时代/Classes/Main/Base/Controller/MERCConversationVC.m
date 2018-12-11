//
//  MERCConversationVC.m
//  ME时代
//
//  Created by hank on 2018/9/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MERCConversationVC.h"
#import <IQKeyboardManager.h>

@interface MERCConversationVC ()

@end

@implementation MERCConversationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:2];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [super leftBarButtonItemPressed:nil];
    kNoticeReloadkUnMessage
    [IQKeyboardManager sharedManager].enable = YES;
}


@end
