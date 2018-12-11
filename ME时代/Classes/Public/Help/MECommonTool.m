//
//  MECommonTool.m
//  ME时代
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "MECommonTool.h"
#import <IQKeyboardManager.h>
#import "MENavigationVC.h"
#import <MapKit/MapKit.h>
#import "ALAssetsLibrary+MECategory.h"
#import "MEExitVC.h"


@implementation MECommonTool

+ (void)initAppSomeThing{
    //适配ios11 tbaleview reloaddata cell跳动的问题
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [UMConfigure initWithAppkey:MobAppkey channel:@"App Store"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:UMWXAppId appSecret:UMWXAppSecret redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:UMWXAppId appSecret:UMWXAppSecret redirectURL:nil];
    
    [WXApi registerApp:UMWXAppId];
    
//    [[MELocationTool sharedHander] startLocation];
    [[MELocationHelper sharedHander] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
    } failure:^{
    }];
    if([MEUserInfoModel isLogin]){
        [MEPublicNetWorkTool getUserCheckFirstBuyWithSuccessBlock:nil failure:nil];
    }
}

+ (id)getVCWithClassWtihClassName:(Class)targetClass targetResponderView:(UIResponder *)targetResponder{
    do{
        if([targetResponder isKindOfClass:targetClass]){
            return targetResponder;
        }
        targetResponder = [targetResponder nextResponder];
    }while (targetResponder!=nil);
    return nil;
}

+ (UIViewController *)getClassWtihClassName:(Class)aClass targetVC:(UIViewController *)target{
    NSArray *array=target.navigationController.viewControllers;
    for (UIViewController *vc in array){
        if([vc isKindOfClass:aClass]){
            return vc;
        }
    }
    return nil;
}

#pragma mark - About Verify

+ (BOOL)isValidPhoneNum:(NSString *)strPhoneNum{
    NSString *Regex = @"^(13[0-9]|14[579]|15[012356789]|16[6]|17[0135678]|18[0-9]|19[89])[0-9]{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:strPhoneNum];
}

+ (UIImage*) createImageWithColor:(UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (void)showMessage:(NSString *)text view:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (text.length > 10) {
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = text;
        hud.detailsLabel.font = hud.label.font;
    }else{
        hud.label.text = text;
    }
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)SHOWHUDWITHHUD:(MBProgressHUD *)HUD test:(NSString *)text{
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.userInteractionEnabled = YES;
    if ([text isKindOfClass:[NSString class]]) {
        HUD.label.text = text;
    }
    HUD.removeFromSuperViewOnHide = YES;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.0];
}

