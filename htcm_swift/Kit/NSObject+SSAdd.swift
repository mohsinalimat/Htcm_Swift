//
//  NSObject+SSAdd.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/21.
//  Copyright © 2018年 soldoros. All rights reserved.
//


import Foundation
import UIKit


extension NSObject{
    
    //适配不同的机型
    class func getNumber(i5:CGFloat, i6:CGFloat, iPlus:CGFloat, iPX:CGFloat)-> CGFloat{
        if(SCREEN_Width == 320){return i5}
        else if(SCREEN_Width == 375){return i6}
        else if(SCREEN_Width == 414){return iPlus}
        else if(SCREEN_Width == 812){return iPX}
        else {return i6}
    }
    
    //设置是否登录
    class func makeUserLogin(login:Bool){
        let user:UserDefaults = UserDefaults.standard
        user.set(login, forKey: USER_Login)
    }
    
    //设置登录后的tokenType
    class func makeUserTokenType(tokenType:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(tokenType, forKey: USER_TokenType)
    }
    
    //设置登录后的access_token
    class func makeUserAccessToken(accessToken:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(accessToken, forKey: USER_AccessToken)
    }
    
    //请求头 headerUrl=token_type+access_token
    class func makeUserHeaderUrl(headerUrl:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(headerUrl, forKey: USER_HeaderUrl)
    }
    
    
    //设置是开启推送
    class func makeUserIsPush(isPush:Bool){
        let user:UserDefaults = UserDefaults.standard
        user.set(isPush, forKey: USER_IsPush)
    }
    
    
    
    //设置名称
    class func makeUserName(userName:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(userName, forKey: USER_Name)
    }
    
    
    //设置手机号
    class func makeUserMobile(userMobile:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(userMobile, forKey: USER_Mobile)
    }
    
    
    //设置密码
    class func makeUserPassWord(userPassWord:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(userPassWord, forKey: USER_Password)
    }
    
    
    //设置用户 手机号 密码
    class func makeUser(userName:NSString,userMobile:NSString,userPassWord:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(userName, forKey: USER_Name)
        user.set(userName, forKey: USER_Mobile)
        user.set(userName, forKey: USER_Password)
    }
    
    
    //设置手势密码
    class func makeUserGesturesPassword(userGesturesPassword:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(userGesturesPassword, forKey: USER_GesturesPassword)
    }
    
    //手势密码使用状态 无需密码0  进入APP使用1   进入体检报告使用2
    class func makeUserGesturesPType(userGesturesPType:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(userGesturesPType, forKey: USER_GesturesPType)
    }
    
    
    //设置用户头像
    class func makeUserImg(userImg:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(userImg, forKey: USER_Img)
    }
    
    //推送RegistrationID
    class func makeRegistrationID(registrationID:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(registrationID, forKey: RegistrationID)
    }
    
    //推送RegistrationID
    class func makeResCode(resCode:NSString){
        let user:UserDefaults = UserDefaults.standard
        user.set(resCode, forKey: ResCode)
    }
    
    
    //登录
    class func makeUserLoginYes(){
        let user:UserDefaults = UserDefaults.standard
        user.set(true, forKey: USER_Login)
    }
    
    
    //退出登录
    class func makeUserLoginNo(){
        let user:UserDefaults = UserDefaults.standard
        user.set(false, forKey: USER_Login)
        
        makeUserPassWord(userPassWord: "")
        makeUserImg(userImg: "")
        makeUserTokenType(tokenType: "")
        makeUserAccessToken(accessToken: "")
        makeUserHeaderUrl(headerUrl: "")
    }
    
}
