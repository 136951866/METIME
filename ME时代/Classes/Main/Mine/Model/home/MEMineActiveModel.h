//
//  MEMineActiveModel.h
//  ME时代
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MEMineActiveLeveModel : MEBaseModel

@property (nonatomic, strong) NSString * level;
@property (nonatomic, strong) NSString * reward;
@property (nonatomic, strong) NSString * share_number;
@property (nonatomic, strong) NSString * type;

@end

@interface MEMineActiveModel : MEBaseModel

@property (nonatomic, strong) NSString * activity_name;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) MEMineActiveLeveModel *doing;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, strong) NSString * redbag_id;
@property (nonatomic, strong) NSString * share_number;
@property (nonatomic, strong) NSArray * complete;

@end

NS_ASSUME_NONNULL_END
