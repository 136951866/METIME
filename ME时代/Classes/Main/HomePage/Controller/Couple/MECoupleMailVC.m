//
//  MECoupleMailVC.m
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MECoupleMailVC.h"
#import "MECoupleMailCell.h"
#import "MECoupleModel.h"
#import "MECoupleMailDetalVC.h"

@interface MECoupleMailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation MECoupleMailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠卷";
    [self.view addSubview:self.collectionView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    return @{@"r":@"Port/index",@"type":@"total",@"appkey":@"58de5a1fe2",@"v":@"2"};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[MECoupleModel mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark- CollectionView Delegate And DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MECoupleModel *model = self.refresh.arrData[indexPath.row];
    MECoupleMailDetalVC *vc = [[MECoupleMailDetalVC alloc]initWithDetailId:model.ID];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MECoupleMailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MECoupleMailCell class]) forIndexPath:indexPath];
    MECoupleModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kMECoupleMailCellWdith, kMECoupleMailCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kMEMargin, 0, kMEMargin, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kMEMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kMEMargin;
}


#pragma mark - Getting And Setting

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MECoupleMailCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MECoupleMailCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        
    }
    return _collectionView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.collectionView url:@"http://api.dataoke.com/index.php"];
        _refresh.delegate = self;
        _refresh.isGet = YES;
        _refresh.isDataInside = YES;
        _refresh.isCouple = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有优惠产品";
        }];
    }
    return _refresh;
}


@end
