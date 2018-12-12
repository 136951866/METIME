//
//  MEClerkSearchDataVC.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEClerkSearchDataVC.h"
#import "MEClerkCell.h"
#import "ZLRefreshTool.h"

@interface MEClerkSearchDataVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSString *_key;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation MEClerkSearchDataVC

- (instancetype)initWithKey:(NSString *)key{
    if(self = [super init]){
        _key = kMeUnNilStr(key);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"搜索%@",_key];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    [self.refresh.arrData addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    return @{@"keyword":_key};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[NSObject mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.refresh.arrData[indexPath.row];
    MEClerkCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEClerkCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model withKey:_key];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMEClerkCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEClerkCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEClerkCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
        _tableView.tableFooterView = view;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(@"")];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有店员";
        }];
    }
    return _refresh;
}


@end
