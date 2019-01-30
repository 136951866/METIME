//
//  AppDelegate.m
//  ME时代
//
//  Created by hank on 2018/9/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "AppDelegate.h"
#import "METabBarVC.h"
#import "MERCConversationListVC.h"
#import <UserNotifications/UserNotifications.h>
#import "METabBarVC.h"
#import "MELoginVC.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "MENavigationVC.h"
#import "METhridProductDetailsVC.h"
#import "MEMyOrderDetailVC.h"

#import "MEGuideVC.h"
#import "MEAppointmentDetailVC.h"

@interface AppDelegate ()<WXApiDelegate,RCIMConnectionStatusDelegate,UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>
    
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MECommonTool initAppSomeThing];

#pragma mark - init ronyun sdk
    [[RCIM sharedRCIM] initWithAppKey:RONGYUNAppKey];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [RCIM sharedRCIM].enableTypingStatus = YES;
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[@"ConversationType_PRIVATE"];
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
#pragma mark 融云推送
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                
            } else {
                //点击不允许
                
            }
        }];
    }
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        
    }
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    if([MEUserInfoModel isLogin]){
        NSLog(@"token//  %@  /n //   %@ //",kCurrentUser.token,kCurrentUser.uid);
        NSString *nameStr = (kCurrentUser.name.length > 0 && ![kCurrentUser.name isKindOfClass:[NSNull class]]) ? kCurrentUser.name : kCurrentUser.uid;
        if( ![kCurrentUser.rongcloud_token isKindOfClass:[NSNull class]] && kCurrentUser.rongcloud_token.length > 0){
            [[RCIM sharedRCIM] connectWithToken:kCurrentUser.rongcloud_token success:^(NSString *userId) {
                self.unMessageCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                                @(ConversationType_PRIVATE),
                                                                                      ]];
                kNoticeReloadkUnMessage
                RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:kCurrentUser.uid name:nameStr portrait:kMeUnNilStr(kCurrentUser.header_pic)];
//                [[RCIM sharedRCIM]  setCurrentUserInfo:user];
//                [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
                [RCIM sharedRCIM].currentUserInfo = user;
                [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[RCIM sharedRCIM] setUserInfoDataSource:self];
                });
                NSLog(@"成功");
            }error:^(RCConnectErrorCode status) {
                NSLog(@"失败");
            }tokenIncorrect:^() {
                // Token 失效的
                NSLog(@"Token 失效");
            }];
        }
    }
#pragma mark - 极光tuis
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JpushAppKey
                          channel:@"App Store"
                 apsForProduction:JpushType
            advertisingIdentifier:advertisingId];
    if([MEUserInfoModel isLogin]){
        //极光alias
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JPUSHService setAlias:kMeUnNilStr(kCurrentUser.uid) completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:0];
        });
    }
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    NSString *frist = [[NSUserDefaults standardUserDefaults] objectForKey:kMEAppVersion];
    if(kMeUnNilStr(frist).length){
        [self.window setRootViewController:[METabBarVC new]];
    }else{
        MEGuideVC *fvc = [[MEGuideVC alloc] init];
        [self.window setRootViewController:fvc];
    }
    [self.window makeKeyAndVisible];
    [MECommonTool newCheckVersion];
    return YES;
}

#pragma mark - 友盟分享的回调
#pragma mark 这里判断是否发起的请求为微信支付



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[UMSocialManager defaultManager] handleOpenURL:url];
    //用WXApi的方法调起微信客户端的支付页面
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    if ([[NSString stringWithFormat:@"%@",url] rangeOfString:[NSString stringWithFormat:@"%@://pay",UMWXAppId]].location != NSNotFound) {
        return  [WXApi handleOpenURL:url delegate:self];
        //不是上面的情况的话，就正常用shareSDK调起相应的分享页面
    }else{
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    NSLog(@"url =%@",url);
#pragma mark 支付宝的回调之后的方法
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果

    }
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
#pragma mark 微信的回调之后的方法
    if ([[NSString stringWithFormat:@"%@",url] rangeOfString:[NSString stringWithFormat:@"%@://pay",UMWXAppId]].location != NSNotFound) {
        return  [WXApi handleOpenURL:url delegate:self];
    }else{
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    return YES;
}

- (void)onResp:(BaseResp*)resp{
    //这里判断回调信息是否为 支付
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
                case WXSuccess:
                //如果支付成功的话，全局发送一个通知，支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:WX_PAY_RESULT object:WXPAY_SUCCESSED];
                break;
            default:
                //如果支付失败的话，全局发送一个通知，支付失败
                [[NSNotificationCenter defaultCenter] postNotificationName:WX_PAY_RESULT object:WXPAY_FAILED];
                NSString *strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"%@",strMsg);
//                kMeAlter(@"提示", strMsg);
                break;
        }
    }
}


#pragma mark - 融云
/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        
        HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:@"您的帐号在别的设备上登录，您被迫下线！请退出重新登录!"];
        alertView.isSupportRotating = YES;
        [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
            [MEUserInfoModel logout];
            [MEWxLoginVC presentLoginVCWithIsShowCancel:NO SuccessHandler:nil failHandler:nil];
        }];
        [alertView show];
        
