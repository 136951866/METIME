//
//  MEBynamicHomeModel.h
//  ME时代
//
//  Created by hank on 2019/1/24.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MEBynamicHomepraiseModel : MEBaseModel

@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * member_id;
@property (nonatomic, strong) NSString * nick_name;

@end

@interface MEBynamicHomecommentModel : MEBaseModel

@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * member_id;
@property (nonatomic, strong) NSString * nick_name;
@property (nonatomic, strong) NSString * content;

@end

@interface MEBynamicHomeModel : MEBaseModel

@property (nonatomic, strong) NSArray * comment;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * deletedAt;
@property (nonatomic, assign) NSString *idField;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSArray * praise;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL praise_over;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSString * header_pic;
@end

NS_ASSUME_NONNULL_END
