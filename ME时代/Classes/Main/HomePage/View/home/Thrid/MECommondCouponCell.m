//
//  MECommondCouponCell.m
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MECommondCouponCell.h"
#import "MECommondCouponContentCell.h"

const static CGFloat kMargin = 10;
@interface MECommondCouponCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrModel;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;

@end

@implementation MECommondCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
    // Initialization code
}

- (void)initSomeThing{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MECommondCouponContentCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MECommondCouponContentCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MECommondCouponContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MECommondCouponContentCell class]) forIndexPath:indexPath];
    id model = self.arrModel[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kMECommondCouponContentCellWdith, kMECommondCouponContentCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, kMargin, 0, kMargin);
}


- (void)setUIWithArr:(NSArray *)arrModel imgUrl:(NSString *)imgUrl{
    kSDLoadImg(_imgPic, kMeUnNilStr(imgUrl));
    _arrModel = arrModel;
    [self.collectionView reloadData];
}

+ (CGFloat)getCellHeight{
    return 255 * kMeFrameScaleX();
}

@end
