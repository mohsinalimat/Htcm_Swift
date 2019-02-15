//
//  BaseVirtualController.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/28.
//  Copyright © 2018 soldoros. All rights reserved.
//

import UIKit
import SnapKit

class BaseVirtualController: UIViewController {
    
    
    /// 导航栏背景视图
    var navtionBar:UIImageView?
    var navtionImgView:UIImageView?
    
    /// 导航栏底部的一根很细的线条
    var navLine:UIView?
    /// 导航栏标题
    var titleLab:UILabel?
    /// 导航栏logo图
    var titleImgView:UIImageView?
    /// 导航栏按钮
    var titleButton:UIButton?
    
    /// 左侧两个按钮
    var leftBtn1:UIButton?
    var leftBtn2:UIButton?
    /// 右侧两个按钮
    var rightBtn1:UIButton?
    var rightBtn2:UIButton?
    
    /// 右侧按钮红点
    var redView:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //=========================================
    //设置导航栏部分
    //标题按钮10  左侧一号11  左侧二号12  右侧一号13 右侧二号14
    //=========================================
    
    
    
    /// 根据图片设置导航栏，记着，最里面那一层的图片视图永远设置透明背景的图，避免某些页面出现特效难以调整。
    ///
    /// - Parameter string: 传入本地图片名称
    public func setNavgationBarImg(string:NSString){
        
        if(navtionBar == nil){
            navtionBar = UIImageView.init()
            navtionBar?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: SafeAreaTop_Height)
            navtionBar?.isUserInteractionEnabled = true
            view.addSubview(navtionBar!)
        }
        if(navtionImgView == nil){
            navtionImgView = UIImageView.init()
            navtionImgView?.frame = (navtionBar?.bounds)!
            navtionImgView?.isUserInteractionEnabled = true
            view.addSubview(navtionImgView!)
        }
        navtionImgView?.image = UIImage.init(named: string as String)
        
    }
    
    
    /// 根据颜色设置导航栏
    ///
    /// - Parameter color: 传入颜色值
    public func setNavgationBarColor(color:UIColor){
        
        if(navtionBar == nil){
            navtionBar = UIImageView.init()
            navtionBar?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: SafeAreaTop_Height)
            navtionBar?.isUserInteractionEnabled = true
            view.addSubview(navtionBar!)
        }
        if(navtionImgView == nil){
            navtionImgView = UIImageView.init()
            navtionImgView?.frame = (navtionBar?.bounds)!
            navtionImgView?.isUserInteractionEnabled = true
            view.addSubview(navtionImgView!)
        }
        navtionImgView?.image = nil
        navtionImgView?.backgroundColor = color
        
    }
    
    
    /// 根据颜色设置导航栏的图片 这个时候导航栏的颜色一定是纯色的
    ///
    /// - Parameter color: 传入颜色值
    public func setNavgationBarColorImg(color:UIColor){
        if(navtionBar == nil){
            navtionBar = UIImageView.init()
            navtionBar?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: SafeAreaTop_Height)
            navtionBar?.isUserInteractionEnabled = true
            view.addSubview(navtionBar!)
        }
        if(navtionImgView == nil){
            navtionImgView = UIImageView.init()
            navtionImgView?.frame = (navtionBar?.bounds)!
            navtionImgView?.isUserInteractionEnabled = true
            navtionBar?.addSubview(navtionImgView!)
        }
        navtionImgView?.image = UIImage.imageFromColor(color: color)
    }
    
    
    /// 设置导航栏最底部的线条 并给出颜色
    ///
    /// - Parameter color: 传入颜色值
    public func setNavgationBarLine(color:UIColor){
        
        if(navtionImgView == nil){return}
        if(navLine == nil){
            navLine = UIView.init()
            navLine?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 0.5)
            navLine?.bottom = (navtionImgView?.height)!
            navtionImgView?.addSubview(navLine!)
        }
        navLine?.backgroundColor = CellLineColor
    }

    
    /// 删除导航栏 部分页面是不需要导航栏的
    public func setNavgationNil(){
        
        if(navtionBar != nil){
            navtionBar?.removeFromSuperview()
            navtionBar = nil
        }
    }
    
    
    /// 设置导航栏标题属性
    ///
    /// - Parameters:
    ///   - font: 标题的字体大小
    ///   - color: 标题的字体颜色
    public func setNavgationTitleAttribute(font:UIFont,color:UIColor){
        
        if(titleLab == nil){
            titleLab = UILabel.init()
            titleLab?.frame = CGRect.init(x: 0, y: StatuBar_Height, width: SCREEN_Width, height: NavBar_Height)
            titleLab?.textAlignment = NSTextAlignment.center
            navtionImgView?.addSubview(titleLab!)
            titleLab?.isUserInteractionEnabled = true
        }
        titleLab?.font = font
        titleLab?.textColor = color
    }
    
    
    /// 设置导航栏标题文字
    ///
    /// - Parameter string: 传入字符串
    public func setNavgaionTitle(string:NSString){
        
        if(titleLab == nil){
            titleLab = UILabel.init()
            titleLab?.frame = CGRect.init(x: 0, y: StatuBar_Height, width: SCREEN_Width, height: NavBar_Height)
            titleLab?.textAlignment = NSTextAlignment.center
            navtionImgView?.addSubview(titleLab!)
            titleLab?.isUserInteractionEnabled = true
        }
        titleLab?.text = string as String
        titleLab?.sizeToFit()
        if((titleLab?.width)! > SCREEN_Width-100){
            titleLab?.width = SCREEN_Width-100
        }
        titleLab?.centerX = (navtionImgView?.width)! * 0.5
        titleLab?.centerY = StatuBar_Height + NavBar_Height * 0.5;
        
    }
    
    
    /// 设置导航栏正中间的图片 比如首页的logo
    ///
    /// - Parameter imgStr: 传入本地图片名称
    public func setNavgaionTitleImg(imgStr:NSString){
        
        if(titleImgView == nil){
            titleImgView = UIImageView.init()
            titleImgView?.frame = CGRect.init(x: 0, y: StatuBar_Height, width: (NavBar_Height - 25) * 63/22, height: NavBar_Height - 25)
            navtionImgView?.addSubview(titleImgView!)
            navtionImgView?.isUserInteractionEnabled = true
            titleImgView?.centerX = (navtionImgView?.width)! * 0.5
            titleImgView?.centerY =  StatuBar_Height + NavBar_Height * 0.5
        }
        titleImgView?.image = UIImage.init(named: imgStr as String)
        
    }
    
    
    /// 设置导航栏中间的筛选按钮 比如报告对比界面的筛选
    ///
    /// - Parameter string: 传入按钮图片的名称
    public func setNavgaionTitleButton(string:NSString){
        
        if(titleButton == nil){
            titleButton = UIButton.init(type: UIButton.ButtonType.custom)
            titleButton?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: SCREEN_Width * 0.5, height: NavBar_Height - 10)
            titleButton?.centerX = (navtionImgView?.width)! * 0.5
            titleButton?.centerY = StatuBar_Height + NavBar_Height * 0.5
            navtionImgView?.addSubview(titleButton!)
            titleButton?.tag = 10
            titleButton?.isUserInteractionEnabled = true
            titleButton?.setTitleColor(UIColor.hexStringToColor(hexString: "333333"), for: UIControl.State.normal)
            titleButton?.setImage(UIImage.init(named: "jiantouxia"), for: UIControl.State.normal)
            titleButton?.setImage(UIImage.init(named: "jiantoushang"), for: UIControl.State.selected)
            titleButton?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        titleButton?.setTitle(string as String, for: UIControl.State.normal)
        titleButton?.setImgTitleCenteredAround()
        
    }
    
    
    /// 左侧第一个按钮 用原图片展示
    ///
    /// - Parameter imgStr: 传入图片名称
    public func setLeftOneBtnImg(imgStr:NSString){
        
        if(leftBtn1 == nil){
            leftBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            navtionBar?.addSubview(leftBtn1!)
            leftBtn1?.tag = 12
            leftBtn1?.isSelected = false
            leftBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)

            leftBtn1?.snp.makeConstraints({ (make) in
                make.width.equalTo(NavBar_Height)
                make.height.equalTo(NavBar_Height)
                make.left.equalTo(0)
                make.top.equalTo(StatuBar_Height)
            })
        }
        
        leftBtn1?.setImage(UIImage.init(named: imgStr as String), for: UIControl.State.normal)
    }
    
    
    /// 左侧第一个按钮 用颜色处理过的图片展示
    ///
    /// - Parameters:
    ///   - imgStr: 传入图片名称
    ///   - color: 传入图片颜色
    public func setLeftOneBtnImg(imgStr:NSString,color:UIColor){
        
        if(leftBtn1 == nil){
            leftBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            leftBtn1?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            leftBtn1?.left = 0
            leftBtn1?.top = StatuBar_Height
            navtionBar?.addSubview(leftBtn1!)
            leftBtn1?.tag = 10
            leftBtn1?.isSelected = false
            leftBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        var img:UIImage = UIImage.init(named: imgStr as String)!
        img = img.imageWithColor(color: color)
        leftBtn1?.setImage(img, for: UIControl.State.normal)
        
    }
    
    
    /// 左侧第一个按钮 用文字展示
    ///
    /// - Parameter string: 传入按钮文字
    public func setLeftOneBtnTitle(string:NSString){
        
        if(leftBtn1 == nil){
            
            leftBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            leftBtn1?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            leftBtn1?.left = 15
            leftBtn1?.top = StatuBar_Height
            navtionBar?.addSubview(leftBtn1!)
            leftBtn1?.tag = 10
            leftBtn1?.isSelected = false
            leftBtn1?.setTitleColor(TitleColor, for: UIControl.State.normal)
            leftBtn1?.setTitleColor(TitleColor, for: UIControl.State.selected)
            leftBtn1?.titleLabel?.textAlignment = NSTextAlignment.right
            leftBtn1?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            leftBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
            
        }
        
        leftBtn1?.setTitle(string as String, for: UIControl.State.normal)
        
    }
    
    
    
    /// 左侧两个图片按钮
    ///
    /// - Parameters:
    ///   - imgStr1: 最左侧图片名称
    ///   - imgStr2: 左侧第二个图片名称
    public func setLeftBtnImg(imgStr1:NSString,imgStr2:NSString){
        
        if(leftBtn1 == nil){
            leftBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            leftBtn1?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            leftBtn1?.left = 0
            leftBtn1?.top = StatuBar_Height
            navtionBar?.addSubview(leftBtn1!)
            leftBtn1?.tag = 10
            leftBtn1?.isSelected = false
            leftBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        if(leftBtn2 == nil){
            leftBtn2 = UIButton.init(type: UIButton.ButtonType.custom)
            leftBtn2?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            leftBtn2?.left = (leftBtn1?.right)!
            leftBtn2?.top = StatuBar_Height
            navtionBar?.addSubview(leftBtn2!)
            leftBtn2?.tag = 11
            leftBtn2?.isSelected = false
            leftBtn2?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        leftBtn1?.setImage(UIImage.init(named: imgStr1 as String), for: UIControl.State.normal)
        leftBtn2?.setImage(UIImage.init(named: imgStr2 as String), for: UIControl.State.normal)
    }
    
    
    
    /// 右侧第一个按钮 用原图片展示
    ///
    /// - Parameter imgStr: 传入图片名称
    public func setRightOneBtnImg(imgStr:NSString){
        
        if(rightBtn1 == nil){
            rightBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            rightBtn1?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            rightBtn1?.right = (navtionBar?.width)!
            rightBtn1?.top = StatuBar_Height
            navtionBar?.addSubview(rightBtn1!)
            rightBtn1?.tag = 12
            rightBtn1?.isSelected = false
            rightBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
            
        }
        rightBtn1?.setImage(UIImage.init(named: imgStr as String), for: UIControl.State.normal)
        
    }
    
    
    /// 右侧第一个按钮  用颜色处理过的图片展示
    ///
    /// - Parameters:
    ///   - imgStr: 传入本地图片名称
    ///   - color: 传入图片颜色
    public func setRightOneBtnImg(imgStr:NSString,color:UIColor){
        
        if(rightBtn1 == nil){
            rightBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            rightBtn1?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            rightBtn1?.left = 0
            rightBtn1?.top = StatuBar_Height
            navtionBar?.addSubview(rightBtn1!)
            rightBtn1?.tag = 12
            rightBtn1?.isSelected = false
            rightBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        var img:UIImage = UIImage.init(named: imgStr as String)!
        img = img.imageWithColor(color: color)
        rightBtn1?.setImage(img, for: UIControl.State.normal)
        
    }
    
    
    /// 右侧第一个按钮  用文字展示
    ///
    /// - Parameter string: 传入按钮文字
    public func setRightOneBtnTitle(string:NSString){
        
        if(rightBtn1 == nil){
            rightBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            navtionBar?.addSubview(rightBtn1!)
            rightBtn1?.tag = 12
            rightBtn1?.isSelected = false
            rightBtn1?.setTitleColor(TitleColor, for: UIControl.State.normal)
            rightBtn1?.setTitleColor(TitleColor, for: UIControl.State.selected)
            rightBtn1?.titleLabel?.textAlignment = NSTextAlignment.right
            rightBtn1?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            rightBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
            
            rightBtn1?.snp.makeConstraints({ (make) in
                make.right.equalTo(-10)
                make.centerY.equalTo(StatuBar_Height + ((navtionBar?.height)! - StatuBar_Height) * 0.5)
            })
        }
        
        rightBtn1?.setTitle(string as String, for: UIControl.State.normal)
        
    }
    
 
    
    
    /// 右侧两个图片按钮
    ///
    /// - Parameters:
    ///   - imgStr1: 最右侧图片名称
    ///   - imgStr2: 右侧第二个图片名称
    public func setRightBtnImg(imgStr1:NSString,imgStr2:NSString){
    
        if(rightBtn1 == nil){
            rightBtn1 = UIButton.init(type: UIButton.ButtonType.custom)
            rightBtn1?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            rightBtn1?.right = (navtionBar?.width)!
            rightBtn1?.top = StatuBar_Height
           navtionBar?.addSubview(rightBtn1!)
            rightBtn1?.tag = 12
            rightBtn1?.isSelected = false
            rightBtn1?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        if(rightBtn2 == nil){
            rightBtn2 = UIButton.init(type: UIButton.ButtonType.custom)
            rightBtn2?.bounds = CGRect.init(x: 0, y: StatuBar_Height, width: NavBar_Height, height: NavBar_Height)
            rightBtn2?.right = (rightBtn1?.left)!
            rightBtn2?.top = StatuBar_Height
            navtionBar?.addSubview(rightBtn2!)
            rightBtn1?.tag = 13
            rightBtn2?.isSelected = false
            rightBtn2?.addTarget(self, action: #selector(navgationButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        rightBtn1?.setImage(UIImage.init(named: imgStr1 as String), for: UIControl.State.normal)
        rightBtn2?.setImage(UIImage.init(named: imgStr2 as String), for: UIControl.State.normal)
    }
    
    
    
    //=========================================
    //设置标签栏部分
    //=========================================
    
    
    
    /// 设置标签栏按钮的默认图片和选中图片  默认标题和选中标题 默认颜色和选中颜色
    ///
    /// - Parameters:
    ///   - nomImg: 默认图片名称
    ///   - selImg: 选中图片名称
    ///   - title1: 默认文字
    ///   - title2: 选中的文字
    ///   - color1: 默认的颜色
    ///   - color2: 选中的颜色
    public func setTabBarItem(nomImg:NSString, selImg:NSString, title1:NSString, title2:NSString, color1:UIColor, color2:UIColor){
        
        
    }
    
    
    //=========================================
    //其他功能
    //=========================================
    
    
    /// 拨打电话
    ///
    /// - Parameter phone: 传入电话号码
    public func callPhone(phone:NSString){
        
        
        
    }
    
    
    /// 设置右侧按钮红点
    public func setRedViewOnRightButton(){
        
    }

    
    /// 删除按钮的红点
    public func deleteRedView(){
        
    }
    
    
    /// 提示弹窗
    ///
    /// - Parameter message: 传入提示信息
    public func showTime(message:NSString){
        
    }
    
    
    /// 系统提示框按钮点击回调代码块
    typealias AlertBlock = (_ action:UIAlertAction)->()
    
    /// 系统自带提示框
    ///
    /// - Parameters:
    ///   - title: 提示框标题
    ///   - message: 提示详情
    ///   - okButton: 确认按钮文字
    ///   - cancelButton: 取消按钮文字
    ///   - alertBlock: 点击按钮回调
    public func systemAlert(title:NSString, message:NSString,okButton:NSString, cancelButton:NSString, alertBlock:AlertBlock){
        
    }

    
    /// 导航栏标题按钮点击事件
    /// 标题按钮10  左侧一号11  左侧二号12  右侧一号13 右侧二号14
    @objc public func navgationButtonClick(sender:UIButton){
        
        print("nihao")
        
    }
    
    
    
    //=========================================
    //其他部分
    //=========================================
    
    
    ///发送不带参数的通知
    public func sendNotifCation(key:String){
        let nc:NotificationCenter = NotificationCenter.default
        let noti:NSNotification = NSNotification.init(name: NSNotification.Name(rawValue: key), object: nil)
        nc.post(noti as Notification)
    }
    
    ///发送带参数的通知 参数格式为键值对
    public func sendNotifCation(key:String,object:NSObject){
        let nc:NotificationCenter = NotificationCenter.default
        let noti:NSNotification = NSNotification.init(name: NSNotification.Name(rawValue: key), object: object)
        nc.post(noti as Notification)
    }
    
    //移除通知
    public func deleteNotifCation(){
        NotificationCenter.default.removeObserver(self)
    }
    
    
}
