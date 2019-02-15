//
//  AccountViews.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/7.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit


@objc protocol AccountViewsDelegate:NSObjectProtocol {
    
    //注册按钮点击代理
    @objc optional func AccountRegisterFooterBtnClick(sender:UIButton)
    
    //textView文本点击代理
    @objc optional func AccountRegisterFooterTextViewClick(textView:UITextView,url:URL)
    
}



/// 注册列表的header
let AccountRegisterHeaderId = "AccountRegisterHeaderId"
let AccountRegisterHeaderH:CGFloat = 80

class AccountRegisterHeader: UITableViewHeaderFooterView {
    

    //按钮
    var mLabel:UILabel?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mLabel =  UILabel.init()
        mLabel?.bounds = CGRect.init(x: 0, y: 0, width: 200, height: 30)
        mLabel?.font = UIFont.systemFont(ofSize: 26)
        mLabel?.textAlignment = NSTextAlignment.left
        mLabel?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mLabel!)
        mLabel?.text = "新用户注册"
        mLabel?.sizeToFit()
        mLabel?.left = 20
        mLabel?.top = 20
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
}






/// 注册列表的cell
let AccountRegisterCellId = "AccountRegisterCellId"
let AccountRegisterCellH:CGFloat = 50

class AccountRegisterCell: UITableViewCell,UITextFieldDelegate {
    
    //代理
    weak var delegate:AccountViewsDelegate?
    
    //分组
    var indexPath:NSIndexPath?
    //输入框
    var mTextF:UITextField?
    //下划线
    var line:UIView?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mTextF = UITextField.init()
        mTextF?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 40, height: AccountRegisterCellH)
        mTextF?.centerX = SCREEN_Width * 0.5
        mTextF?.centerY = AccountRegisterCellH * 0.5
        mTextF?.delegate = self
        mTextF?.textAlignment = NSTextAlignment.left
        mTextF?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(mTextF!)
        mTextF?.isUserInteractionEnabled = true
        mTextF?.clearButtonMode = UITextField.ViewMode.whileEditing
        mTextF?.addTarget(self, action: #selector(textClick(sender:)), for:  UIControl.Event.editingChanged)
        
        line = UIView.init()
        line?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 40, height: 0.5)
        line?.bottom = AccountRegisterCellH
        line?.centerX = SCREEN_Width * 0.5
        line?.backgroundColor = UIColor.colorWithRGB(_r: 200, _g: 200, _b: 200)
        self.contentView.addSubview(line!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //输入框输入的控制
    @objc func textClick(sender: UITextField) {
        
        
    }
    
    //注册界面数据
    private var _registerDic:NSDictionary?
    var registerDic:NSDictionary?{
        didSet{
            _registerDic = registerDic
            
            mTextF?.isHidden = false
            self.textLabel?.isHidden = true
            self.detailTextLabel?.isHidden = true
            self.accessoryType = UITableViewCell.AccessoryType.none
            
            if(indexPath?.row == 0){
                mTextF?.isSecureTextEntry = false
                mTextF?.placeholder = "请输入手机号"
                mTextF?.keyboardType = UIKeyboardType.numberPad
            }
            else if(indexPath?.row == 1){
                mTextF?.isSecureTextEntry = false
                mTextF?.placeholder = "输入验证码"
                mTextF?.keyboardType = UIKeyboardType.numberPad
            }
            else if(indexPath?.row == 2){
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "密码"
                mTextF?.keyboardType = UIKeyboardType.default
            }
            else{
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "确认密码"
                mTextF?.keyboardType = UIKeyboardType.default
            }
        }
    }
    
    
    //忘记密码短信验证界面数据
    private var _forgotPWDic:NSDictionary?
    var forgotPWDic:NSDictionary?{
        didSet{
            _forgotPWDic = forgotPWDic
            
            mTextF?.isHidden = false
            self.textLabel?.isHidden = true
            self.detailTextLabel?.isHidden = true
            self.accessoryType = UITableViewCell.AccessoryType.none
            
            if(indexPath?.row == 0){
                mTextF?.isSecureTextEntry = false
                mTextF?.placeholder = "手机号"
                mTextF?.keyboardType = UIKeyboardType.numberPad
            }
            else{
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "请输入验证码"
                mTextF?.keyboardType = UIKeyboardType.default
            }
        }
    }
    
    
    //添加健康卡界面数据
    private var _vipCardDic:NSDictionary?
    var vipCardDic:NSDictionary?{
        didSet{
            _vipCardDic = vipCardDic
            
            mTextF?.isHidden = false
            self.textLabel?.isHidden = true
            self.detailTextLabel?.isHidden = true
            self.accessoryType = UITableViewCell.AccessoryType.none
            
            if(indexPath?.row == 0){
                mTextF?.isEnabled = true
                mTextF?.isSecureTextEntry = false
                mTextF?.placeholder = "卡号"
                mTextF?.keyboardType = UIKeyboardType.numberPad
            }
            else if(indexPath?.row == 1){
                mTextF?.isEnabled = true
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "卡密码"
                mTextF?.keyboardType = UIKeyboardType.default
            }
            else if(indexPath?.row == 2){
                mTextF?.isEnabled = false
                mTextF?.isSecureTextEntry = false
                mTextF?.text = "13540033103"
                mTextF?.keyboardType = UIKeyboardType.default
            }
            else{
                mTextF?.isEnabled = true
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "验证码"
                mTextF?.keyboardType = UIKeyboardType.numberPad
            }
        }
        
    }
    
    
    
    //修改卡密码界面数据
    private var _changeCardPWDic:NSDictionary?
    var changeCardPWDic:NSDictionary?{
        didSet{
            _changeCardPWDic = changeCardPWDic
            
            mTextF?.isHidden = false
            self.textLabel?.isHidden = true
            self.detailTextLabel?.isHidden = true
            self.accessoryType = UITableViewCell.AccessoryType.none
            
            if(indexPath?.row == 0){
                mTextF?.isEnabled = false
                mTextF?.isSecureTextEntry = false
                mTextF?.text = "5674563"
            }
            else if(indexPath?.row == 1){
                mTextF?.isEnabled = true
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "旧密码"
            }
            else if(indexPath?.row == 2){
                mTextF?.isEnabled = true
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "新密码"
            }
            else{
                mTextF?.isEnabled = true
                mTextF?.isSecureTextEntry = true
                mTextF?.placeholder = "确认密码"
            }
        }
        
    }
}




