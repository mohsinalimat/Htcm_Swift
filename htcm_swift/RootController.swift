//
//  RootController.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

/*
 
 
 1.跟新swift版本：个人中心界面（登录+未登录） 设置界面（登录+未登录）
   跟新登录界面、注册界面、忘记密码（发送短信+设置密码）
 

 
 */

import UIKit

class RootController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        self.navigationController?.navigationBar.isHidden = true
        
        
        let user:UserDefaults = UserDefaults.standard
        
        //第一次进入系统
        if((user.value(forKey: USER_Login)) == nil){
            NSObject.makeUserLogin(login: false)
            NSObject.makeUser(userName: "", userMobile: "", userPassWord: "")
            NSObject.makeUserGesturesPassword(userGesturesPassword: "")
            NSObject.makeUserGesturesPType(userGesturesPType: "0")
            NSObject.makeUserIsPush(isPush: true)
        }
        
        //已登录 判断是否需要手势密码
        else{
            let str:NSString = user.value(forKey: USER_GesturesPType) as! NSString
            if(str == "1"){
                
            }
        }
        
        
        //导航栏属性
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        
        //标签栏属性
        let normalAtt =  [NSAttributedString.Key.foregroundColor: tabBarTintDefaultColor]
        let selectedAtt =  [NSAttributedString.Key.foregroundColor: tabBarTintSelectColor]
        
        
        let vc1 :HomeController = HomeController.init(isRoot:true, titleString: "首页")
        vc1.tabBarItem.title = "首页"
        vc1.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage(named: "home_xuanzhong")?.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.setTitleTextAttributes(normalAtt, for: UIControl.State.normal)
        vc1.tabBarItem.setTitleTextAttributes(selectedAtt, for: UIControl.State.selected)
        
        
        let vc2 :HealthController = HealthController.init(isRoot:true, titleString: "健康")
        vc2.tabBarItem.title = "健康"
        vc2.tabBarItem.image = UIImage(named: "jiankang")?.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.selectedImage = UIImage(named: "jiankang_xuanzhong")?.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.setTitleTextAttributes(normalAtt, for: UIControl.State.normal)
        vc2.tabBarItem.setTitleTextAttributes(selectedAtt, for: UIControl.State.selected)
        
        
        let vc3 :FoundController = FoundController.init(isRoot:true, titleString: "发现")
        vc3.tabBarItem.title = "发现"
        vc3.tabBarItem.image = UIImage(named: "faxian")?.withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.selectedImage = UIImage(named: "faxian_xuanzhong")?.withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.setTitleTextAttributes(normalAtt, for: UIControl.State.normal)
        vc3.tabBarItem.setTitleTextAttributes(selectedAtt, for: UIControl.State.selected)
        
        
        let vc4 :MineController = MineController.init(isRoot:true, titleString: "我的")
        vc4.tabBarItem.title = "我的"
        vc4.tabBarItem.image = UIImage(named: "my")?.withRenderingMode(.alwaysOriginal)
        vc4.tabBarItem.selectedImage = UIImage(named: "my_xuanzhong")?.withRenderingMode(.alwaysOriginal)
        vc4.tabBarItem.setTitleTextAttributes(normalAtt, for: UIControl.State.normal)
        vc4.tabBarItem.setTitleTextAttributes(selectedAtt, for: UIControl.State.selected)
        
        
        let nav1:UINavigationController = UINavigationController.init(rootViewController: vc1);
        nav1.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        let nav2:UINavigationController = UINavigationController.init(rootViewController: vc2);
        nav2.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        let nav3:UINavigationController = UINavigationController.init(rootViewController: vc3);
        nav3.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        let nav4:UINavigationController = UINavigationController.init(rootViewController: vc4);
        nav4.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        
        let tabController :UITabBarController = UITabBarController()
        tabController.viewControllers = [nav1,nav2,nav3,nav4]
        tabController.tabBar.backgroundColor = UIColor.white
        self.addChild(tabController);
        view.addSubview(tabController.view);
        
    }

}
