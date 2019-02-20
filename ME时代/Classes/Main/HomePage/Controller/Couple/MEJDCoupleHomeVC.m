//
//  MEJDCoupleHomeVC.m
//  ME时代
//
//  Created by hank on 2019/2/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEJDCoupleHomeVC.h"
#import "MECoupleHomeNavView.h"
#import "MEJDCoupleHomeMainGoodGoodsCell.h"
#import "MEAdModel.h"

NSUInteger const kJDSizeNum = 20;

@interface MEJDCoupleHomeVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrSdImage;
    NSMutableArray *_arrData;
    NSInteger _pageIndex;//当前页
    NSInteger _allRows;//总数据
    
}

@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) MECoupleHomeNavView *navView;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation MEJDCoupleHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    _arrSdImage = @[];
    _arrData = [NSMutableArray array];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.cycleScrollView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerfresh)];
    self.tableView.mj_footer.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)headrefresh{
    _pageIndex = 1;
//    [self requestNetWorkIsHead:YES];
}

- (void)footerfresh{
    NSInteger size = kJDSizeNum;
    if(_pageIndex > _allRows/size){
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    ++ _pageIndex;
    [self requestNetWorkIsHead:NO];
}

- (void)reload{
    [ZLFailLoadView removeFromView:self.tableView];
    if (self.tableView.mj_header) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        _pageIndex = 1;
        [_arrData removeAllObjects];
        [self requestNetWorkIsHead:YES];
    }
}

- (void)requestNetWorkIsHead:(BOOL)isHead{
     [ZLFailLoadView removeFromView:self.tableView];
    NSDictionary *dic = @{@"eliteId":@"1",
                          @"pageSize":@"20",
                          @"page":@(_pageIndex)
                          };
    NSString *url = kGetApiWithUrl(MEIPcommonjingdonggoodsJingFen);
    
    kMeWEAKSELF
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
//        if (strongSelf->_pageIndex == 1) {
//            [strongSelf->_arrData removeAllObjects];
//        }
//        NSDictionary *dic = 
        
    } failure:^(id error) {
       
    }];
}




- (void)setSdImageModel:(NSArray *)arrModel{
    _arrSdImage = arrModel;
    __block NSMutableArray *arrImage = [NSMutableArray array];
    [arrModel enumerateObjectsUsingBlock:^(MEAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrImage addObject:kMeUnNilStr(model.ad_img)];
    }];
    self.cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollView.clipsToBounds = YES;
    self.cycleScrollView.imageURLStringsGroup = arrImage;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat imageh = (SCREEN_WIDTH*80)/750;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goodgoods"]];
    img.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageh);
    return img;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (SCREEN_WIDTH*80)/750;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MEJDCoupleHomeMainGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEJDCoupleHomeMainGoodGoodsCell class]) forIndexPath:indexPath];
    [cell setUIWithArr:_arrData];
    kMeWEAKSELF
    cell.selectBlock = ^(NSInteger index) {
        kMeSTRONGSELF
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MEJDCoupleHomeMainGoodGoodsCell getCellHeightWithArr:_arrData];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    MEAdModel *model = kMeUnArr(_arrSdImage)[index];
    
}

- (SDCycleScrollView *)cycleScrollView{
    if(!_cycleScrollView){
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150 *kMeFrameScaleX()) imageURLStringsGroup:nil];
        _cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.clipsToBounds = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.pageControlStyle =SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.delegate =self;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.placeholderImage = kImgBannerPlaceholder;
        _cycleScrollView.currentPageDotColor = kMEPink;
    }
    return _cycleScrollView;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEJDCoupleHomeMainGoodGoodsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEJDCoupleHomeMainGoodGoodsCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kMEf5f4f4;
    }
    return _tableView;
}

- (MECoupleHomeNavView *)navView{
    if(!_navView){
        _navView = [[[NSBundle mainBundle]loadNibNamed:@"MECoupleHomeNavView" owner:nil options:nil] lastObject];
        _navView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kMeNavBarHeight);
        kMeWEAKSELF
        _navView.backBlock = ^{
            kMeSTRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
        _navView.searchBlock = ^{
            
        };
    }
    return _navView;
}

@end
