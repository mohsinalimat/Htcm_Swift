//
//  MineChangePhoneValidationController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

//更换手机号开始验证身份
class MineChangePhoneValidationController: BaseController,UITextViewDelegate {
    
    //输入登录密码
    var mTextField:UITextField?
    //下一步
    var mButton:UIButton?
    //通过短信验证
    var mTextView:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgaionTitle(string: "密码验证")
        view.backgroundColor = BackGroundColor
        self.navLine?.isHidden = true
        
    
        mTextField = UITextField.init()
        mTextField?.frame = CGRect.init(x: 0, y: SafeAreaTop_Height + 10, width: SCREEN_Width, height: 50)
        mTextField?.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 50))
        mTextField?.leftViewMode = UITextField.ViewMode.always
        mTextField?.backgroundColor = UIColor.white
        view.addSubview(mTextField!)
        mTextField?.placeholder = "登录密码"
        mTextField?.font = UIFont.systemFont(ofSize: 14)
        mTextField?.isSecureTextEntry = true
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        mButton?.bounds = CGRect.init(x: 0, y: 0, width: LoginBtnWidth, height: LoginBtnHeight)
        mButton?.centerX = SCREEN_Width * 0.5
        mButton?.top = (mTextField?.bottom)! + 30
        mButton?.tag = 100
        view?.addSubview(mButton!)
        mButton?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mButton?.setTitle("下一步", for: UIControl.State.normal)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mButton!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        let rang = NSRange.init(location: 2, length: 4)
        let attString = NSMutableAttributedString.init(string: "通过短信验证")
        attString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.hexStringToColor(hexString: "999999"), range: NSRange.init(location: 0, length: 2))
        attString.addAttribute(NSAttributedString.Key.link, value:"web", range:rang)
        
        mTextView = UITextView.init()
        mTextView?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 20)
        mTextView?.delegate = self
        mTextView?.dataDetectorTypes = UIDataDetectorTypes.link
        mTextView?.backgroundColor = BackGroundColor
        mTextView?.textAlignment = NSTextAlignment.center
        view.addSubview(mTextView!)
        mTextView?.isScrollEnabled = false
        mTextView?.isEditable = false
        mTextView!.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        mTextView?.layoutManager.allowsNonContiguousLayout = false
        mTextView?.isUserInteractionEnabled = true
        mTextView?.attributedText = attString
        mTextView?.sizeToFit()
        mTextView?.top = (mButton?.bottom)! + 10
        mTextView?.centerX = SCREEN_Width * 0.5
        mTextView?.linkTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
    }
    
    
    //UItextview 通过短信验证
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if(URL.description == "web"){
            let vc:AccountForgotPasswordController = AccountForgotPasswordController()
            vc.style = SMSStyle.styleValue1
            self.navigationController?.pushViewController(vc, animated: true)
            return false
        }
        return true
    }
    
    
    //确定
    @objc func buttonPressed(sender:UIButton){
      
        
    }
    
}
