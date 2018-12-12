//
//  MEEuemMacros.h
//  ME时代
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#ifndef MEEuemMacros_h
#define MEEuemMacros_h


#pragma mark - 界面相关枚举

//首页
typedef enum : NSUInteger {
    MEHomeADADTYPE = 1,
    MEHomeADPRODUCTTYPE = 2,
    MEHomeADSERVICeTYPE = 3,
} MEHomeAD;


//我的Home
typedef enum : NSUInteger {
    MeMyAppointment =0,//预约
    MeMyCentraManagertment,//中心管理
    MeMyDistribution,//我的中心
    MeMyExchange,//兑换
    MeMyCollection,//收藏
    MeMyCustomer,//我的客服
    MeMyCustomerPhone,//客服电话
    MeMyAddress,//收货地址
    MeMyMobile
} MEMineHomeCellStyle;
#define MEMineHomeCellStyleTitle @[@"我的预约",@"中心管理",@"我的中心",@"兑换中心",@"我的收藏",@"ME聊",@"客服电话",@"收货地址",@"绑定的手机号"]
#define MEMineHomeCellStyleImage @[@"icon_woddemiaosha",@"icon-khnytpgj",@"icon_fenxiaozhognxin",@"icon_zhuceyoujiang",@"icon_wodeshoucang",@"icon-qrpteb",@"icon-qrptebjnyt",@"nhwxfbfh",@"qlru"]

//订单
typedef enum : NSUInteger {
    MEAllOrder = 0,
    MEAllNeedPayOrder = 1,
    MEAllNeedDeliveryOrder = 2,
    MEAllNeedReceivedOrder = 3,
    MEAllFinishOrder = 4,
    MEAllCancelOrder = 5,
} MEOrderStyle;
#define MEOrderStyleTitle @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成",@"已取消"];

//订单结算
typedef enum : NSUInteger {
    MESettlmemtGoodsPrice = 0,
    MESettlmemtFreight = 1,
    MESettlmemtRealPay = 2,
    MESettlmemtExpressCompany = 3,
    MESettlmemtExpressNum = 4,
} MEOrderSettlmentStyle;
#define MEOrderSettlmentStyleTitle @[@"商品金额",@"运费",@"实付金额",@"配送方式",@"快递编号"];

//预约
typedef enum : NSUInteger {
    MEAppointmenyUseing = 0,
    MEAppointmenyUsed = 1,
    MEAppointmenyNotUsed = 2,
} MEAppointmenyStyle;
#define MEAppointmenyStyleTitle @[@"已预约",@"已使用",@"未使用"]

//预约信息
typedef enum : NSUInteger {
    MEAppointmentSettlmentTime = 0,
    MEAppointmentSettlmentTel = 1,
    MEAppointmentSettlmentFristBuy = 2,
    MEAppointmentSettlmentUserNameStyle = 3,
    MEAppointmentSettlmentUserTelStyle = 4
} MEAppointmentSettlmentStyle;

#define MEAppointmentSettlmentStyleTitle @[@"预约时间",@"店家手机",@"首次下单,新用户免费体验",@"客户名字",@"客户手机号"];

//分销订单
typedef enum : NSUInteger {
    MEDistrbutionOrder = 0,
    MEDistrbutionNeedPayOrder = 1,
    MEDistrbutionPayedOrder = 2,
    MEMEDistrbutionFinishOrder = 3,
} MEDistrbutionOrderStyle;

#define MEDistrbutionOrderStyleTitle @[@"全部",@"待付款",@"已完成",@"已完成"]

//分销订单
typedef enum : NSUInteger {
    MEMakrOrderCellMessage = 0,//留言
    MEMakrOrderCellDistribution = 1,//配送方式
    MEMakrOrderCellSuperMember = 2,//开通超级会员节省
    MEMakrOrderCellExhange = 3,//积分兑换
}  MEMakrOrderCellStyle;
#define MEMakrOrderCellStyleTitle @[@"买家留言",@"运费",@"开通超级会员本单节省",@"使用积分兑换"]


typedef enum : NSUInteger {
    MEDistributionMoney = 0,
    MEDistributionOrder,
    //MEDistributionTip,
    MEMyTeam,
    MEMyCode,
    
    MEMyMoney,
    MEMyLeave,
    MEMySuperior,
    MEMyClerk,
    MEMyAppintMannger,
    MEMyDataDeal,
    MEMyCash,
} MEDistrbutionCellStyle;
#define MEDistrbutionCellStyleTitle @[@"我的美豆",@"我的订单",@"我的团队",@"推广二维码",@"订单金额",@"我的等级",@"我的上级",@"店员管理",@"预约管理",@"数据统计",@"提现明细"];
#define MEDistrbutionCellStyleImage @[@"icon_fenxiaoyognjin",@"icon_fenxiaodigndan",@"icon_tuandui",@"icon_tuijian",@"icon_fenxiaoyognjin",@"icon_fenxiaodigndan",@"icon-qrhhxe",@"yhkmtpgj",@"cbxqtpgj",@"ovrntpgj",@"rjgmjexl"];

//支付状态
typedef enum : NSUInteger {
    MEOrderStatusFailStyle = 0,
    MEOrderStatusSucessStyle = 1,
}  MEOrderStatusStyle;

typedef enum : NSUInteger {
    MEMainHomeStyle = 0,
    MEMainStoreStyle = 1,
    MEMainMemberStyle = 2,
    MEMainShopCartStyle = 3,
    MEMainMineStyle = 4,
}  MEMainStyle;

typedef enum : NSUInteger {
    MESetAddressStyle = 0,
    MESetPhoneStyle = 1,
    MESetCLearChacheStyle = 2,
    MESetAboutWeStyle = 3,
}  MESetStyle;

typedef enum : NSUInteger {
    MEClientBTypeStyle,
    MEClientCTypeStyle
}  MEClientTypeStyle;


#pragma mark- 网络请求相关枚举

//商品列表类型 1为爆款，2为推荐，3为积分兑换，4为服务列表
typedef enum : NSUInteger {
    MEGoodsTypeNetHotStyle = 1,
    MEGoodsTypeNetCommendStyle = 2,
    MEGoodsTypeNetExchangeStyle= 3,
    MEGoodsTypeNetServiceStyle = 4,
}  MEGoodsTypeNetStyle;


//1待支付 2待发货 3待收货 4已完成 查全部传空值
typedef enum : NSUInteger {
    MEOrderTypeNetWaitPayStyle = 1,
    MEOrderTypeNetDeliveryStyle = 2,
    MEOrderTypeNetReceivedStyle = 3,
    MEOrderTypeNetFinishStyle = 4,
}  MEOrderTypeNetStyle;

//用户类型
typedef enum : NSUInteger {
    MELoginUserCType = 1,//C端用户
    MELoginUserBType = 2,//B端用户
    MELoginUserCLerkType = 3,//店员
} MELoginUserType;


#pragma mark- 系统相关枚举


typedef enum : NSUInteger {
    MEJpushNoticeType = 1,
    MEJpushOrderType = 2,
    MEJpushVersionUpdateType = 3,
} MEJpushType;

#endif /* MEEuemMacros_h */
