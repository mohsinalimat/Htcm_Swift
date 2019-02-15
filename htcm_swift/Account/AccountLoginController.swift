//
//  AccountLoginController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/4.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

//登录界面的控件布局
let PNTextTopSpace:CGFloat  =  70 * SCREEN_Width / 375
let PNTextHieght:CGFloat    =  40
let LoginBtnWidth:CGFloat   =  300 * SCREEN_Width / 375
let LoginBtnHeight:CGFloat  =  LoginBtnWidth * 12 / 65
let ThreeLBSize:CGFloat     =  50 * SCREEN_Width / 375

//登录
class AccountLoginController: BaseController,UITextFieldDelegate {
    
    //背景图
    var mBackImg:UIImageView?
    //logo标题
    var mLogoLab:UILabel?
    //logo图片
    var mLogoImg:UIImageView?
    //账号下划线
    var line:UIView?
    //账号输入框
    var mPhoneText:UITextField?
    //密码下划线
    var line2:UIView?
    //密码输入框
    var mPasswordText:UITextField?
    //是否显示密码
    var mIconBtn:UIButton?
    //确认登录
    var mLoginBtn:UIButton?
    //忘记密码
    var mForgetBtn:UIButton?
    //微信登录
    var weixinButton:UIButton?
    //客服电话
    var servicePhone:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navtionImgView?.image = UIImage.init(named: "denglu_bg1")
        self.setLeftOneBtnImg(imgStr: "mback11")
        self.setRightOneBtnTitle(string: "注册")
        self.navLine?.isHidden = true
        self.leftBtn1?.left = 15
        self.rightBtn1?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        mBackImg = UIImageView.init()
        mBackImg?.frame = CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: SCREEN_Width * 10 / 28)
        mBackImg?.image = UIImage.init(named: "denglu_bg2")
        view.addSubview(mBackImg!)
        
        mLogoLab = UILabel.init()
        mLogoLab?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 30)
        mLogoLab?.centerX = (mBackImg?.width)! * 0.5
        mLogoLab?.bottom = (mBackImg?.height)! * 22 / 37
        mLogoLab?.textAlignment = NSTextAlignment.center
        mLogoLab?.font = UIFont.boldSystemFont(ofSize: 18)
        mLogoLab?.textColor = UIColor.white
        mBackImg?.addSubview(mLogoLab!)
        mLogoLab?.text =  "成都中医大健康管理中心"

        mLogoImg = UIImageView.init()
        mLogoImg?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width * 0.25, height: SCREEN_Width * 0.25 * 33 / 98)
        mLogoImg?.centerX = (mBackImg?.width)! * 0.5
        mLogoImg?.bottom = (mLogoLab?.top)! - 10
        mLogoImg?.image = UIImage.init(named: "logo")
        mBackImg?.addSubview(mLogoImg!)
        
        
        line = UIView.init()
        line?.bounds = CGRect.init(x: 0, y: 0, width: view.width * 0.8, height: 1)
        line?.centerX = view.centerX
        line?.top = (mBackImg?.bottom)! + PNTextTopSpace
        line?.backgroundColor = UIColor.colorWithRGB(_r: 240, _g: 240, _b: 240)
        view.addSubview(line!)
        
        
        mPhoneText = UITextField.init()
        mPhoneText?.bounds = CGRect.init(x: 0, y: 0, width: (line?.width)! - 35, height: PNTextHieght)
        mPhoneText?.left = (line?.left)!
        mPhoneText?.bottom = (line?.bottom)!
        mPhoneText?.placeholder = "手机号"
        mPhoneText?.delegate = self
        mPhoneText?.textAlignment = NSTextAlignment.left
        mPhoneText?.font = UIFont.systemFont(ofSize: NSObject.getNumber(i5: 14, i6: 16, iPlus: 15, iPX: 15))
        mPhoneText?.keyboardType = UIKeyboardType.numberPad
        mPhoneText?.tag = 50
        mPhoneText?.clearButtonMode = UITextField.ViewMode.whileEditing
        view.addSubview(mPhoneText!)
        
        
        
        line2 = UIView.init()
        line2?.bounds = CGRect.init(x: 0, y: 0, width: view.width * 0.8, height: 1)
        line2?.centerX = view.centerX
        line2?.top = (line?.bottom)! + 60
        line2?.backgroundColor = UIColor.colorWithRGB(_r: 240, _g: 240, _b: 240)
        view.addSubview(line2!)
        
        
        
        mPasswordText = UITextField.init()
        mPasswordText?.bounds = CGRect.init(x: 0, y: 0, width: (line?.width)! - 35, height: PNTextHieght)
        mPasswordText?.left = (line2?.left)!
        mPasswordText?.bottom = (line2?.bottom)!
        mPasswordText?.placeholder = "密码"
        mPasswordText?.delegate = self
        mPasswordText?.textAlignment = NSTextAlignment.left
        mPasswordText?.font = UIFont.systemFont(ofSize: NSObject.getNumber(i5: 14, i6: 16, iPlus: 15, iPX: 15))
        mPasswordText?.keyboardType = UIKeyboardType.numberPad
        mPasswordText?.tag = 51
        mPasswordText?.clearButtonMode = UITextField.ViewMode.whileEditing
        view.addSubview(mPasswordText!)
        
        
        
        mIconBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mIconBtn?.bounds = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        mIconBtn?.right = (line2?.right)!
        mIconBtn?.centerY = (mPhoneText?.centerY)! + 1
        mIconBtn?.tag = 12
        view?.addSubview(mIconBtn!)
        mIconBtn?.isSelected = false
        mIconBtn?.setImage(UIImage.init(named: "t_mimayincang"), for: UIControl.State.normal)
        mIconBtn?.setImage(UIImage.init(named: "t_mimaxianshi"), for: UIControl.State.normal)
        mIconBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        
        mLoginBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mLoginBtn?.bounds = CGRect.init(x: 0, y: 0, width: LoginBtnWidth, height: LoginBtnHeight)
        mLoginBtn?.centerX = view.centerX
        mLoginBtn?.top = (line2?.bottom)! + 20
        mLoginBtn?.tag = 100
        view?.addSubview(mLoginBtn!)
        mLoginBtn?.setTitle("登录", for: UIControl.State.normal)
        mLoginBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mLoginBtn?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mLoginBtn?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mLoginBtn?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        mLoginBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for:  UIControl.Event.touchUpInside)
        
        
        
        mForgetBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mForgetBtn?.bounds = CGRect.init(x: 0, y: 0, width: 120, height: 15)
        mForgetBtn?.tag = 14
        view?.addSubview(mForgetBtn!)
        mForgetBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mForgetBtn?.setTitle("忘记密码？", for: UIControl.State.normal)
        mForgetBtn?.setTitleColor(TitleColor, for: UIControl.State.normal)
        mForgetBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for:  UIControl.Event.touchUpInside)
        mForgetBtn?.sizeToFit()
        mForgetBtn?.centerX = view.centerX
        mForgetBtn?.top = (mLoginBtn?.bottom)! + 5
    
        
        
        servicePhone = UITextView.init()
        servicePhone?.bounds = CGRect.init(x: 0, y: 0, width: 150, height: 20)
        servicePhone?.text = "客服电话：400-028-3020"
        servicePhone?.textColor = UIColor.hexStringToColor(hexString: "999999")
        servicePhone?.dataDetectorTypes = UIDataDetectorTypes.all
        servicePhone?.backgroundColor = UIColor.white
        servicePhone?.textAlignment = NSTextAlignment.center
        servicePhone?.sizeToFit()
        servicePhone?.width = 200
        servicePhone?.bottom = SCREEN_Height - SafeAreaBottom_Height - 25
        servicePhone?.centerX = SCREEN_Width * 0.5
        view.addSubview(servicePhone!)
        servicePhone?.isScrollEnabled = false
        servicePhone?.isEditable = false
        servicePhone!.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        servicePhone?.layoutManager.allowsNonContiguousLayout = false
        servicePhone?.linkTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        
        weixinButton = UIButton.init(type: UIButton.ButtonType.custom)
        weixinButton?.bounds = CGRect.init(x: 0, y: 0, width: ThreeLBSize, height: ThreeLBSize)
        weixinButton?.clipsToBounds = true
        weixinButton?.layer.cornerRadius = (weixinButton?.height)! * 0.5
        weixinButton?.centerX = SCREEN_Width * 0.5
        weixinButton?.bottom =  (servicePhone?.top)! - 45
        weixinButton?.tag = 15
        view?.addSubview(weixinButton!)
          weixinButton?.setBackgroundImage(UIImage.init(named: "weixin"), for: UIControl.State.normal)
          weixinButton?.addTarget(self, action: #selector(weixinButtonPressed(sender:)), for:  UIControl.Event.touchUpInside)
        
    }
    

    //左侧返回按钮10  右侧注册按钮11
    override func navgationButtonClick(sender: UIButton) {
        if(sender == leftBtn1){
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        else if(sender == rightBtn1){
            let vc:AccountRegisterController = AccountRegisterController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //登录100   忘记密码14
    @objc func buttonPressed(sender: UIButton) {
        
        if(sender.tag == 100){
            
            NSObject.makeUserLoginYes()
            
            self.sendNotifCation(key: NotiMyMsgChange)
            self.sendNotifCation(key: NotiLoginChange)
            self.sendNotifCation(key: NotiHomeChange)
            self.sendNotifCation(key: NotiCollStatusChange)
            self.sendNotifCation(key: NotiMessageNumChange)
            
            self.navigationController?.dismiss(animated: true, completion: nil)
        }else{
            let vc:AccountForgotPasswordController = AccountForgotPasswordController()
            vc.style = SMSStyle.styleDefault
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    //三方登录
    @objc func weixinButtonPressed(sender: UIButton) {
        
        
    }

}
