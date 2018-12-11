//
//  ZLRefreshTool.m
//  我要留学
//
//  Created by Hank on 10/13/16.
//  Copyright © 2016 深圳市智联天下国际教育有限公司. All rights reserved.
//

#import "ZLRefreshTool.h"
#import "THTTPRequestOperationManager.h"
#import "ZLRequestResponse.h"
#import "MENetListModel.h"

NSString *const kPage = @"page";
//NSString *const kAllRows = @"amout";
NSString *const kSize = @"pageSize";
NSUInteger const kSizeNum = 10;
//pageSize
@interface ZLRefreshTool()

//重新设置faileview的bolck
@property (nonatomic,copy) editFailLoadVIewBlock blockEditFailVIew;

@end

@implementation ZLRefreshTool

- (instancetype)initWithContentView:(UIScrollView *)scrollView url:(NSString *)url{
    self = [super init];
    if (self) {
        _errViewNotRefresh = NO;
        _contentView = scrollView;
        _arrData = [[NSMutableArray alloc] initWithCapacity:26];
        _showFailView = YES;
        _url = url;
    }
    return self;
}

#pragma mark - API

- (void)addRefreshView{
    [self addHeadRefreshView];
    [self addFooterRefreshView];
}

- (void)addHeadRefreshView{
//    [self.contentView addHeaderWithTarget:self action:@selector(headrefresh)];
    self.contentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefresh)];
    if (self.delegate) {
        [self reload];
    }
}

- (void)headrefresh{
    self.pageIndex = 1;
    [self requestNetWorkIsHead:YES];
}

- (void)addFooterRefreshView{
//    [self.contentView addFooterWithTarget:self action:@selector(footerfresh)];
    self.contentView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerfresh)];
    self.contentView.mj_footer.hidden = YES;
}

- (void)footerfresh{
    NSInteger size = kSizeNum;
    if ([_numOfsize integerValue] > 0) {
        size = [_numOfsize integerValue];
    }
    if(self.pageIndex > self.allRows/size){
        [self.contentView.mj_footer endRefreshing];
//        [KAToolClass showMessage:@"已无更多数据" inView:kCurrentWindow];
        [self.contentView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    ++ self.pageIndex;
    [self requestNetWorkIsHead:NO];
}

- (void)requestNetWorkIsHead:(BOOL)isHead{
    [ZLFailLoadView removeFromView:self.contentView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestParameter)] && [self.delegate respondsToSelector:@selector(handleResponse:)]) {
        
        NSDictionary *parameter = [self requestParameter];
        NSLog(@"MERefresh\n%@",parameter);
        if (!self.url) return;
        
        kMeWEAKSELF
        RequestResponse successBlock = ^(ZLRequestResponse *responseObject){
            kMeSTRONGSELF
            if (!strongSelf ) {
                return;
            }
            
            if (strongSelf.pageIndex == 1) {
                [strongSelf.arrData removeAllObjects];
            }
            if(self.isDataInside){
                MENetListModel *nlModel = [MENetListModel mj_objectWithKeyValues:responseObject.data];
                strongSelf.allRows = nlModel.count;
                [strongSelf.delegate handleResponse:nlModel.data];
            }else{
                [strongSelf.delegate handleResponse:responseObject.data];
                //                strongSelf.allRows = responseObject.amount;
            }
            
            //reloadData
            if ([strongSelf.contentView respondsToSelector:@selector(reloadData)]) {
                [(id)strongSelf.contentView reloadData];
            }
            [strongSelf endRefreshIsHead:isHead];
            //若有数据显示上拉控件
            [strongSelf showFailLoadViewWithResponse:responseObject];
            if (strongSelf.arrData.count > 0) strongSelf.contentView.mj_footer.hidden = NO;
        };
    
    
    
        kMeObjBlock failblock = ^(id error){
            kMeSTRONGSELF
            if (!strongSelf) {
                return;
            }
            [strongSelf endRefreshIsHead:isHead];
            if ([strongSelf.contentView respondsToSelector:@selector(reloadData)]) {
                [(id)strongSelf.contentView reloadData];
            }
            [strongSelf showFailLoadViewWithResponse:error];
            if ([strongSelf.delegate respondsToSelector:@selector(failureResponse:)]) {
                [strongSelf.delegate failureResponse:error];
            }
            strongSelf.contentView.mj_footer.hidden = !(strongSelf.arrData.count > 0);
        };
        
        if(_isGet){
            [THTTPManager getWithParameter:parameter strUrl:self.url success:successBlock failure:failblock];
        }else{
            [THTTPManager postWithParameter:parameter strUrl:self.url success:successBlock failure:failblock];
        }
    }
}

- (void)showFailLoadViewWithResponse:(id)response{
    if (!_showFailView) {
        return;
    }
    kMeWEAKSELF
    [ZLFailLoadView showInView:self.contentView response:response allData:self.arrData refreshBlock:^{
        kMeSTRONGSELF
        if (!strongSelf ||strongSelf.errViewNotRefresh) {
            return;
        }
        [strongSelf reload];
    } editHandle:^(ZLFailLoadView *failView) {
        kMeSTRONGSELF
        if (strongSelf->_blockEditFailVIew) {
            strongSelf->_blockEditFailVIew(failView);
        }
    }];
}

- (void)reload{
    [ZLFailLoadView removeFromView:self.contentView];
    if (self.contentView.mj_header) {
        [self.contentView.mj_header beginRefreshing];
    } else {
        self.pageIndex = 1;
        [self.arrData removeAllObjects];
        [self requestNetWorkIsHead:YES];
    }
}

- (void)endRefreshIsHead:(BOOL)isHead{
    if (isHead) {
        [self.contentView.mj_header endRefreshing];
    }else{
        [self.contentView.mj_footer endRefreshing];
    }
//    if (self.allRows <= self.arrData.count && self.arrData.count > 0 && !isHead) {
//        [KAToolClass showMessage:@"已无更多数据" inView:kCurrentWindow];
//    }
    if (self.allRows <= self.arrData.count && self.arrData.count > 0) {
        [self.contentView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.contentView.mj_footer resetNoMoreData];
    }
}

- (NSDictionary *)requestParameter{
    NSMutableDictionary *parameter = [[self.delegate requestParameter] mutableCopy];
    parameter[kPage] = @(self.pageIndex);
    if(_numOfsize>0){
        parameter[kSize] = _numOfsize;
    }else{
        parameter[kSize] = @(20);
    }
    return parameter;
}

- (NSMutableArray *)arrData{
    if(!_arrData){
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}


@end
