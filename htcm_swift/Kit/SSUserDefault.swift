//
//  SSUserDefault.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit



class SSUserDefault: NSObject {

    static let sharedUserDefault = SSUserDefault()
    private override init() {
        
    }
    
    //主题色
    func titleColor() -> (UIColor) {
        return UIColor.hexStringToColor(hexString: "20D3B3")
    }
    
    //导航栏+状态栏背景颜色
    func navBarColor() -> (UIColor) {
        return UIColor.hexStringToColor(hexString: "000000")
    }
    //标签栏背景颜色
    func tabBarColor() -> (UIColor) {
        return UIColor.hexStringToColor(hexString: "20D3B3")
    }
    //导航栏图标颜色
    func navTintColor() -> (UIColor) {
        return UIColor.hexStringToColor(hexString: "20D3B3")
    }
    //标签栏图标默认状态颜色
    func tabBarTintDefaultColor() -> (UIColor) {
        return UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1)
    }
    //标签栏图标选中状态颜色
    func tabBarTintSelectColor() -> (UIColor) {
        return UIColor.hexStringToColor(hexString: "20D3B3")
    }
    //视图背景色
    func backGroundColor() -> (UIColor) {
        return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
    //线条颜色
    func lineColor() -> (UIColor) {
        return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    
    
}
