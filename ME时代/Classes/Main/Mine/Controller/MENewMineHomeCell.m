//
//  MENewMineHomeCell.m
//  ME时代
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MENewMineHomeCell.h"
#import "MENewMineHomeContentCell.h"
#import "MEMyDistrbutionVC.h"
#import "MEMyAppointmentVC.h"
#import "MEInteralExchangVC.h"
#import "MELoginVC.h"
#import "MEAddTelView.h"
#import "MERCConversationListVC.h"
#import "AppDelegate.h"
#import "MEMineCustomerPhone.h"
#import "MEExpireTipView.h"
#import "MESelectAddressVC.h"
#import "MEMyMobileVC.h"
#import "MEProductListVC.h"
#import "MeMyActityMineVC.h"
#import "MENewMineHomeVC.h"
#import "MEPosterListVC.h"
#import "MEArticelVC.h"
#import "MEVisiterHomeVC.h"
#import "MECouponOrderVC.h"
#import "MEStoreApplyVC.h"
#import "MEStoreApplyModel.h"
#import "MEStoreApplyStatusVC.h"
#import "MEDynamicGoodApplyVC.h"

@interface MENewMineHomeCell()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_arrModel;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MENewMineHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    _arrModel = @[];
    [self initSomeThing];
}

- (void)initSomeThing{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MENewMineHomeContentCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MENewMineHomeContentCell class])];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

#pragma mark- CollectionView Delegate And DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MENewMineHomeVC *homeVc = [MECommonTool getVCWithClassWtihClassName:[MENewMineHomeVC class] targetResponderView:self];
    if(!homeVc){
        return;
    }
    MEMineHomeCellStyle type = [_arrModel[indexPath.row] intValue];
    switch (type) {
        case MeMyDistribution:{
            //我的中心
            MEMyDistrbutionVC *dvc = [[MEMyDistrbutionVC alloc]initWithC];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyCentraManagertment:{
            //管理中心
            MEMyDistrbutionVC *dvc = [[MEMyDistrbutionVC alloc]init];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyAppointment:{
            MEMyAppointmentVC *dvc = [[MEMyAppointmentVC alloc]initWithType:MEAppointmenyUseing];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyExchange:{
            MEInteralExchangVC *dvc = [[MEInteralExchangVC alloc]init];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyCustomer:{
            MERCConversationListVC *cvc = [[MERCConversationListVC alloc]init];
            [homeVc.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case MeMyCustomerPhone:{
            MEMineCustomerPhone *cvc = [[MEMineCustomerPhone alloc]init];
            [homeVc.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case MeMyAddress:{
            MESelectAddressVC *address = [[MESelectAddressVC alloc]init];
            [homeVc.navigationController pushViewController:address animated:YES];
        }
            break;
        case MeMyMobile:{
            MEMyMobileVC *mobile = [[MEMyMobileVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeMyActity:{
            MeMyActityMineVC *mobile = [[MeMyActityMineVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MemyData:{
            MEVisiterHomeVC *mobile = [[MEVisiterHomeVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeMyPoster:{
            MEPosterListVC *mobile = [[MEPosterListVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeMyArticel:{
            MEArticelVC *mobile = [[MEArticelVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeStoreApply:{
            [MEPublicNetWorkTool postGetMemberStoreInfoWithsuccessBlock:^(ZLRequestResponse *responseObject) {
                if(![responseObject.data isKindOfClass:[NSDictionary class]] || responseObject.data==nil){
                    MEStoreApplyVC *vc = [[MEStoreApplyVC alloc]init];
                    [homeVc.navigationController pushViewController:vc animated:YES];
                }else{
                    MEStoreApplyModel *model = [MEStoreApplyModel mj_objectWithKeyValues:responseObject.data];
                    MEStoreApplyStatusVC *vc = [[MEStoreApplyStatusVC alloc]init];
                    vc.model = model;
                    [homeVc.navigationController pushViewController:vc animated:YES];
                }
            } failure:^(id object) {
                
            }];
        }
            break;
        case MeDynalApply:{
            MEDynamicGoodApplyVC *vc = [[MEDynamicGoodApplyVC alloc]init];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MENewMineHomeContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MENewMineHomeContentCell class]) forIndexPath:indexPath];
    MEMineHomeCellStyle type = [_arrModel[indexPath.row] intValue];
    [cell setUIWithType:type];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kMENewMineHomeContentCellWdith, kMENewMineHomeContentCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)setUIWithAtrr:(NSArray *)arr{
    _arrModel = kMeUnArr(arr);
    [_collectionView reloadData];
}

+ (CGFloat)getHeightWithArr:(NSArray *)arr{
    if(arr.count == 0){
        return 0;
    }
    NSInteger section = (arr.count/3)+((arr.count%3)>0?1:0);
    CGFloat height =  (section * kMENewMineHomeContentCellHeight)+25+15;
    return height;
}

@end
