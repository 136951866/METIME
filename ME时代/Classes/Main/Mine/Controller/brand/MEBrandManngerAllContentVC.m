//
//  MEBrandManngerAllContentVC.m
//  ME时代
//
//  Created by hank on 2019/3/8.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandManngerAllContentVC.h"
#import "MEBrandManngerVC.h"
#import "MEBrandAllDataCell.h"
#import "MEBrandTriangleCell.h"

@interface MEBrandManngerAllContentVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MEBrandManngerAllContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        MEBrandAllDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandAllDataCell class]) forIndexPath:indexPath];
         return cell;
    }else if (indexPath.row == 1){
        MEBrandTriangleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandTriangleCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        MEBrandAllDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandAllDataCell class]) forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return kMEBrandAllDataCellHeight;
    }else if (indexPath.row == 1){
        return kMEBrandTriangleCellHeight;
    }else{
        return kMEBrandAllDataCellHeight;
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMEBrandManngerVCHeaderHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBrandAllDataCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBrandAllDataCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBrandTriangleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBrandTriangleCell class])];
//
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


@end
