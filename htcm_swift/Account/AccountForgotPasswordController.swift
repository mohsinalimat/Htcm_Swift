//
//  AccountForgotPasswordController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/7.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit


/// 区分短信验证码的用途
///
/// - styleDefault: 默认是忘记密码验证
/// - styleValue1: 修改手机号验证旧手机号
/// - styleValue2: 修改手机号验证新手机号并更改
/// - styleValue3: 账号未设置密码或忘记密码的时候重置密码
/// - styleValue4: 修改卡密码忘记密码
/// - styleValue5: 修改家人手机号
enum SMSStyle{
    case styleDefault
    case styleValue1
    case styleValue2
    case styleValue3
    case styleValue4
    case styleValue5
}

//忘记密码短信验证
class AccountForgotPasswordController: BaseController,UITextFieldDelegate{
    
    //区分短信验证的用途
    var style:SMSStyle?
    
    //线条
    var line:UIView?
    var line2:UIView?
    //输入框
    var mPhoneTextF:UITextField?
    var mCodeTextF:UITextField?
    //确认按钮
    var mRegisterBtn:UIButton?

    override init() {
        super.init()
        style = SMSStyle.styleDefault
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "短信验证")
        
        line = UIView.init()
        line?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 40, height: 1)
        line?.top = SafeAreaTop_Height + 60
        line?.centerX = SCREEN_Width * 0.5
        line?.backgroundColor = LineColor
        view.addSubview(line!)
        
        line2 = UIView.init()
        line2?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 40, height: 1)
        line2?.top = (line?.bottom)! + 60
        line2?.centerX = SCREEN_Width * 0.5
        line2?.backgroundColor = LineColor
        view.addSubview(line2!)
        
        
        mPhoneTextF = UITextField.init()
        mPhoneTextF?.bounds = CGRect.init(x: 0, y: 0, width: (line?.width)! - 20, height: 40)
        mPhoneTextF?.left = (line?.left)!
        mPhoneTextF?.bottom = (line?.bottom)!
        mPhoneTextF?.placeholder = "手机号"
        mPhoneTextF?.delegate = self
        mPhoneTextF?.textAlignment = NSTextAlignment.left
        mPhoneTextF?.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(mPhoneTextF!)
        mPhoneTextF?.tag = 50
        mPhoneTextF?.isSecureTextEntry = true
        mPhoneTextF?.clearButtonMode = UITextField.ViewMode.whileEditing
        mPhoneTextF?.addTarget(self, action: #selector(textClick(textField:)), for: UIControl.Event.editingChanged)
        
        mCodeTextF = UITextField.init()
        mCodeTextF?.bounds = CGRect.init(x: 0, y: 0, width: (line2?.width)! - 20, height: 40)
        mCodeTextF?.left = (line2?.left)!
        mCodeTextF?.bottom = (line2?.bottom)!
        mCodeTextF?.placeholder = "请输入验证码"
        mCodeTextF?.delegate = self
        mCodeTextF?.textAlignment = NSTextAlignment.left
        mCodeTextF?.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(mCodeTextF!)
        mCodeTextF?.tag = 51
        mCodeTextF?.isSecureTextEntry = true
        mCodeTextF?.clearButtonMode = UITextField.ViewMode.whileEditing
        mCodeTextF?.addTarget(self, action: #selector(textClick(textField:)), for: UIControl.Event.editingChanged)
        
        
        mRegisterBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mRegisterBtn?.bounds = CGRect.init(x: 0, y: 0, width: LoginBtnWidth, height: LoginBtnHeight)
        mRegisterBtn?.centerX = SCREEN_Width * 0.5
        mRegisterBtn?.top = (line2?.bottom)! + 30
        mRegisterBtn?.tag = 100
        mRegisterBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mRegisterBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mRegisterBtn?.setTitle("下一步", for: UIControl.State.normal)
        view.addSubview(mRegisterBtn!)
        mRegisterBtn?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mRegisterBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mRegisterBtn?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mRegisterBtn!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        
            //忘记密码
        if(style == SMSStyle.styleDefault){
            mRegisterBtn?.setTitle("下一步", for: UIControl.State.normal)
        }
            //修改手机号验证旧手机号
        else if(style == SMSStyle.styleValue1){
            mRegisterBtn?.setTitle("下一步", for: UIControl.State.normal)
        }
            //修改手机号验证新手机号
        else if(style == SMSStyle.styleValue2){
            mRegisterBtn?.setTitle("确定", for: UIControl.State.normal)
        }
            //忘记密码或未设置密码
        else if(style == SMSStyle.styleValue3){
            self.setNavgaionTitle(string: "重置密码")
        }
            //修改卡密码忘记密码
        else if(style == SMSStyle.styleValue4){
            self.setNavgaionTitle(string: "修改卡密码")
            mRegisterBtn?.setTitle("确认", for: UIControl.State.normal)
        }
    }
    
    
    //输入框输入响应
    @objc func textClick(textField:UITextField){
        
    }
    
    //确认
    @objc func buttonPressed(sender:UIButton){
     
        
        switch style {
            
            ///忘记密码
        case .styleDefault?:
            let vc:AccountSetPWController = AccountSetPWController()
            vc.style = SMSStyle.styleDefault
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
            ///修改手机号验证旧手机号
        case .styleValue1?:
            let vc:AccountForgotPasswordController = AccountForgotPasswordController()
            vc.style = SMSStyle.styleValue2
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
            ///修改手机号验证新手机号
        case .styleValue2?:
            NSObject.makeUserLoginNo()
            self.sendNotifCation(key: NotiMyMsgChange)
            let vc:AccountLoginController = AccountLoginController()
            let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
            self.navigationController?.present(nav, animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
            break
        ///忘记密码或未设置密码
        case .styleValue3?:
            let vc:AccountSetPWController = AccountSetPWController()
            vc.style = SMSStyle.styleValue3
            self.navigationController?.pushViewController(vc, animated: true)
            break
        ///修改卡密码忘记密码
        case .styleValue4?:
            let vc:AccountSetPWController = AccountSetPWController()
            vc.style = SMSStyle.styleValue4
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        default: break
            
        }
    }
    
    
    
    /// 短信验证下一步点击回调
    func AccountRegisterFooterBtnClick(sender: UIButton) {
        
       
        
    }

}