//        MEAlertView *aler = [[MEAlertView alloc] initWithTitle:@"提示" message:@"您的帐号在别的设备上登录，您被迫下线！请退出重新登录!"];
//        [aler addButtonWithTitle:@"确定" block:^{
//
//        }];
//        [aler show];
    }
}

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

//获取deviceToken方法
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken%@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    NSLog(@"deviceToken%@",token);
#pragma mark 融云推送接收消息
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support app 在前台 10以上
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    /*
     type 1 商品 2.订单详情
     aps =     {
     alert = "ME\U65f6\U4ee3\U6c28\U57fa\U9178\U6d01\U9762\U6155\U65af\Uff08\U90ae\U8d3910\U5143\Uff09";
     badge = 2;
     };
     content =     {
     id = 4;
     type = 2;
     };
     */
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"jpushNotificationCenter willPresentNotification %@",userInfo);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    [self dealJPushActionWithDic:userInfo];
}

// iOS 10 Support app 在后台 10以上
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"jpushNotificationCenter didReceiveNotificationResponse%@",userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    [self dealJPushActionWithDic:userInfo];
}

// 不管app是在前台运行还是在后台运行，系统收到推送时都会调用该方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"didReceiveRemoteNotification fetchCompletionHandler%@",userInfo);
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [self dealJPushActionWithDic:userInfo];
}

// 如果app在前台运行，系统收到推送时会调用该方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required, For systems with less than or equal to iOS 6
    NSLog(@"didReceiveRemoteNotification %@",userInfo);
    [JPUSHService handleRemoteNotification:userInfo];
    [self dealJPushActionWithDic:userInfo];
}

//iOS10以下使用这个方法接收通知
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    // userInfo为远程推送的内容
//    NSLog(@"didReceiveRemoteNotification-----------------%@",userInfo);
////    [UIApplication sharedApplication].applicationIconBadgeNumber +=1;
//}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"willPresentNotification %@",userInfo);
//    [UIApplication sharedApplication].applicationIconBadgeNumber +=1;
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"didReceiveNotificationResponse %@",userInfo);
    [UIApplication sharedApplication].applicationIconBadgeNumber +=1;
    if (![self.window.rootViewController isKindOfClass:[METabBarVC class]]) return;
    // 取到tabbarcontroller
    METabBarVC *tabBarController = (METabBarVC*)self.window.rootViewController;
    tabBarController.selectedIndex = 4;
}

#pragma mark 本地 融云消息未读数

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    RCUserInfo *otherUser = [[RCUserInfo alloc]init];
    if(kMeUnNilStr(userId).length==0){
        otherUser.userId = userId;
        otherUser.portraitUri = @"";
        otherUser.name = userId;
        completion(otherUser);
        return;
    }
    //先获取用户
    [MEPublicNetWorkTool postGetUserGetUserInfoWithUid:userId SuccessBlock:^(ZLRequestResponse *responseObject) {
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                NSDictionary *dic = responseObject.data;
                if([kMeUnDic(dic) count]){
                    NSString *name = kMeUnDic(dic)[@"name"];
                    NSString *header_pic = kMeUnDic(dic)[@"header_pic"];
                    otherUser.userId = userId;
                    otherUser.portraitUri = kMeUnNilStr(header_pic);
                    otherUser.name = kMeUnNilStr(name);
                    completion(otherUser);
                }else{
                    otherUser.userId = userId;
                    otherUser.portraitUri = @"";
                    otherUser.name = userId;
                    completion(otherUser);
                }
            }else{
                otherUser.userId = userId;
                otherUser.portraitUri = @"";
                otherUser.name = userId;
                completion(otherUser);
            }
        }else{
            [MEPublicNetWorkTool postGetCustomerGetUserInfoWithUid:userId SuccessBlock:^(ZLRequestResponse *responseObject) {
                if([responseObject.data isKindOfClass:[NSDictionary class]]){
                    NSDictionary *dic = responseObject.data;
                    if([kMeUnDic(dic) count]){
                        NSString *name = kMeUnDic(dic)[@"name"];
                        NSString *header_pic = kMeUnDic(dic)[@"header_pic"];
                        otherUser.userId = userId;
                        otherUser.portraitUri = kMeUnNilStr(header_pic);
                        otherUser.name = kMeUnNilStr(name);
                        completion(otherUser);
                    }else{
                        otherUser.userId = userId;
                        otherUser.portraitUri = @"";
                        otherUser.name = userId;
                        completion(otherUser);
                    }
                }else{
                    otherUser.userId = userId;
                    otherUser.portraitUri = @"";
                    otherUser.name = userId;
                    completion(otherUser);
                }
            } failure:^(id object) {
                otherUser.userId = userId;
                otherUser.portraitUri = @"";
                otherUser.name = userId;
                completion(otherUser);
            }];
        }
    } failure:^(id object) {
        otherUser.userId = userId;
        otherUser.portraitUri = @"";
        otherUser.name = userId;
        completion(otherUser);
    }];
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    if([MEUserInfoModel isLogin]){
        RCMessage *message = notification.object;
        if (message.messageDirection == MessageDirection_RECEIVE && [[message.content class] persistentFlag] & MessagePersistent_ISCOUNTED) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].applicationIconBadgeNumber +=1;
            });
        }
        self.unMessageCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                              @(ConversationType_PRIVATE),
                                                                              ]];
        
        NSLog(@"%@",@(self.unMessageCount));
        kNoticeReloadkUnMessage
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if([MEUserInfoModel isLogin] && status != ConnectionStatus_SignUp){
        self.unMessageCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                              @(ConversationType_PRIVATE),
                                                                              ]];
