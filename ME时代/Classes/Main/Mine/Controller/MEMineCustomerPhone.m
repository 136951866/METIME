//
//  MEMineCustomerPhone.m
//  ME时代
//
//  Created by hank on 2018/10/9.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEMineCustomerPhone.h"

#define kMeWorkPhone @"18102678630"
#define kMeOffWorkPhone @"13580363686"

@interface MEMineCustomerPhone ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;

@end

@implementation MEMineCustomerPhone

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    _consTopMargin.constant = kMeStatusBarHeight+k15Margin;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - Private

- (IBAction)workCallPhoneAction:(UIButton *)sender {
    [MECommonTool showWithTellPhone:kMeWorkPhone inView:self.view];
}

- (IBAction)offWorkCallPhoneAction:(UIButton *)sender {
    [MECommonTool showWithTellPhone:kMeOffWorkPhone inView:self.view];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
