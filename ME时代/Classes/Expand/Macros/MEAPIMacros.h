//
//  MEAPIMacros.h
//  ME时代
//
//  Created by hank on 2018/9/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#ifndef MEAPIMacros_h
#define MEAPIMacros_h

#warning -mustNotes 上线一定要注释

#define TestVersion




//域名 develop
#ifdef TestVersion
//#define BASEIP @"https://test.meshidai.com/api/"
#define BASEIP @"https://develop.meshidai.com/api/"
#else
#define BASEIP @"https://msd.meshidai.com/api/"
#endif

#define kGetApiWithUrl(url) [BASEIP stringByAppendingString:url]

#pragma makr - TEST
#define MEIPgetTokenByFour @"common/user/getTokenByFour"

/*********************************************/
//网络状态码

#define kNetSuccess @"200"
#define kNetTokenInvalid @"401"
#define kNetError @"503"
#define kNetInvateCode @"502"

/*********************************************/


/*********************************************/
#pragma makr - clerk

//店员列表
#define MEIPcommonMyClerk @"common/user/myClerk"
//会员列表
#define MEIPcommonMemberList @"common/user/memberList"
//删除店员
#define MEIPcommonClerkToMember @"common/user/clerkToMember"
//会员升级为店员
#define MEIPcommonMemberToClerk @"common/user/memberToClerk"
/*********************************************/



/*********************************************/
#pragma makr - AD

//广告banner
#define MEIPcommonAdGetAd @"common/ad/getAd"
//获取Banner
#define MEIPcommonGetBanner @"common/ad/getBanner"
/*********************************************/

/*********************************************/
#pragma makr - home
//获取首面的背景和banner
#define MEIPcommonGetActivity @"common/activity/getActivity"
//获取首页样式
#define MEIPcommonGetMystyle @"common/mystyle/getMystyle"
//获取通知消息
#define MEIPcommonGetMessage @"common/message/getMessage"
/*********************************************/



/*********************************************/
#pragma makr - articel
//文章分类列表
#define MEIPcommonGetArticleClass @"common/article/getArticleClass"
//获取文章列表
#define MEIPcommonGetArticle @"common/article/getArticle"
//文章详情
#define MEIPcommonFindArticle @"common/article/findArticle"
//分享文章
#define MEIPcommonShareAricel @"common/article/shareArticle"
//文章统计
#define MEIPcommonCountArticlel @"common/article/countArticle"
//访问统计
#define MEIPcommonGetAccess @"common/article/getAccess"
//获取客户
#define MEIPcommonGetAccessUser @"common/article/getAccessUser"
//传播路径
#define MEIPcommonGetSpreadPath @"common/article/spreadPath"
//设为意向客户
#define MEIPcommonSetIntentioUser @"common/article/setIntentioUser"
//访问用户详情
#define MEIPcommonVistorUserInfo @"common/article/getSpreadUser"
/*********************************************/



/*********************************************/
#pragma makr - poster

//获取海报分类
#define MEIPcommonGetPostersClass @"common/posters/getPostersClass"
//根据分类获取海报列表
#define MEIPcommonFindPostersClass @"common/posters/findPostersClass"
//分享海报
#define MEIPcommonSharePoster @"common/posters/sharePoster"
//获取分享海报
#define MEIPcommonGetSharePoster @"common/posters/getSharePoster"
//删除海报
#define MEIPcommonDelSharePosters @"common/posters/delSharePosters"
/*********************************************/


/*********************************************/
#pragma makr - member

//获取超级会员数据
#define MEIPcommonSupportMember @"common/goods/supportMember"
//获取兑换商品
#define MEIPcommonFindManyGoods @"common/goods/findManyGoods"

/*********************************************/




/*********************************************/
#pragma makr - Stroe

//门店列表
#define MEIPcommonStoreStoreList @"common/store/getStoreList"
//门店祥情
#define MEIPcommonStoreGetStore @"common/store/getStore"
//服务详情
#define MEIPcommonserviceDetail @"common/goods/serviceDetail"
//提及服务
#define MEIPcommonCreateReserve @"common/reserve/createReserve"

#define MEIPcommonStoreSelectStore @"common/store/selectStore"
/*********************************************/



/*********************************************/
#pragma makr - Custom

//获取客服id
#define MEIPAppUserGetCustomer @"app/user/getCustomer"
//获取客服信息
#define MEIPCustomerGetUserInfo @"customer/auth/getCustomerInfo"
//获取用户信息
#define MEIPUserGetUserInfo @"common/user/getUser"
/*********************************************/




/*********************************************/
#pragma makr - Goods

//商品列表
#define MEIPcommonGoodsGetGoodsList @"common/goods/getGoodsList"
//商品详情
#define MEIPcommonGoodsGoodsDetail @"common/goods/goodsDetail"
//获取库存和价格
#define MEIPcommonGoodsGetPriceAndStock @"common/goods/getPriceAndStock"
//首页商品列表
#define MEIPcommonGoodsGoodsType @"common/goods/goodsType"
//详情推荐
#define MEIPcommonGoodsRecommend @"common/goods/getRecommend"
//获取980活动祥情
#define MEIPcommonGoodsComboDetail @"common/goods/goodsComboDetail"
//app分享
#define MEIPWechatAuthShare @"wechat/auth/index"
//app文章分享
#define MEIPWechatAuthArticelShare @"wechat/auth/article"
//分类
#define MEIPGoodsGetCategory @"common/goods/getCategory"
//抢购
#define MEIPGoodsRush @"common/ad/getPopUp"
//获取推荐到首次购买活动商品
#define MEIPRecommendProduct @"common/goods/getRecommendProduct"
/*********************************************/





