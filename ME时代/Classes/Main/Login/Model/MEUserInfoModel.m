//
//  MEUserInfoModel.m
//  ME时代
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MEUserInfoModel.h"
#import "AppDelegate.h"
#import "JPUSHService.h"

static NSString *kUserInfoKey = @"kUserInfo";
static MEUserInfoModel *shareUser;

@implementation MEUserInfoModel

//- (void)setUnionid:(NSString *)unionid{
//    _unionid = unionid;
//    [[NSUserDefaults standardUserDefaults]setObject:kMeUnNilStr(unionid) forKey:kTokenKey];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//}

- (void)setToken:(NSString *)token{
    _token = token;
    [[NSUserDefaults standardUserDefaults]setObject:kMeUnNilStr(token) forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (MEUserInfoModel *)shareUser{
    if (!shareUser) {
        shareUser = [MEUserInfoModel getObjctForKey:kUserInfoKey];
        if (!shareUser) {
            shareUser = [[MEUserInfoModel alloc]init];
        }
    }
    return shareUser;
}

+ (void)logout{
    [MEUserInfoModel removeCodingForKey:kUserInfoKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kcheckFirstBuy];
    [[NSUserDefaults standardUserDefaults] synchronize];
    shareUser = nil;
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //融云退出登录
    [[RCIM sharedRCIM]disconnect];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        } seq:0];
    });
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.unMessageCount=0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    kNoticeUserLogout
}

- (void)setterWithDict:(NSDictionary *)dict{
    if ([dict isKindOfClass:[NSDictionary class]]) {
        [self mj_setKeyValues:dict];
    }
}

#pragma mark - About Save

- (void)save{
    [self writeObjectForKey:kUserInfoKey];
}

- (void)removeFromLocalData{
    [MEUserInfoModel removeCodingForKey:kUserInfoKey];
    shareUser = nil;
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)isLogin{
    if(kCurrentUser == nil){
        return FALSE;
    }else{
        if(kCurrentUser.token.length <=0 || kCurrentUser.token == nil){
            return FALSE;
        }else{
            return TRUE;
        }
    }
}

//#warning -- test
//#ifdef TestVersion
//- (NSString *)rongcloud_token{
//    return @"Sm5U9U4fdQcH7ZO77udmz46MxlOmTVqYSkXvJATWBY/vIsRP/etXQD70+BCSSUcbWKZFrAOQc0JYPjvCxEk9Gw==";
//}
//#endif

//KaaoSYS0rAXs3xrNAU8mGbEZ9gxWI5776r2SqF+uTUwqDiPZFa5O0mZpKB1oSfLajHfDg+RAbbI7Kpyo4SMwxw==
@end
