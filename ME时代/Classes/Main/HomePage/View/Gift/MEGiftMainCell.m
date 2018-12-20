//
//  MEGiftMainCell.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGiftMainCell.h"
#import "MEGiftMainContentCell.h"
@interface MEGiftMainCell ()<UITableViewDelegate,UITableViewDataSource>{
    kMeBasicBlock _block;

}

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) id model;



@end

@implementation MEGiftMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor clearColor];
    _arrData = [NSArray array];
    [_tableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([MEGiftMainContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEGiftMainContentCell class])];
    _tableVIew.rowHeight = kMEGiftMainContentCellHeight;
    _tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableVIew.showsVerticalScrollIndicator = NO;
    _tableVIew.scrollEnabled = NO;
    _tableVIew.bounces = NO;
    _tableVIew.delegate = self;
    _tableVIew.dataSource = self;
    _tableVIew.tableFooterView = [UIView new];
    // Initialization code
}

- (void)setUIWithModel:(id)model block:(kMeBasicBlock)block{
    _block = block;
    self.model = model;
    _arrData = @[@"",@"",@""];
    _lblNum.text = [NSString stringWithFormat:@"共%@件",@(_arrData.count)];
    [self.tableVIew reloadData];
}

- (IBAction)continuAction:(UIButton *)sender {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MEGiftMainContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEGiftMainContentCell class]) forIndexPath:indexPath];
    id model = _arrData[indexPath.row];
    [cell setUIWIthModel:model];
    return cell;
}

+ (CGFloat)getCellHeightWithModel:(id )model{
    NSArray *arr = @[@"",@"",@""];
    if(arr.count == 0){
        return 0;
    }
    CGFloat height = 40;
    height+=arr.count *kMEGiftMainContentCellHeight;
    return height;
}

@end
