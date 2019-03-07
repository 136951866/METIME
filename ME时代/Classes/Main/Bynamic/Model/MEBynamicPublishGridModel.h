//
//  MEBynamicPublishGridModel.h
//  ME时代
//
//  Created by hank on 2019/3/7.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBaseModel.h"
#import "MEBynamicPublishGridModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MEBynamicPublishGridModel : MEBaseModel


@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, strong) UIImage *image;

//选中的时候用的


+ (MEBynamicPublishGridModel*)modelWithImage:(UIImage *)image isAdd:(BOOL)isAdd;

@end

NS_ASSUME_NONNULL_END
