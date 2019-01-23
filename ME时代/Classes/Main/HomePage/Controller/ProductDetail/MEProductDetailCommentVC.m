//
//  MEProductDetailCommentVC.m
//  ME时代
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEProductDetailCommentVC.h"
#import "MEProductDetailCommentCell.h"
#import "METhridProductCommentHeaderView.h"
#import "YBImageBrowser.h"

@interface MEProductDetailCommentVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDataSource>{
    NSArray *_arrModel;
    METhridProductCommentHeaderViewType _type;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) METhridProductCommentHeaderView *headerView;;
@end

@implementation MEProductDetailCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _type = METhridProductCommentHeaderViewAllType;
    _arrModel = @[@[],@[@""],@[@"",@""],@[@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118687954&di=d92e4024fe4c2e4379cce3d3771ae105&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201605%2F18%2F20160518181939_nCZWu.gif",@"",@""],@[@"",@"",@"",@"",@"",@""],@[@"",@"",@"",@"",@"",@"",@""],@[@"",@"",@"",@"",@"",@"",@"",@""],@[@"",@"",@"",@"",@"",@"",@"",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118687954&di=d92e4024fe4c2e4379cce3d3771ae105&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201605%2F18%2F20160518181939_nCZWu.gif",@""]];
    self.title = @"评论";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView setUIWithModel:@"" type:_type];
    // Do any additional setup after loading the view.
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *model = _arrModel[indexPath.row];
    MEProductDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEProductDetailCommentCell class]) forIndexPath:indexPath];
    [cell setUiWIthModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *model = _arrModel[indexPath.row];
    return [MEProductDetailCommentCell getCellHeightWithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEProductDetailCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEProductDetailCommentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = kMEededed;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (METhridProductCommentHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"METhridProductCommentHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,kMEThridProductCommentHeaderViewHeight);
        _headerView.selectBlock = ^(NSInteger index) {
            
        };
    }
    return _headerView;
}

@end