+ (void)showWithTellPhone:(NSString *)Number inView:(UIView *)view{
    UIWebView *callWebview = [[UIWebView alloc] init];
    NSString *strPhone = [NSString stringWithFormat:@"tel:%@",Number];
    NSURL *telURL =[NSURL URLWithString:[strPhone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [view addSubview:callWebview];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    MENavigationVC *nav = [[MENavigationVC alloc]initWithRootViewController:viewControllerToPresent];
    UIViewController *rootVc  = [kMeCurrentWindow rootViewController];
    while (rootVc.presentedViewController) {
        rootVc = rootVc.presentedViewController;
    }
    [rootVc presentViewController:nav animated:flag completion:completion];
}

+ (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion{
    UIViewController *rootVc = [kMeCurrentWindow rootViewController];
    while (rootVc.presentedViewController) {
        rootVc = rootVc.presentedViewController;
    }
    [rootVc dismissViewControllerAnimated:flag completion:completion];
}


+ (BOOL)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [df setDateFormat:@"Y-M-d HH:mm"];
    NSDate *dt1 = [[NSDate alloc]init];
    NSDate *dt2 = [[NSDate alloc]init];
    dt1 = [df dateFromString:oneDayStr];
    dt2 = [df dateFromString:anotherDayStr];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result){
        case NSOrderedAscending:
            return NO;
            break;
        case NSOrderedDescending:
            return YES;
        case NSOrderedSame:
            return NO;
        default:
            return NO;
    }
}

+(NSString*)getCurrentTimesWithFormat:(NSString *)str{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:str];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+ (void)doNavigationWithEndLocation:(NSArray *)endLocation{
    NSMutableArray *maps = [NSMutableArray array];
    //苹果原生地图-苹果原生地图方法和其他不一样
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=北京&mode=driving&coord_type=gcj02",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=2",@"导航功能",@"nav123456",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@,%@&directionsmode=driving",@"导航测试",@"nav123456",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=终点&coord_type=1&policy=0",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    NSInteger index = maps.count;
    
    NSMutableArray *arrTitles = [NSMutableArray array];
    for (int i = 0; i < index; i++) {
        NSString * title = maps[i][@"title"];
        [arrTitles addObject:title];
    }
    
    MECustomActionSheet *sheet = [[MECustomActionSheet alloc]initWithTitles:arrTitles];
    sheet.blockBtnTapHandle = ^(NSInteger index){
        if(!index){
            [self navAppleMapnavAppleMapWithArray:endLocation];
        }else{
            NSString *urlString = maps[index][@"url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
//        switch (index) {
//            case 0:{
//                 [self navAppleMapnavAppleMapWithArray:endLocation];
//            }
//                break;
//            case 1:{
//                NSString *urlString = maps[index+1][@"url"];
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//            }
//                break;
//            default:
//                break;
//        }
    };
    [sheet show]; 
}

//苹果地图
+ (void)navAppleMapnavAppleMapWithArray:(NSArray*) array
{
    float lat = [NSString stringWithFormat:@"%@", array[0]].floatValue;
    float lon = [NSString stringWithFormat:@"%@", array[1]].floatValue;
    //终点坐标
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(lat, lon);
    
    //用户位置
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    //终点位置
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
    NSArray *items = @[currentLoc,toLocation];
    //第一个
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    //第二个，都可以用
    //    NSDictionary * dic = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
    //                           MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]};
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

+ (void)saveImg:(UIImage *)img{
    if (![img isKindOfClass:[UIImage class]]) {
        return;
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:kMeCurrentWindow animated:YES];
    HUD.label.text = @"正在保存";
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library saveImage:img toAlbum:kMEAppName withCompletionBlock:^(NSError *error) {
        NSLog(@"%@",[error description]);
        if (!error) {
            [MEShowViewTool SHOWHUDWITHHUD:HUD test:@"已保存到本地相册"];
        }else{
            [HUD hideAnimated:YES];
            [[[UIAlertView alloc]initWithTitle:@"无法保存" message:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-照片”选项中，允许%@访问你的照片",kMEAppName] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        }
    }];
    return;
}

+ (void)newCheckVersion{
    [MEPublicNetWorkTool postGetNewAPPVersionWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        NSInteger stat = [responseObject.data integerValue];
        NSString *msg = kMeUnNilStr(responseObject.message);
        switch (stat) {
            case 0:{
                    
            }
                break;
            case 1:
            {
                HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:msg];
                alertView.isSupportRotating = YES;
                [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
                }];
                [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
                    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",kMEAppId];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                }];
                [alertView show];
            }
                break;
            case 2:
            {
                HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:msg];
                alertView.isSupportRotating = YES;
                [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
                    MEExitVC *vc = [[MEExitVC alloc]init];
                    [self presentViewController:vc animated:YES completion:nil];
                }];
                
                [alertView show];
            }
                break;
            default:
                break;
        }
    } failure:^(id object) {
        
    }];
}

+ (void)checkVersion{
    [MEPublicNetWorkTool postGetAPPVersionWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        if([responseObject.data isKindOfClass:[NSArray class]]){
            NSArray *arr = responseObject.data;
            NSLog(@"%@",arr);
            if(arr.count>1){
                NSDictionary *dic = arr[1];
                NSLog(@"%@",dic);
                NSString *key = [dic valueForKey:@"key"];
                if([key isEqualToString:@"ios_version_check"]){
                    NSString *version = [dic valueForKey:@"value"];
                    NSLog(@"%@",version);
                    if(kMeUnNilStr(version).length){
                        NSArray * arrayV = [version componentsSeparatedByString:@"."];
                        NSArray * arrayCV = [kMEAppVersion componentsSeparatedByString:@"."];
                        if(arrayV.count==3 && arrayCV.count==3){
                            NSInteger vnumber = [arrayV[0] integerValue]*100 + [arrayV[1] integerValue]*10 + [arrayV[2] integerValue];
                            NSInteger vcnumber = [arrayCV[0] integerValue]*100 + [arrayCV[1] integerValue]*10 + [arrayCV[2] integerValue];
                            //低于最低版本
                            if(vnumber>vcnumber){
                                MEAlertView *aler = [[MEAlertView alloc] initWithTitle:@"当前版本不可用" message:@"请升级"];
                                [aler addButtonWithTitle:@"确定" block:^{
                                    MEExitVC *vc = [[MEExitVC alloc]init];
                                    [self presentViewController:vc animated:YES completion:nil];
//                                    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",kMEAppId];
//                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                                }];
//                                [aler addButtonWithTitle:@"退出" block:^{
//                                    MEExitVC *vc = [[MEExitVC alloc]init];
//                                    [self presentViewController:vc animated:YES completion:nil];
//                                }];
                                [aler show];
                            }else{
                                
                            }
                        }
                    }
                }
            }
        }
    } failure:^(id object) {
      
    }];
    

}

//+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    [MBProgressHUD hideHUDForView:kMeCurrentWindow animated:YES];
//    if (error != NULL){
//        [[[UIAlertView alloc]initWithTitle:@"无法保存" message:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-照片”选项中，允许%@访问你的照片",kMeCurrentWindow] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
//    }
//    else{
//        [MEShowViewTool showMessage:@"已保存到手机相册" view:kMeCurrentWindow];
//    }
//}

//+ (void)checkVersion{
//    NSString * url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",kMEAppId];
//    // 获取本地版本号
//    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//    [THTTPManager orgialGetWithUrlStr:url parameter:@{} success:^(NSDictionary *dic) {
//        NSArray * results = kMeUnDic(dic)[@"results"];
//        if(kMeUnArr(results).count!=0){
//            if (results && results.count>0)
//            {
//                NSDictionary * dic = results.firstObject;
//                NSString * lineVersion = dic[@"version"];//版本号
//                NSString * releaseNotes = dic[@"releaseNotes"];//更新说明
//                //NSString * trackViewUrl = dic[@"trackViewUrl"];//链接
//                //把版本号转换成数值
//                NSArray * array1 = [currentVersion componentsSeparatedByString:@"."];
//                NSInteger currentVersionInt = 0;
//                if (array1.count == 3)//默认版本号1.0.0类型
//                {
//                    currentVersionInt = [array1[0] integerValue]*100 + [array1[1] integerValue]*10 + [array1[2] integerValue];
//                }
//                NSArray * array2 = [lineVersion componentsSeparatedByString:@"."];
//                NSInteger lineVersionInt = 0;
//                if (array2.count == 3)
//                {
//                    lineVersionInt = [array2[0] integerValue]*100 + [array2[1] integerValue]*10 + [array2[2] integerValue];
//                }
//                if (lineVersionInt > currentVersionInt)//线上版本大于本地版本
//                {
//                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本%@",lineVersion] message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//                    UIAlertAction * update = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        //跳转到App Store
//                        NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",kMEAppId];
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
//                    }];
//                    [alert addAction:ok];
//                    [alert addAction:update];
//                    [self presentViewController:alert animated:YES completion:nil];
//                }
//            }
//        }
//    } failure:^(id object) {
//
//    }];
//}

@end