//        application.applicationIconBadgeNumber =   self.unMessageCount;
    }else{
        application.applicationIconBadgeNumber =   0;
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if([MEUserInfoModel isLogin]){
        self.unMessageCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                              @(ConversationType_PRIVATE),
                                                                              ]];
        application.applicationIconBadgeNumber =   self.unMessageCount;
    }else{
        application.applicationIconBadgeNumber =   0;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    kNoticeUnNoticeMessage
    [MECommonTool getUIPasteboardContent];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}


#pragma mark - JPushAction

- (void)dealJPushActionWithDic:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
    kNoticeUnNoticeMessage
    NSDictionary *dict =  kMeUnDic(userInfo)[@"aps"];
    if([dict count]){
        NSString *messageStr = dict[@"alert"];
        NSDictionary *contentDic =  kMeUnDic(userInfo)[@"content"];
        NSString *TypeId = contentDic[@"id"];
        NSString *type = contentDic[@"type"];
        NSInteger msg_id = [contentDic[@"msg_id"] integerValue];
        if(type.length && ![type isEqualToString:@"4"] &&![type isEqualToString:@"5"]){
            //1跳商品  2跳订单详情 3更新 4B店铺访问 5C店铺访问
            HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:messageStr];
            alertView.isSupportRotating = YES;
            [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
            }];
            [alertView addButtonWithTitle:@"立即前往" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
                if (![self.window.rootViewController isKindOfClass:[METabBarVC class]]) return;
                [MEPublicNetWorkTool getUserReadedNoticeWithNoticeId:msg_id SuccessBlock:^(ZLRequestResponse *responseObject) {
                    kNoticeUnNoticeMessage
                } failure:nil];
                // 取到tabbarcontroller
                METabBarVC *tabBarController = ( METabBarVC*)self.window.rootViewController;
                // 取到navigationcontroller
                MENavigationVC *nav = (MENavigationVC *)tabBarController.selectedViewController;
                UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
                if([type isEqualToString:@"1"]){
                    METhridProductDetailsVC *dvc = [[METhridProductDetailsVC alloc]initWithId:[TypeId integerValue]];
                    [baseVC.navigationController pushViewController:dvc animated:YES];
                }else if ([type isEqualToString:@"2"]){
                    MEMyOrderDetailVC *dvc = [[MEMyOrderDetailVC alloc]initWithOrderGoodsSn:TypeId];
                    [baseVC.navigationController pushViewController:dvc animated:YES];
                }else if([type isEqualToString:@"3"]){
                    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",kMEAppId];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                }else if ([type isEqualToString:@"7"]){
                    MEAppointmentDetailVC *dvc = [[MEAppointmentDetailVC alloc]initWithReserve_sn:kMeUnNilStr(TypeId) userType:MEClientBTypeStyle];
                    [baseVC.navigationController pushViewController:dvc animated:YES];
                }else{
                    
                }
            }];
            [alertView show];
            
            /*
            MEAlertView *aler = [[MEAlertView alloc] initWithTitle:@"标题" message:messageStr];
            [aler addButtonWithTitle:@"立即前往" block:^{
                if (![self.window.rootViewController isKindOfClass:[METabBarVC class]]) return;
                [MEPublicNetWorkTool getUserReadedNoticeWithNoticeId:msg_id SuccessBlock:^(ZLRequestResponse *responseObject) {
                    kNoticeUnNoticeMessage
                } failure:nil];
                // 取到tabbarcontroller
                METabBarVC *tabBarController = ( METabBarVC*)self.window.rootViewController;
                // 取到navigationcontroller
                MENavigationVC *nav = (MENavigationVC *)tabBarController.selectedViewController;
                UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
                if([type isEqualToString:@"1"]){
                    MEProductDetailsVC *dvc = [[MEProductDetailsVC alloc]initWithId:[TypeId integerValue]];
                    [baseVC.navigationController pushViewController:dvc animated:YES];
                }else if ([type isEqualToString:@"2"]){
                    MEMyOrderDetailVC *dvc = [[MEMyOrderDetailVC alloc]initWithOrderGoodsSn:TypeId];
                    [baseVC.navigationController pushViewController:dvc animated:YES];
                }else if([type isEqualToString:@"3"]){
                    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",kMEAppId];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                }else{
                    
                }
            }];
            [aler addButtonWithTitle:@"取消" block:nil];
            [aler show];*/
        }
    }
}



@end
