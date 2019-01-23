//
//  MEBynamicHomeVC.m
//  ME时代
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBynamicHomeVC.h"
#import "MEBynamicMainCell.h"
#import "CLInputToolbar.h"

@interface MEBynamicHomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrModel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CLInputToolbar *inputToolbar;

@end

@implementation MEBynamicHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态";
    _arrModel = @[@"",@""];
    [self.view addSubview:self.tableView];
    [self setTextViewToolbar];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = _arrModel[indexPath.row];
    MEBynamicMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBynamicMainCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     id model = _arrModel[indexPath.row];
    return [MEBynamicMainCell getCellHeightithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.inputToolbar showToolbar];
}

-(void)setTextViewToolbar {
    self.inputToolbar = [[CLInputToolbar alloc] init];
    self.inputToolbar.textViewMaxLine = 3;
    self.inputToolbar.fontSize = 20;
    self.inputToolbar.placeholder = @"请输入...";
    self.inputToolbar.showMaskView = YES;
    __weak __typeof(self) weakSelf = self;
    [self.inputToolbar inputToolbarSendText:^(NSString *text) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",strongSelf.inputToolbar.inputText);
        // 清空输入框文字
        [strongSelf.inputToolbar clearText];
    }];
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBynamicMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBynamicMainCell class])];
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

@end
