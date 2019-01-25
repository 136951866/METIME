//
//  MECompandNoticeVC.m
//  ME时代
//
//  Created by hank on 2019/1/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECompandNoticeVC.h"
#import "TDWebViewCell.h"

@interface MECompandNoticeVC (){
    NSString *_content;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (strong, nonatomic) TDWebViewCell                  *webCell;

@end

@implementation MECompandNoticeVC

- (void)dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    kTDWebViewCellDidFinishLoadNotificationCancel
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ME隐私权注政策";
    _content = @"dhjdhjshdk";
    [self.view addSubview:self.tableView];
    kTDWebViewCellDidFinishLoadNotification
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(networkRequest)];
    [self.tableView.mj_header beginRefreshing];
}
kTDWebViewCellDidFinishLoadNotificationMethod
- (void)networkRequest{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
    [self.webCell.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",header,kMeUnNilStr(_content)] baseURL:nil];
    [self.tableView.mj_header endRefreshing];
    [MBProgressHUD showMessage:@"" toView:self.view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.webCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_webCell){
        return 0;
    }else{
        return [[self.webCell.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
    }
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-45) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (TDWebViewCell *)webCell{
    if(!_webCell){
        _webCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class])];
    }
    return _webCell;
}

@end