/*********************************************/
#pragma makr - UserCentre
//一键已读
#define MEIPcommonAllreadedNotice @"common/message/allRead"
//已读消息
#define MEIPcommonreadedNotice @"common/message/readMsg"
//获取未读的推送信息
#define MEIPcommonUnreadNotice @"common/message/getJpush"
//获取通知列表
#define MEIPcommonNotice @"common/message/getJpushList"
//获取个人中心的数据
#define MEIPcommonUserUserCentre @"common/user/userCentre"
//获取商家分销中心
#define MEIPcommonAdminDistribution @"common/user/adminDistribution"
//获取用户全部订单
#define MEIPcommonUserGetOrderList @"common/user/getOrderList"
//获取订单详情
#define MEIPcommonUserGetOrderDetail @"common/user/getOrderSnDetail"
//分销中心数据
#define MEIPcommonUserDistribution @"common/user/distribution"
//获取分销订单信息
#define MEIPcommonUserGetDistributionOrder @"common/user/getDistributionOrder"
//获取团队 C
#define MEIPcommonUserGetTeam @"common/user/getTeam"
//获取C端以上用户列表 B
#define MEIPcommonUserGetAdminTeam @"common/user/getAdminTeam"
//获取C端以上用户的订单明细 B
#define MEIPcommonUserGetAdminOrder @"common/user/getAdminOrder"
//获取C端二维码
#define MEIPcommonUserGetCode @"common/user/getCode"
//第二版 获取首页数据
//#define MEIPGetHomePageData @"homePageData"
//判断是否完成首单
#define MEIPcommonCheckFirstBuy @"common/user/checkFirstBuy"
/*********************************************/





/*********************************************/
#pragma makr - Order

//用户支付
#define MEIPcommonOrderPayOrder @"common/order/payOrder"
//订单轮询
#define MEIPcommonOrderGetOrderStatus @"common/order/getOrderStatus"
//普通下单
#define MEIPcommonOrderCreateOrder @"common/order/createOrder"
//生成兑换订单
#define MEIPcommonOrderConvertOrde @"common/order/convertOrder"
//购物车下单
#define MEIPcommonOrderCartOrder @"common/order/cartOrder"
//取消订单
#define MEIPcommonOrderCancelOrder @"common/order/cancelOrder"
//支付订单
#define MEIPCommonOrderPayOrder @"common/order/payOrder"
//获取物流
#define MEIPCommongetLogist @""

/*********************************************/





/*********************************************/
#pragma makr - ShopCart

//购物车列表
#define MEIPcommonCartCartGoodsList @"common/cart/cartGoodsList"
//加入购物车
#define MEIPcommonCartAddCart @"common/cart/addCart"
//删除购物车
#define MEIPcommonCartDeleteCart @"common/cart/deleteCart"
//购物车数量修改
#define MEIPcommonCartEditCartNum @"common/cart/editCartNum"
/*********************************************/


/*********************************************/
#pragma makr - AppointMent

//查看自己的预约订单
#define MEIPcommonGetReserveList @"common/reserve/getReserveList"
//取消预约
#define MEIPcommonDeleteReserve @"common/reserve/deleteReserve"
//获取预约详情
#define MEIPcommonUserGetAppointDetail @"common/reserve/reserveDetail"


/*********************************************/





/*********************************************/
#pragma makr - Address

//收货地址列表
#define MEIPcommonAddressAddressList @"common/address/addressList"
//新增收货地址 warn
#define MEIPcommonAddressAddAddress @"common/address/addAddress"
//获取某个地址详情
#define MEIPcommonAddressGetOneAddress @"common/address/getOneAddress"
//获取默认地址
#define MEIPcommonAddressGetdefaultAddress @"common/address/defaultAddress"

//编辑收货地址
#define MEIPcommonAddressEditAddress @"common/address/editAddress"
//删除地址
#define MEIPcommonAddressDelAddres @"common/address/delAddress"
//搜索产品
#define MEIPcommonFindGoods @"common/goods/findGoods"
/*********************************************/

/*********************************************/
#pragma makr - aboutUser

//收货地址列表
#define MEIPAppAuthLogin @"app/auth/login"
//app获取验证码
#define MEIPAppGetCodel @"app/auth/getMesCode"
//手机号登录
#define MEIPLoginByPhone @"app/auth/loginByPhone"
//wep绑定手机号码
#define MEIPaddPhone @"weapp/user/addPhone"
//修改手机号
#define MEIPeditPhone @"app/user/editPhone"

#define MEIPAddShare @"app/user/addShare"

#define MEIPShare [NSString stringWithFormat:@"%@?code=%@",kGetApiWithUrl(MEIPWechatAuthShare),kMeUnNilStr(kCurrentUser.uid)]
#define MEIPArticelShare [NSString stringWithFormat:@"%@?code=%@&pid=0&article_id=",kGetApiWithUrl(MEIPWechatAuthArticelShare),kMeUnNilStr(kCurrentUser.uid)]

//获取赠送小程序的到期时间
#define MEIPExpMiniprogramAt @"common/user/getExpMiniprogramAt"
//获取app版本
#define MEIPGetAPPVersion @"getAppVersion"
//新的获取app更新版本
#define MENewIPGetAPPVersion @"checkAppVersion"
/*********************************************/

#endif /* MEAPIMacros_h */
