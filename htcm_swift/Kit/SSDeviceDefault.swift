//
//  SSDeviceDefault.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

class SSDeviceDefault: NSObject {
    
    var statuBarHeight:CGFloat = 20
    var navBarHeight:CGFloat = 44
    var safeAreaTopHeight:CGFloat = 64
    var safeAreaBottomHeight:CGFloat = 0
    var tabBarHeight:CGFloat = 49
    
    //根页面主视图部分的高度
    var mainViewRoot_Height:CGFloat = SCREEN_Height - 44-64
    //子页面主视图部分的高度
    var mainViewSub_Height:CGFloat = SCREEN_Height - 64

    
    static let shareDeviceDefault = SSDeviceDefault()
    private override init() {
        
        
        let deviceType = UIDevice.current.model
        
        var systemInfo = utsname()
        
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            
            return identifier + String(UnicodeScalar(UInt8(value)))
            
        }
        
     
        if(deviceType == "iPhone"){
            
            if(identifier == "i386" ||
                identifier == "x86_64"){
                
                    if(SCREEN_Height==812  || SCREEN_Height==896){
                        self.statuBarHeight = 44.0;
                        self.navBarHeight = 44.0;
                        self.safeAreaTopHeight = 88.0;
                        self.safeAreaBottomHeight = 34.0;
                        self.tabBarHeight = 49.0;
                    }else{
                        self.statuBarHeight = 20.0;
                        self.navBarHeight = 44.0;
                        self.safeAreaTopHeight = 64.0;
                        self.safeAreaBottomHeight = 0.0;
                        self.tabBarHeight = 49.0;
                    }
                
                }
            
            else{
                if(identifier == "iPhone10,3" ||
                    identifier == "iPhone10,6" ||
                    SCREEN_Height>=812){
                    self.statuBarHeight = 44;
                    self.navBarHeight = 44;
                    self.safeAreaTopHeight = 88;
                    self.safeAreaBottomHeight = 34;
                    self.tabBarHeight = 49;
                }else{
                    self.statuBarHeight = 20;
                    self.navBarHeight = 44;
                    self.safeAreaTopHeight = 64;
                    self.safeAreaBottomHeight = 0;
                    self.tabBarHeight = 49;
                }
            }
            
        }
        
        else if(deviceType == "iPod touch"){
            self.statuBarHeight = 20;
            self.navBarHeight = 44;
            self.safeAreaTopHeight = 64;
            self.safeAreaBottomHeight = 0;
            self.tabBarHeight = 49;
        }
      
        
        mainViewRoot_Height = SCREEN_Height - safeAreaTopHeight - tabBarHeight - safeAreaBottomHeight
        mainViewSub_Height = SCREEN_Height - safeAreaTopHeight -  safeAreaBottomHeight

    }
  


    

}
