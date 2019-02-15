//
//  AccountSetPWController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/7.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit


//设置密码
class AccountSetPWController: BaseController,UITextFieldDelegate {
    
    //忘记密码找回密码 未设置密码或忘记密码进行设置
    var style:SMSStyle?
    //线条
    var line:UIView?
    var line2:UIView?
    //输入框
    var mPhoneTextF:UITextField?
    var mCodeTextF:UITextField?
    //确认按钮
    var mRegisterBtn:UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "设置密码")
        
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
        mPhoneTextF?.placeholder = "新密码"
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
        mCodeTextF?.placeholder = "确认密码"
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
        mRegisterBtn?.setTitle("确认", for: UIControl.State.normal)
        view.addSubview(mRegisterBtn!)
        mRegisterBtn?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mRegisterBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mRegisterBtn?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mRegisterBtn!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
    }
    
    
    //输入框输入响应
    @objc func textClick(textField:UITextField){
        
    }
    
    //确认
    @objc func buttonPressed(sender:UIButton){
        if(style == SMSStyle.styleDefault){
            self.navigationController?.popToRootViewController(animated: true)
        }
        else if(style == SMSStyle.styleValue3){
            NSObject.makeUserLoginNo()
            let vc:AccountLoginController = AccountLoginController()
            let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
            self.navigationController?.present(nav, animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
        //忘记卡密码
        else if(style == SMSStyle.styleValue4){
            
            var controller:UIViewController? = nil
            for vc:UIViewController in (self.navigationController?.viewControllers)!{
                if(vc.isKind(of: MineVipCardDetController.classForCoder())){
                    controller = vc
                    break
                }
                continue
            }
            if(controller != nil){
                self.navigationController?.popToViewController(controller!, animated: true)
            }else{
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }
    
    
}
