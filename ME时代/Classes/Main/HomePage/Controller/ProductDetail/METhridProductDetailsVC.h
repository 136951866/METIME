//
//  METhridProductDetailsVC.h
//  ME时代
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBaseVC.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, METhridProductDetailsVCType) {
    METhridProductDetailsVCNormalType,
    METhridProductDetailsVCNoticeType,
    METhridProductDetailsVCRudeType,
};
@interface METhridProductDetailsVC : MEBaseVC

- (instancetype)initWithId:(NSInteger)detailsId;
//来自好友分享
@property(nonatomic, copy) NSString *uid;
@property (nonatomic, assign) BOOL isGift;
@property (nonatomic, assign) METhridProductDetailsVCType type;

@end

NS_ASSUME_NONNULL_END
