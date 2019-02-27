//
//  MEBDataDealStoreCustomerView.m
//  ME时代
//
//  Created by hank on 2019/2/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBDataDealStoreCustomerView.h"
#import "MEBDataDealStructView.h"
#import "MEBDataDealModel.h"

@interface MEBDataDealStoreCustomerView ()
@property (weak, nonatomic) IBOutlet UILabel *lblSpendTimes;
@property (weak, nonatomic) IBOutlet UILabel *lblSpendMax;
@property (weak, nonatomic) IBOutlet UILabel *lblSpendAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsDealTimes;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsDealAmount;

@property (weak, nonatomic) IBOutlet UILabel *lblAccessTimesByMouthWeb;
@property (weak, nonatomic) IBOutlet UILabel *lblAccessTimesByMouthApp;
@property (weak, nonatomic) IBOutlet UILabel *lblAccessTimesWeb;
@property (weak, nonatomic) IBOutlet UILabel *lblAccessTimesApp;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consStructHeight;
@property (weak, nonatomic) IBOutlet MEBDataDealStructView *structView;


@property (weak, nonatomic) IBOutlet UILabel *lblAgeFrameworkOne;
@property (weak, nonatomic) IBOutlet UILabel *lblAgeFrameworkTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblAgeFrameworkThree;
@property (weak, nonatomic) IBOutlet UILabel *lblAgeFrameworkFive;


@property (weak, nonatomic) IBOutlet UILabel *lblageCostOne;
@property (weak, nonatomic) IBOutlet UILabel *lblageCostTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblageCostThree;
@property (weak, nonatomic) IBOutlet UILabel *lblageCostFive;


@property (weak, nonatomic) IBOutlet UILabel *lblageageAverageCostOne;
@property (weak, nonatomic) IBOutlet UILabel *lblageageAverageCostTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblageageAverageCostThree;
@property (weak, nonatomic) IBOutlet UILabel *lblageageAverageCostFive;

@property (weak, nonatomic) IBOutlet UILabel *lblnewsAgeOne;
@property (weak, nonatomic) IBOutlet UILabel *lblnewsAgeTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblnewsAgeThree;
@property (weak, nonatomic) IBOutlet UILabel *lblnewsAgeFive;


@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeOne;
@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeThree;
@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeFive;


@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeOneAPP;
@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeTwoAPP;
@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeThreeApp;
@property (weak, nonatomic) IBOutlet UILabel *lblageAccessAgeFiveApp;



@end

@implementation MEBDataDealStoreCustomerView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setUIWithModel:(MEBDataDealModel *)model{
    [_structView setGoodNUmUIWithArr:kMeUnArr(model.storeCustomer.GoodsNum)];
    _consStructHeight.constant = [MEBDataDealStructView getViewWithArr:kMeUnArr(model.storeCustomer.GoodsNum)];
    _lblSpendTimes.text = kMeUnNilStr(model.storeCustomer.spendTimes);
    _lblSpendMax.text = kMeUnNilStr(model.storeCustomer.spendMax);
    _lblSpendAmount.text = kMeUnNilStr(model.storeCustomer.spendAmount);
    _lblNewsDealTimes.text = kMeUnNilStr(model.storeCustomer.spendTimes);
    _lblNewsDealAmount.text = kMeUnNilStr(model.storeCustomer.spendTimes);
    
    _lblAccessTimesByMouthWeb.text = kMeUnNilStr(model.storeCustomer.AccessTimesByMouth.small_software);
     _lblAccessTimesByMouthApp.text = kMeUnNilStr(model.storeCustomer.AccessTimesByMouth.app);
    
     _lblAccessTimesWeb.text = kMeUnNilStr(model.storeCustomer.AccessTimes.small_software);
     _lblAccessTimesApp.text = kMeUnNilStr(model.storeCustomer.AccessTimes.app);
    
    
    _lblAgeFrameworkOne.text = kMeUnNilStr(model.storeCustomer.ageFramework.one);
    _lblAgeFrameworkTwo.text =kMeUnNilStr(model.storeCustomer.ageFramework.two);
    _lblAgeFrameworkThree.text =kMeUnNilStr(model.storeCustomer.ageFramework.three);
    _lblAgeFrameworkFive.text =kMeUnNilStr(model.storeCustomer.ageFramework.five);
    
    
    _lblageCostOne.text= kMeUnNilStr(model.storeCustomer.ageCost.one);
    _lblageCostTwo.text= kMeUnNilStr(model.storeCustomer.ageCost.two);
    _lblageCostThree.text= kMeUnNilStr(model.storeCustomer.ageCost.three);
    _lblageCostFive.text= kMeUnNilStr(model.storeCustomer.ageCost.five);
    
    
    _lblageageAverageCostOne.text = kMeUnNilStr(model.storeCustomer.ageAverageCost.one);
    _lblageageAverageCostTwo.text = kMeUnNilStr(model.storeCustomer.ageAverageCost.one);
    _lblageageAverageCostThree.text = kMeUnNilStr(model.storeCustomer.ageAverageCost.one);
    _lblageageAverageCostFive.text = kMeUnNilStr(model.storeCustomer.ageAverageCost.one);
    
    _lblnewsAgeOne.text = kMeUnNilStr(model.storeCustomer.newsAge.one);
    _lblnewsAgeTwo.text = kMeUnNilStr(model.storeCustomer.newsAge.one);
    _lblnewsAgeThree.text = kMeUnNilStr(model.storeCustomer.newsAge.one);
    _lblnewsAgeFive.text = kMeUnNilStr(model.storeCustomer.newsAge.one);
    
    
    _lblageAccessAgeOne.text =kMeUnNilStr(model.storeCustomer.ageAccess.small_software.one);
    _lblageAccessAgeTwo.text =kMeUnNilStr(model.storeCustomer.ageAccess.small_software.two);
    _lblageAccessAgeThree.text =kMeUnNilStr(model.storeCustomer.ageAccess.small_software.three);
    _lblageAccessAgeFive.text =kMeUnNilStr(model.storeCustomer.ageAccess.small_software.five);
    
    _lblageAccessAgeOneAPP.text =kMeUnNilStr(model.storeCustomer.ageAccess.app.one);
    _lblageAccessAgeTwoAPP.text =kMeUnNilStr(model.storeCustomer.ageAccess.app.two);
    _lblageAccessAgeThreeApp.text =kMeUnNilStr(model.storeCustomer.ageAccess.app.three);
    _lblageAccessAgeFiveApp.text =kMeUnNilStr(model.storeCustomer.ageAccess.app.five);

}

+(CGFloat)getViewHeightWithModel:(MEBDataDealModel *)model{
    CGFloat height = 1394-128;
    height+=[MEBDataDealStructView getViewWithArr:kMeUnArr(model.storeCustomer.GoodsNum)];
    return height;
}

@end
