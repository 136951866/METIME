//
//  MEBrandMangerSortVC.m
//  ME时代
//
//  Created by hank on 2019/3/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandMangerSortVC.h"
#import "MEBrandManngerVC.h"
#import "MEBrandAiCell.h"
#import "YBPopupMenu.h"

const static CGFloat kselectViewHeight = 57;

@interface MEBrandMangerSortVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate,JXCategoryViewDelegate,YBPopupMenuDelegate>{
    NSInteger _currentType;
    UIButton *_currntBtn;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIView *selectView;

@property (nonatomic, strong)  UIButton *btnAll;
@property (nonatomic, strong)  UIButton *btnSort;
@property (nonatomic, strong)  UIView *lineView;

@end

@implementation MEBrandMangerSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];

    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, kCategoryViewHeight)];
    //    self.categoryView.lineStyle = JXCategoryLineStyle_None;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 32 * kMeFrameScaleX();
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.indicators = @[lineView];
    
    self.categoryView.titles = @[@"按客户数",@"按互动数",@"按成交率"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kMEPink;
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _currentType;
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    [self.refresh.arrData addObjectsFromArray:@[@"",@"",@""]];
    return @{@"token":kMeUnNilStr(kCurrentUser.token),
             };
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    //    [self.refresh.arrData addObjectsFromArray:[MEDistributionTeamModel mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MEBrandAiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBrandAiCell class]) forIndexPath:indexPath];
    [cell setSortUIWithModel:@"" sortNum:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kMEBrandAiCellHeight;
}

#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kCategoryViewHeight+kselectViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMEBrandManngerVCHeaderHeight-kCategoryViewHeight-kselectViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBrandAiCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBrandAiCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    return _tableView;
}

- (UIView *)selectView{
    if(!_selectView){
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, kCategoryViewHeight, SCREEN_WIDTH, kselectViewHeight)];
        _btnAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAll.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, kselectViewHeight);
        [_btnAll addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btnAll setTitle:@"客户总数" forState:UIControlStateNormal];
        _btnAll.titleLabel.font = kMeFont(13);
        [_btnAll setTitleColor:kMEblack forState:UIControlStateNormal];

        _btnAll.tag = kMeViewBaseTag;
        [_selectView addSubview:_btnAll];
        _currntBtn = _btnAll;
        
        _btnSort = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSort.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, kselectViewHeight);
        [_btnSort setTitle:@"昨日新增客户" forState:UIControlStateNormal];
        [_btnSort setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [_btnSort setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:-(20 *kMeFrameScaleX())];
        [_btnSort setTitleColor:kMEblack forState:UIControlStateNormal];
        [_btnSort addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnSort.titleLabel.font = kMeFont(13);
        _btnSort.tag = kMeViewBaseTag+1;
        [_selectView addSubview:_btnSort];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kselectViewHeight-12, 32, 2)];
        _lineView.backgroundColor = kMEPink;
        _lineView.centerX = _btnAll.centerX;
        [_selectView addSubview:_lineView];
    }
    return _selectView;
}

- (void)selectAction:(UIButton *)btn{
    if(_currntBtn == btn && btn.tag == kMeViewBaseTag){
        return;
    }
    _currntBtn = btn;
    _lineView.centerX = _currntBtn.centerX;
    if(btn.tag == kMeViewBaseTag+1){
        kMeWEAKSELF
        [YBPopupMenu showRelyOnView:btn titles:@[@"昨日新增客户",@"7天新增客户",@"30天新增客户"] icons:nil menuWidth:SCREEN_WIDTH/2 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.priorityDirection = YBPopupMenuPriorityDirectionTop;
            popupMenu.borderWidth = 1;
            popupMenu.borderColor = kMEblack;
            kMeSTRONGSELF
            popupMenu.delegate = strongSelf;
        }];
    }
}

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index{
    NSString *title = ybPopupMenu.titles[index];
    [_btnSort setTitle:title forState:UIControlStateNormal];
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:@""];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有店铺";
        }];
    }
    return _refresh;
}


@end
