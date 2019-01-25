//
//  MERushBuyCell.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MERushBuyCell.h"
#import "MERushBuyContentCell.h"
#import "METhridHomeRudeGoodModel.h"

@interface MERushBuyCell ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MERushBuyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomething];
}

- (void)initSomething{
    self.selectionStyle = 0;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MERushBuyContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MERushBuyContentCell class])];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMERushBuyContentCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MERushBuyContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MERushBuyContentCell class]) forIndexPath:indexPath];
    METhridHomeRudeGoodModel *model = _arrModel[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrModel.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)setUIWithArr:(NSArray *)arr{
    _arrModel = arr;
    [self.tableView reloadData];
}

+ (CGFloat)getCellHeightWithArr:(NSArray *)arr{
    NSInteger num = kMeUnArr(arr).count;
    return num *kMERushBuyContentCellHeight;
}



@end
