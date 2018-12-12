//
//  MEGetCaseCell.m
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEGetCaseCell.h"
#import "MEGetCaseContentCell.h"

@interface MEGetCaseCell ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrData;
    BOOL _isDataDeal;
}
@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTableHeight;

    
@end

@implementation MEGetCaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEGetCaseContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEGetCaseContentCell class])];
    _tableView.rowHeight = kMEGetCaseContentCellHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [UIView new];
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    _isDataDeal = NO;
    _lblNo.text = kMeUnNilStr(@"");
    _lblStatus.text = kMeUnNilStr(@"");
    _arrData = @[@"",@"",@""];
    _consTableHeight.constant = kMEGetCaseContentCellHeight * kMeUnArr(_arrData).count;
    [self.tableView reloadData];
}

- (void)setUIDataDealWIthModel:(id)model{
    _isDataDeal = YES;
    _lblNo.text = kMeUnNilStr(@"");
    _lblStatus.hidden = YES;
    _arrData = @[@"",@"",@""];
    _consTableHeight.constant = kMEGetCaseContentCellHeight * kMeUnArr(_arrData).count;
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kMeUnArr(_arrData).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MEGetCaseContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEGetCaseContentCell class]) forIndexPath:indexPath];
    id model = kMeUnArr(_arrData)[indexPath.row];
    if(_isDataDeal){
        [cell setUIDataDealWIthModel:model];
    }else{
        [cell setUIWIthModel:model];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

+ (CGFloat)getCellHeightWithModel:(id )model{
    CGFloat height = 56;
    NSArray *arrdata =  @[@"",@"",@""];
    height += (kMEGetCaseContentCellHeight * kMeUnArr(arrdata).count);
    return height;
}


@end