/// 注册列表的footer
let AccountRegisterFooterId = "AccountRegisterFooterId"
let AccountRegisterFooterH:CGFloat = 100


class AccountRegisterFooter: UITableViewHeaderFooterView,UITextViewDelegate {
    
    //代理
    weak var delegate:AccountViewsDelegate?
    
    //按钮
    var mRegisterBtn:UIButton?
    //用户协议
    var mTextView:UITextView?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        mRegisterBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mRegisterBtn?.bounds = CGRect.init(x: 0, y: 0, width: LoginBtnWidth, height: LoginBtnHeight)
        mRegisterBtn?.centerX = SCREEN_Width * 0.5
        mRegisterBtn?.top = 15
        mRegisterBtn?.tag = 100
        mRegisterBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mRegisterBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mRegisterBtn?.setTitle("立即注册", for: UIControl.State.normal)
        self.contentView.addSubview(mRegisterBtn!)
        mRegisterBtn?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mRegisterBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mRegisterBtn?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mRegisterBtn!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        

        let rang = NSRange.init(location: 15, length: 8)
        let attString = NSMutableAttributedString.init(string: "提示：点击立即注册表是您已同意《用户服务协议》")
        attString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.hexStringToColor(hexString: "999999"), range: NSRange.init(location: 0, length: 15))
        attString.addAttribute(NSAttributedString.Key.link, value:"web", range:rang)
        
        mTextView = UITextView.init()
        mTextView?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 20)
        mTextView?.delegate = self
        mTextView?.dataDetectorTypes = UIDataDetectorTypes.link
        mTextView?.backgroundColor = UIColor.white
        mTextView?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(mTextView!)
        mTextView?.isScrollEnabled = false
        mTextView?.isEditable = false
        mTextView!.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        mTextView?.layoutManager.allowsNonContiguousLayout = false
        mTextView?.isUserInteractionEnabled = true
        mTextView?.attributedText = attString
        mTextView?.sizeToFit()
        mTextView?.top = (mRegisterBtn?.bottom)! + 10
        mTextView?.centerX = SCREEN_Width * 0.5
        mTextView?.linkTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //UItextview 点击文字回调
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if(URL.description == "web"){
            delegate?.AccountRegisterFooterTextViewClick!(textView: textView, url: URL)
            return false
        }
        return true
    }
    
    
    //注册100
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.AccountRegisterFooterBtnClick!(sender: sender)
    }
    
    //注册界面数据
    private var _registerDic:NSDictionary?
    var registerDic:NSDictionary?{
        didSet{
            _registerDic = registerDic
            mRegisterBtn?.setTitle("立即注册", for: UIControl.State.normal)
        }
    }
    
    //忘记密码短信验证数据
    private var _forgotPWDic:NSDictionary?
    var forgotPWDic:NSDictionary?{
        didSet{
            _forgotPWDic = forgotPWDic
            mTextView?.isHidden = true
            mRegisterBtn?.setTitle("下一步", for: UIControl.State.normal)
            mRegisterBtn?.top = 40
        }
    }
    
    
    //添加健康卡数据
    private var _vipCardDic:NSDictionary?
    var vipCardDic:NSDictionary?{
        didSet{
            _vipCardDic = vipCardDic
            mTextView?.isHidden = true
            mRegisterBtn?.setTitle("确认绑定", for: UIControl.State.normal)
            mRegisterBtn?.top = 40
        }
    }
    
    //健康卡详情数据
    private var _vipCardDetDic:NSDictionary?
    var vipCardDetDic:NSDictionary?{
        didSet{
            contentView.backgroundColor = BackGroundColor
            _vipCardDetDic = vipCardDetDic
            mTextView?.isHidden = true
            mRegisterBtn?.setTitle("充值", for: UIControl.State.normal)
            mRegisterBtn?.top = 40
        }
    }
    
    
    
    
    //修改卡密码界面数据
    private var _changeCardPWDic:NSDictionary?
    var changeCardPWDic:NSDictionary?{
        didSet{
            _changeCardPWDic = changeCardPWDic
            
            mRegisterBtn?.setTitle("确认", for: UIControl.State.normal)

            let string = "忘记密码？"
            let attString = NSMutableAttributedString.init(string: string)
            attString.addAttribute(NSAttributedString.Key.link, value:"web", range:NSRange.init(location: 0, length: string.count))

            mTextView?.attributedText = attString
            mTextView?.sizeToFit()
            mTextView?.top = (mRegisterBtn?.bottom)! + 10
            mTextView?.centerX = SCREEN_Width * 0.5
            mTextView?.linkTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        }
    }
}
