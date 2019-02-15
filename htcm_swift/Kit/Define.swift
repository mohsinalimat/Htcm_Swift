//
//  Define.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit


//用户是否登录
let USER_Login       = "USER_Login"
//token_type
let USER_TokenType   = "USER_TokenType"
//access_token
let USER_AccessToken = "USER_AccessToken"
//请求头headerUrl=token_type+access_token
let USER_HeaderUrl   = "USER_HeaderUrl"

//用户名称
let USER_Name        = "USER_Name"
//用户账号（手机号）
let USER_Mobile      = "USER_Mobile"
//账号密码
let USER_Password    = "USER_Password"
//用户头像
let USER_Img         = "USER_Img"
//用户性别
let USER_Sex         = "USER_Sex"
//用户昵称
let USER_Nickname    = "USER_Nickname"

//通知推送开启关闭
let USER_IsPush      = "USER_IsPush"

//手势密码
let USER_GesturesPassword = "USER_GesturesPassword"
//手势密码的使用状态 无需密码0  进入APP使用1  进入体检报告使用2
let USER_GesturesPType    = "USER_GesturesPType"

//搜搜历史
let SEARCHHISTORY         = "SEARCHHISTORY"

//推送的RegistrationID
let RegistrationID        = "RegistrationID"
let ResCode               = "ResCode"



//占位图1 使用banner尺寸
let ImagePlaceHoder1 = "faxian_banner_big"
//占位图2 拉长的banner
let ImagePlaceHoder2 = "faxian_banner_small"
//占位图3 长宽比最高的banner
let ImagePlaceHoder3 = "faxian_yiliaomeirong_banner"
//占位图4 正方形
let ImagePlaceHoder4 = "faxianzhanwei"
//占位图5 首页banner
let ImagePlaceHoder5 = "shouye_banner"
//占位图6 列表小图
let ImagePlaceHoder6 = "tuijianzixun"
//占位图7 普通长方形
let ImagePlaceHoder7 = "taocanxiangqing_banner"



// 屏幕的宽
let SCREEN_Width = UIScreen.main.bounds.size.width
// 屏幕的高
let SCREEN_Height = UIScreen.main.bounds.size.height

//状态栏
let StatuBar_Height = SSDeviceDefault.shareDeviceDefault.statuBarHeight
//导航栏
let NavBar_Height = SSDeviceDefault.shareDeviceDefault.navBarHeight
//安全区域顶部
let SafeAreaTop_Height = SSDeviceDefault.shareDeviceDefault.safeAreaTopHeight
//安全区域底部（iPhone X有）
let SafeAreaBottom_Height = SSDeviceDefault.shareDeviceDefault.safeAreaBottomHeight
//标签栏
let TabBar_Height = SSDeviceDefault.shareDeviceDefault.tabBarHeight
//根页面主视图部分的高度
let MainViewRoot_Height = SSDeviceDefault.shareDeviceDefault.mainViewRoot_Height
//子页面主视图部分的高度
let MainViewSub_Height = SSDeviceDefault.shareDeviceDefault.mainViewSub_Height



//主题色
let TitleColor = SSUserDefault.sharedUserDefault.titleColor()
//背景色
let BackGroundColor = SSUserDefault.sharedUserDefault.backGroundColor()
//线条颜色
let LineColor = SSUserDefault.sharedUserDefault.lineColor()
//标签栏图标默认状态颜色
let tabBarTintDefaultColor = SSUserDefault.sharedUserDefault.tabBarTintDefaultColor()
//标签栏图标选中状态颜色
let tabBarTintSelectColor = SSUserDefault.sharedUserDefault.tabBarTintSelectColor()
//线条颜色
let CellLineColor = UIColor.colorWithRGB(_r: 200, _g: 200, _b: 200)



//登录状态发生变化
let NotiLoginChange:String           = "NotiLoginChange"
//有新消息
let NotiNewMessageChange:String      = "NotiNewMessageChange"
//收藏浏览资讯后刷新数字
let NotiInfoMessageNumChange:String  = "NotiInfoMessageNumChange"
//更新消息数量
let NotiMessageNumChange:String      = "NotiMessageNumChange"
//个人信息状变化后的通知
let NotiMyMsgChange:String           = "NotiMyMsgChange"
//首页数据变化
let NotiHomeChange:String            = "NotiHomeChange"
//首页登录状态发生变化
let NotiPhysicalDetails:String       = "NotiPhysicalDetails"
//智能助理列表状态变化刷新
let NotiSssistantListChange:String   = "NotiSssistantListChange"
//登录后收藏状态变化
let NotiCollStatusChange:String      = "NotiCollStatusChange"
//体检套餐下单体检人变化
let NotiTijianrenChange:String       = "NotiTijianrenChange"
//下载报告后刷新报告详情
let NotiReportDownloadChang:String   = "NotiReportDownloadChang"
//通知控制器显示提示信息
let NotiShowMessage:String           = "NotiShowMessage"
//家人管理列表刷新
let NotiFamilyListChange:String      = "NotiFamilyListChange"
//家人管理详情刷新
let NotiFamilyDetChange:String       = "NotiFamilyDetChange"
//收藏状态变化后刷新收藏列表
let NotiCollectionChange:String      = "NotiCollectionChange"
//刷新体检订单列表
let NotiMedOrderListChange:String    = "NotiMedOrderListChange"
//刷新体检订单详情
let NotiMedOrderDetChange:String     = "NotiMedOrderDetChange"
//手势使用范围发生变化
let NotiGesturesPTypeChange:String   = "NotiGesturesPTypeChange"
//会员卡发生变化
let NotiVipCardChange:String         = "NotiVipCardChange"
