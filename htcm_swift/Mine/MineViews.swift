//
//  MineViews.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/3.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol MineViewsDelegate:NSObjectProtocol {
    
    //个人中心首页个人信息部分按钮点击代理
    @objc optional func MineDefaultHeaderBtnClick(sender:UIButton, login:Bool)
    //个人中心首页顶部cell的健康卡和优惠券的点击代理
    @objc optional func MineTopCellBtnClick(sender:UIButton)
    
    //修改密码的footer按钮点击代理
    @objc optional func MineChangPasswordBottomBtnClick(sender:UIButton)
    
    //健康卡列表二维码点击代理
    @objc optional func MineVipCardCellBtnClick(indexPath:NSIndexPath,sender:UIButton)
    
    //健康卡列表底部的添加按钮
    @objc optional func MineAddVipCardViewBtnClick(sender:UIButton)
    
    //优惠券界面顶部的优惠码输入框
    @objc optional func MineVouchersListTopViewBtnClick(sender:UIButton, string:NSString)
    
}

/// 个人中心首页顶部视图
let MineDefaultHeaderH:CGFloat = SafeAreaTop_Height + 173

class MineDefaultHeader: UIImageView {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //代理
    weak var delegate:MineViewsDelegate?
    
    //是否已经登录
    var login:Bool?
    //用户头像
    var mHeadImgBtn:UIButton?
    //用户昵称
    var mNameBtn:UIButton?
    //用户账号
    var mNumberBtn:UIButton?
    //右侧箭头
    var mRightBtn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BackGroundColor
        self.image = UIImage.init(named: "z_wode_bg_plus")
        self.isUserInteractionEnabled = true
        self.contentMode = UIView.ContentMode.bottom
        self.layer.masksToBounds = true
        
        
        let imgSize:CGFloat =  70 * SCREEN_Width / 375
        
        mHeadImgBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mHeadImgBtn?.bounds = CGRect.init(x: 0, y: 0, width: imgSize, height: imgSize)
        mHeadImgBtn?.centerX = self.width * 13 / 75
        mHeadImgBtn?.top = SafeAreaTop_Height + 30
        mHeadImgBtn?.tag = 10
        mHeadImgBtn?.clipsToBounds = true
        mHeadImgBtn?.layer.cornerRadius = (mHeadImgBtn?.height)! * 0.5
        self.addSubview(mHeadImgBtn!)
        mHeadImgBtn?.layer.borderColor = BackGroundColor.cgColor
        mHeadImgBtn?.layer.borderWidth = 2
        mHeadImgBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        
        mNameBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mNameBtn?.bounds = CGRect.init(x: 0, y: 0, width: 160, height: NSObject.getNumber(i5: 26, i6: 28, iPlus: 30, iPX: 30))
        mNameBtn?.left = (mHeadImgBtn?.right)! + 20
        mNameBtn?.bottom = (mHeadImgBtn?.centerY)!
        mNameBtn?.tag = 11
        mNameBtn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: NSObject.getNumber(i5: 16, i6: 18, iPlus: 20, iPX: 20))
        self.addSubview(mNameBtn!)
        mNameBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mNameBtn!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        mNameBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        
        //账号
        mNumberBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mNumberBtn?.bounds = CGRect.init(x: 0, y: 0, width: 160, height: NSObject.getNumber(i5: 26, i6: 28, iPlus: 30, iPX: 30))
        mNumberBtn?.left = (mHeadImgBtn?.right)! + 20
        mNumberBtn?.top = (mNumberBtn?.bottom)!
        mNumberBtn?.tag = 12
        mNumberBtn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: NSObject.getNumber(i5: 16, i6: 17, iPlus: 18, iPX: 18))
        self.addSubview(mNumberBtn!)
        mNumberBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mNumberBtn!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        mNumberBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        
        mRightBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mRightBtn?.bounds = CGRect.init(x: 0, y: 0, width: 8, height: 16)
        mRightBtn?.right = self.width - 20
        mRightBtn?.centerY = (mHeadImgBtn?.centerY)!
        mRightBtn?.tag = 13
        self.addSubview(mRightBtn!)
        mRightBtn?.setImage(UIImage.init(named: "zhaohuimima_jiantou")?.imageWithColor(color: UIColor.white), for: UIControl.State.normal)
        mRightBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        
    }
    
    //头像10 姓名11 账号12 箭头13
    @objc func buttonPressed(sender:UIButton){
        delegate?.MineDefaultHeaderBtnClick!(sender: sender, login: login!)
    }
    
    
    ///个人中心顶部视图数据
    private var _dataDict:[NSString:NSString]?
    var dataDict:[NSString:NSString]?{
        didSet{
            _dataDict = dataDict
            
            if(login == false){
                mRightBtn?.isHidden = true
                mHeadImgBtn?.setImage(UIImage.init(named: "touxiang_weidenglu"), for: UIControl.State.normal)
                mNumberBtn?.isHidden = true
                mNameBtn?.centerY = (mHeadImgBtn?.centerY)!
                mNameBtn?.setTitle("未登录", for: UIControl.State.normal)
            }
            else{
               
                mRightBtn?.isHidden = false
                mNumberBtn?.isHidden = false
                mNameBtn?.bottom = (mHeadImgBtn?.centerY)!
                mNumberBtn?.top = (mHeadImgBtn?.centerY)!
                
                let mobile:NSString = "135****3103"
                
                mNameBtn?.setTitle("神经萝卜", for: UIControl.State.normal)
                mNumberBtn?.setTitle(mobile as String, for: UIControl.State.normal)
                mHeadImgBtn?.setBackgroundImage(UIImage.init(named: "touxiang_weidenglu"), for: UIControl.State.normal)
            }

        }
    }
}



/// 我的主页顶部cell
let MineTopCellId          = "MineTopCellId"
let MineTopCellH:CGFloat   = 60

class MineTopCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:MineViewsDelegate?
    
    var button1:UIButton?
    var button2:UIButton?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        let titles:[String] = ["健康卡","优惠券"]
        let iamges:[String] = ["huiyuanka","youhuiquan"]
        let btnWidth:CGFloat = SCREEN_Width * 0.5
        let btnHeight:CGFloat = MineTopCellH
        
        for i:NSInteger in 0...titles.count-1{
            let button = UIButton.init(type: UIButton.ButtonType.custom)
            button.frame = CGRect.init(x: CGFloat(i) * btnWidth, y: 0, width: btnWidth, height: btnHeight)
            button.tag = 100 + i
            button.backgroundColor = UIColor.white
            self.contentView.addSubview(button)
            button.setImage(UIImage.init(named: iamges[i]), for: UIControl.State.normal)
            button.setTitle(titles[i], for: UIControl.State.normal)
            button.setTitleColor(UIColor.hexStringToColor(hexString: "333333"), for: UIControl.State.normal)
            button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
            button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
            if(i==0){
                button1 = button
            }else{
                button2 = button
            }
        }
        
        let centerLine:UIView = UIView.init()
        centerLine.bounds = CGRect.init(x: 0, y: 0, width: 1, height: 26)
        centerLine.centerY = MineTopCellH * 0.5
        centerLine.centerX = SCREEN_Width * 0.5
        centerLine.backgroundColor = UIColor.hexStringToColor(hexString: "E6E6E6")
        self.contentView.addSubview(centerLine)
        
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.MineTopCellBtnClick!(sender: sender)
    }
    
}





/// 我的主页其他的cell
let MineMessageCellId          = "MineMessageCellId"
let MineMessageCellH:CGFloat   = 45

class MineMessageCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //左侧图片
    var mLeftImg:UIImageView?
    //cell标题
    var mTitleLab:UILabel?
    //底部线条
    var mBottomLine:UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        self.detailTextLabel!.font = UIFont.systemFont(ofSize: 14)
        self.detailTextLabel!.textColor = UIColor.gray
        
        mLeftImg = UIImageView.init()
        mLeftImg?.frame = CGRect.init(x: 15, y: 5, width: 20, height: 20)
        mLeftImg?.centerY = MineMessageCellH * 0.5
        self.contentView.addSubview(mLeftImg!)
        
        mTitleLab = UILabel.init()
        mTitleLab?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 80, height: MineMessageCellH)
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.centerY = MineMessageCellH * 0.5
        mTitleLab?.left = (mLeftImg?.right)! + 15
        
        
        mBottomLine = UIView.init()
        mBottomLine?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width-50, height: 0.5)
        mBottomLine?.left = 50
        mBottomLine?.bottom = MineMessageCellH
        mBottomLine?.backgroundColor = UIColor.hexStringToColor(hexString: "E6E6E6")
        self.contentView.addSubview(mBottomLine!)
        
    }
    
    ///个人中心顶部视图数据
    private var _dataDict:NSDictionary?
    var dataDict:NSDictionary?{
        didSet{
            _dataDict = dataDict
            
            mTitleLab?.text = (_dataDict!["title"] as! String)
            mLeftImg?.image = UIImage.init(named: _dataDict!["img"]! as! String)
            let status:NSString = _dataDict!["status"]! as! NSString
            
            if(status.integerValue == 5){
                self.accessoryType = UITableViewCell.AccessoryType.none
                self.detailTextLabel?.text = "4000283020"
            }
            else{
                self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                self.detailTextLabel?.text = ""
            }
        }
    }
}





/// 我的主页其他的cell
let MineSettingCellId          = "MineSettingCellId"
let MineSettingCellH:CGFloat   = 45

class MineSettingCell: UITableViewCell {
    
    //分组
    var indexPath:NSIndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        self.textLabel?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
    }
    
    ///通用的数据设置
    private var _generalString:NSString?
    var generalString:NSString?{
        set{
            _generalString = newValue
            self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            self.textLabel?.text = (_generalString as! String)
            self.textLabel?.textAlignment = NSTextAlignment.left
        }
        get{
            return _generalString
        }
    }
    
    ///个人中心设置界面的数据
    private var _string:String?
    var string:String?{
        didSet{
            _string = string
           
            if(indexPath?.section == 0){
                self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                self.textLabel?.text = _string
                self.textLabel?.textAlignment = NSTextAlignment.left
            }
            else{
                self.accessoryType = UITableViewCell.AccessoryType.none
                self.textLabel?.text = "退出登录"
                self.textLabel?.textAlignment = NSTextAlignment.center
            }
        }
    }
}





/// 个人信息界面头像cell
let MinePersonalImgCellId          = "MinePersonalImgCellId"
let MinePersonalImgCellH:CGFloat   = 60

class MinePersonalImgCell: UITableViewCell {
    
    //分组
    var indexPath:NSIndexPath?
    //头像
    var cellImg:UIImageView?
    //线条
    var line:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        self.textLabel?.font = UIFont.systemFont(ofSize: 16)
        self.textLabel?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.textLabel?.text = "头像"
        
        cellImg = UIImageView.init()
        cellImg?.bounds = CGRect.init(x: 0, y: 0, width: MinePersonalImgCellH - 20, height: MinePersonalImgCellH - 20)
        cellImg?.centerY = MinePersonalImgCellH * 0.5
        cellImg?.right = SCREEN_Width - 40
        self.contentView.addSubview(cellImg!)
        cellImg?.image = UIImage.init(named: "touxiang_weidenglu")
        cellImg?.clipsToBounds = true
        cellImg?.layer.cornerRadius = (cellImg?.height)! * 0.5
        
        line = UIView.init()
        line?.frame = CGRect.init(x: 15, y: MinePersonalImgCellH, width: SCREEN_Width - 15, height: 1)
        line?.backgroundColor = LineColor
        self.contentView.addSubview(line!)
    }
    
    ///个人中心设置界面的数据
    private var _string:String?
    var string:String?{
        didSet{
            _string = string
            
        }
    }
}


/// 个人信息界面头像cell
let MinePersonalCellId          = "MinePersonalCellId"
let MinePersonalCellH:CGFloat   = 50

class MinePersonalCell: UITableViewCell {
    
    //分组
    var indexPath:NSIndexPath?
    //线条
    var line:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        self.textLabel?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.textLabel?.font = UIFont.systemFont(ofSize: 16)
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        self.detailTextLabel?.textColor = UIColor.colorWithRGB(_r: 100, _g: 100, _b: 100)
        
        line = UIView.init()
        line?.frame = CGRect.init(x: 15, y: MinePersonalCellH, width: SCREEN_Width - 15, height: 1)
        line?.backgroundColor = LineColor
        self.contentView.addSubview(line!)
    }
    
    ///个人中心设置界面的数据
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
            
            if(indexPath?.row == 1){
                self.textLabel?.text = "手机号"
                self.detailTextLabel?.text = "135****103"
            }
            else if(indexPath?.row == 2){
                self.textLabel?.text = "昵称"
                self.detailTextLabel?.text = "神经萝卜"
            }
            else{
                self.textLabel?.text = "登录密码"
                self.detailTextLabel?.text = "修改"
            }
        }
    }
}


/// 个人信息界面头像cell
let MineChangPasswordCellId          = "MineChangPasswordCellId"
let MineChangPasswordCellH:CGFloat   = 50

class MineChangPasswordCell: UITableViewCell,UITextFieldDelegate {
    
    //分组
    var indexPath:NSIndexPath?
    //输入框
    var mTextF:UITextField?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        self.accessoryType = UITableViewCell.AccessoryType.none
        
        _style = 0
  
        mTextF = UITextField.init()
        mTextF?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 40, height: MineChangPasswordCellH)
        mTextF?.centerX = SCREEN_Width * 0.5
        mTextF?.centerY = MineChangPasswordCellH * 0.5
        mTextF?.delegate = self
        mTextF?.textAlignment = NSTextAlignment.left
        mTextF?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(mTextF!)
        mTextF?.isUserInteractionEnabled = true
        mTextF?.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n"){
            textField.endEditing(true)
        }
        if(string.count == 0){
            return true
        }
        if(range.location < 16){
            return true
        }
        else{
            return false
        }
    }
    
    //修改登录密码数据0 获取报告数据1  设置新密码2
    private var _style:NSInteger?
    var style:NSInteger?{
        didSet{
            _style = style
            
            mTextF?.isSecureTextEntry = false
            if(_style == 0){
                mTextF?.isSecureTextEntry = true
                if(indexPath?.row == 0){
                    mTextF?.placeholder = "当前密码"
                }
                else if(indexPath?.row == 1){
                    mTextF?.placeholder = "新密码(6-32位字母或数字)"
                }
                else{
                    mTextF?.placeholder = "确认新密码"
                }
            }
            else if(_style == 1){
                if(indexPath?.row == 0){
                    mTextF?.placeholder = "请输入手机号"
                }
                else{
                    mTextF?.placeholder = "请输入领取码"
                }
            }
            //设置新密码
            else if(_style == 2){
                if(indexPath?.row == 0){
                    mTextF?.isSecureTextEntry = false
                    mTextF?.isEnabled = false
                    mTextF?.text = "13540033103"
                }
                else if(indexPath?.row == 0){
                    mTextF?.isSecureTextEntry = true
                    mTextF?.isEnabled = true
                    mTextF?.placeholder = "新密码(6-32位字母或数字)"
                }
                else{
                    mTextF?.isSecureTextEntry = true
                    mTextF?.isEnabled = true
                    mTextF?.placeholder = "确认新密码"
                }
            }
        }
    }
    
    ///个人中心设置界面的数据
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
            
            if(indexPath?.row == 1){
                self.textLabel?.text = "手机号"
                self.detailTextLabel?.text = "135****103"
            }
            else if(indexPath?.row == 2){
                self.textLabel?.text = "昵称"
                self.detailTextLabel?.text = "神经萝卜"
            }
            else{
                self.textLabel?.text = "登录密码"
                self.detailTextLabel?.text = "修改"
            }
        }
    }
}


/// 修改登录密码的header
let MineChangPasswordHeaderH:CGFloat   = 150

class MineChangPasswordHeader: UIView {
    
    var mLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BackGroundColor
        
        let string:String = "请设置登录密码。你可以用中医大健康绑定的帐号+密码登录，比如使用手机号+密码登录中医大健康，更快捷。"
        let paragraphString = NSMutableParagraphStyle()
        paragraphString.lineSpacing = 4
        let attbutes = [NSAttributedString.Key.paragraphStyle:paragraphString]
        
        mLabel = UILabel.init()
        mLabel?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 30, height: 100)
        mLabel?.font = UIFont.systemFont(ofSize: 14)
        mLabel?.textAlignment = NSTextAlignment.left
        mLabel?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.addSubview(mLabel!)
        mLabel?.numberOfLines = 0
        mLabel?.centerY = MineMessageCellH * 0.5
        mLabel?.attributedText = NSAttributedString.init(string: string as String, attributes: attbutes)
        mLabel?.sizeToFit()
        mLabel?.centerX = SCREEN_Width * 0.5
        mLabel?.top = 20
        
        self.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: (mLabel?.bottom)! + 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




/// 修改登录密码的header
let MineChangPasswordBottomH:CGFloat  = 130

class MineChangPasswordBottom: UIView {
    
    weak var delegate:MineViewsDelegate?
    
    var mLabel:UILabel?
    //确定
    var mButton:UIButton?
    //未设置或忘记旧密码？
    var mButton2:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BackGroundColor
        
        let string:String = "请设置登录密码。你可以用中医大健康绑定的帐号+密码登录，比如使用手机号+密码登录中医大健康，更快捷。"
        let paragraphString = NSMutableParagraphStyle()
        paragraphString.lineSpacing = 4
        let attbutes = [NSAttributedString.Key.paragraphStyle:paragraphString]
        
        mLabel = UILabel.init()
        mLabel?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 30, height: 40)
        mLabel?.font = UIFont.systemFont(ofSize: 14)
        mLabel?.textAlignment = NSTextAlignment.left
        mLabel?.textColor = UIColor.hexStringToColor(hexString: "999999")
        self.addSubview(mLabel!)
        mLabel?.numberOfLines = 0
        mLabel?.centerY = MineMessageCellH * 0.5
        mLabel?.attributedText = NSAttributedString.init(string: string as String, attributes: attbutes)
        mLabel?.sizeToFit()
        mLabel?.centerX = SCREEN_Width * 0.5
        mLabel?.top = 20
        mLabel?.isHidden = true
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        mButton?.bounds = CGRect.init(x: 0, y: 0, width: LoginBtnWidth, height: LoginBtnHeight)
        mButton?.centerX = SCREEN_Width * 0.5
        mButton?.centerY = self.height * 0.5
        mButton?.tag = 100
        mButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        mButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mButton?.setTitle("确认修改", for: UIControl.State.normal)
        self.addSubview(mButton!)
        mButton?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mButton!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        
        mButton2 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton2?.bounds = CGRect.init(x: 0, y: 0, width: 200, height: 30)
        mButton2?.centerX = SCREEN_Width * 0.5
        mButton2?.top = (mButton?.bottom)!
        mButton2?.tag = 101
        mButton2?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton2?.setTitleColor(TitleColor, for: UIControl.State.normal)
        mButton2?.setTitle("未设置或忘记旧密码？", for: UIControl.State.normal)
        self.addSubview(mButton2!)
        mButton2?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton2?.isHidden = true

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //确定100 忘记密码101
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.MineChangPasswordBottomBtnClick!(sender: sender)
    }
    
    //修改密码0   隐私1   获取报告数据2  设置新密码3
    private var _style:NSInteger?
    var style:NSInteger?{
        didSet{
            _style = style
            if(style == 0){
                mButton2?.isHidden = false
                
            }
        }
    }
    
}


/// 消息列表的cell
let MineMessageListHeaderId = "MineMessageListHeaderId"
let MineMessageListHeaderH:CGFloat  =  50

class MineMessageListHeader: UITableViewHeaderFooterView {
    
    //分组
    var section:NSInteger?
    
    //消息时间
    var mTimeLab:UILabel?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        self.backgroundView?.backgroundColor = BackGroundColor
        
        mTimeLab = UILabel.init()
        mTimeLab?.textAlignment = NSTextAlignment.center
        mTimeLab?.font = UIFont.systemFont(ofSize: 12)
        mTimeLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        self.contentView.addSubview(mTimeLab!)
        mTimeLab?.text = "2018-02-11 12:33"
        mTimeLab?.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_Width * 0.5)
            make.centerY.equalTo(MineMessageListHeaderH * 0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/// 消息列表的cell
let MineMessageListCellId = "MineMessageListCellId"
let MineMessageListCellH:CGFloat  =  100

class MineMessageListCell: UITableViewCell {
    
    //分组
    var indexPath:NSIndexPath?
    //白色背景
    var mBackView:UIView?
    //标题
    var mMsgLab:UILabel?
    //详情
    var mDetailLab:UILabel?
    //是否已读的圆点
    var mRedView:UIView?
 

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        self.backgroundView?.backgroundColor = BackGroundColor
        
        mBackView = UIView.init()
        mBackView?.frame = CGRect.init(x: 15, y: 0, width: SCREEN_Width  - 30, height: MineMessageListCellH)
        mBackView?.backgroundColor = UIColor.white
        mBackView?.clipsToBounds = true
        mBackView?.layer.cornerRadius = 4
        self.contentView.addSubview(mBackView!)
       
        mMsgLab = UILabel.init()
        mMsgLab?.textAlignment = NSTextAlignment.left
        mMsgLab?.font = UIFont.systemFont(ofSize: 16)
        mMsgLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mBackView?.addSubview(mMsgLab!)
        
        mDetailLab = UILabel.init()
        mDetailLab?.textAlignment = NSTextAlignment.left
        mDetailLab?.font = UIFont.systemFont(ofSize: 14)
        mDetailLab?.numberOfLines = 0
        mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "666666")
        mBackView?.addSubview(mDetailLab!)
        
        mRedView = UIView.init()
        mBackView?.addSubview(mRedView!)
        mRedView?.backgroundColor = UIColor.hexStringToColor(hexString: "FF6262")
        mRedView?.bounds = CGRect.init(x: 0, y: 0, width: 8, height: 8)
        mRedView?.right = (mBackView?.width)! - 10
        mRedView?.top = 10
        mRedView?.clipsToBounds = true
        mRedView?.layer.cornerRadius = (mRedView?.height)! * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //消息列表的数据
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
            
            mBackView?.snp.makeConstraints({ (make) in
                make.top.equalTo(contentView)
                make.left.equalTo(15)
                make.right.equalTo(-15)
                make.bottom.equalTo(contentView)
            })
            
            mMsgLab?.text = "体检预约"
            mMsgLab?.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.equalTo(15)
            })
            
            mDetailLab?.text = "您为家人神经萝卜已成功预约2019-01-12日的体检，请按时前往！"
            mDetailLab?.snp.makeConstraints({ (make) in
                make.top.equalTo((mMsgLab?.snp.bottom)!).offset(10)
                make.left.equalTo(15)
                make.width.equalTo(SCREEN_Width - 60)
                make.bottom.equalTo(-15)
            })
         
            
        }
    }
    
}






/// 消息列表的cell
let MineVipCardCellId = "MineVipCardCellId"
let MineVipCardCellH:CGFloat  =  (SCREEN_Width - 30) * 480/1041 + 30

class MineVipCardCell: UITableViewCell {
    
    weak var delegate:MineViewsDelegate?
    
    //分组
    var indexPath:NSIndexPath?
    //背景卡片
    var mBackImgView:UIImageView?
    //卡号
    var mNumberLab:UILabel?
    //可用
    var mKeyongLab:UILabel?
    //金额
    var mPriceLab:UILabel?
    //时间
    var mTimeLab:UILabel?
    //右侧二维码的按钮
    var mCodeBtn:UIButton?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.backgroundView?.backgroundColor = UIColor.white
        
        mBackImgView = UIImageView.init()
        mBackImgView?.clipsToBounds = true
        mBackImgView?.layer.cornerRadius = 8
        self.contentView.addSubview(mBackImgView!)
        mBackImgView?.image = UIImage.init(named: "likabg")
        mBackImgView?.isUserInteractionEnabled = true
        mBackImgView?.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(20)
            make.height.equalTo(MineVipCardCellH - 30)
        }
        
        
        mNumberLab = UILabel.init()
        mNumberLab?.textAlignment = NSTextAlignment.left
        mNumberLab?.font = UIFont.systemFont(ofSize: 24)
        mNumberLab?.textColor = UIColor.hexStringToColor(hexString: "FFD9C3")
        mBackImgView?.addSubview(mNumberLab!)
        mNumberLab?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        
        
        mPriceLab = UILabel.init()
        mPriceLab?.textAlignment = NSTextAlignment.left
        mPriceLab?.font = UIFont.systemFont(ofSize: NSObject.getNumber(i5: 16, i6: 18, iPlus: 20, iPX: 20))
        mPriceLab?.textColor = UIColor.hexStringToColor(hexString: "FFFFFF")
        mBackImgView?.addSubview(mPriceLab!)
        mPriceLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(18)
            make.bottom.equalTo(-NSObject.getNumber(i5: 12, i6: 15, iPlus: 15, iPX: 15))
        })
        
        mKeyongLab = UILabel.init()
        mKeyongLab?.textAlignment = NSTextAlignment.left
        mKeyongLab?.font = UIFont.systemFont(ofSize: 12)
        mKeyongLab?.textColor = UIColor.hexStringToColor(hexString: "FFFFFF")
        mBackImgView?.addSubview(mKeyongLab!)
        mKeyongLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(18)
            make.bottom.equalTo((mPriceLab?.snp.top)!).offset(-(NSObject.getNumber(i5: 3, i6: 4, iPlus: 4, iPX: 4)))
        })
        
        mTimeLab = UILabel.init()
        mTimeLab?.textAlignment = NSTextAlignment.left
        mTimeLab?.font = UIFont.systemFont(ofSize: 12)
        mTimeLab?.textColor = UIColor.white
        mBackImgView?.addSubview(mTimeLab!)
        mTimeLab?.snp.makeConstraints({ (make) in
            make.right.equalTo(-18)
            make.centerY.equalTo(mPriceLab!)
        })
        
        mCodeBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mCodeBtn?.bounds = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        mBackImgView?.addSubview(mCodeBtn!)
        mCodeBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mCodeBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(mBackImgView!)
            make.centerY.equalToSuperview()
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //点击卡片右侧二维码
    @objc func buttonPressed(sender:UIButton){
        delegate?.MineVipCardCellBtnClick!(indexPath: indexPath!, sender: sender)
    }
    
    //健康卡列表的数据
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
          
            mNumberLab?.text = "NO:567 4563"
            mPriceLab?.text = "9980.00"
            mKeyongLab?.text = "可用余额>"
            mTimeLab?.text = "绑定日期：2018-09-11"
            
        }
    }
    
}



///会员卡弹窗扫码
let MineVipCodeWindowW:CGFloat = 298
let MineVipCodeWindowH:CGFloat = 443

class MineVipCodeWindow: UIImageView {
    
    weak var delegate:MineViewsDelegate?
    
    //卡号
    var number:NSInteger?
    
    //标题
    var mTitleLab:UILabel?
    //卡号
    var mNumberLab:UILabel?
    //条形码
    var barCodeImgView:UIImageView?
    //二维码
    var qrCodeImgView:UIImageView?
    //底部线条
    var mLine:UILabel?
    //底部提示
    var mBottomLab:UILabel?
    //叉叉按钮
    var mCloseBtn:UIButton?
    
    
    init(frame: CGRect, number:NSString) {
        super.init(frame: frame)
        self.image = UIImage.init(named: "erweimabg")
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.center
        mTitleLab?.textColor = UIColor.white
        self.addSubview(mTitleLab!)
        mTitleLab?.text = "成都中医大健康管理中心会员卡"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(40)
        })
        
        
        let string:NSString = number.getStringWithInterval(number: 4)
        
        mNumberLab = UILabel.init()
        mNumberLab?.font = UIFont.systemFont(ofSize: 20)
        mNumberLab?.textAlignment = NSTextAlignment.center
        mNumberLab?.textColor = UIColor.white
        self.addSubview(mNumberLab!)
        mNumberLab?.text = string as String
        mNumberLab?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo((mTitleLab?.snp.bottom)!).offset(10)
        })
        
        
        mBottomLab = UILabel.init()
        mBottomLab?.font = UIFont.systemFont(ofSize: 13)
        mBottomLab?.textAlignment = NSTextAlignment.center
        mBottomLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        self.addSubview(mBottomLab!)
        mBottomLab?.text = "前台消费时，请出示此码"
        mBottomLab?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-15)
        })
        
        
        let image1 = UIImage.barcodeImageWithContent(messgae: number, width: 240, height: 64)
        
        barCodeImgView = UIImageView.init()
        self.addSubview(barCodeImgView!)
        barCodeImgView?.image = image1
        barCodeImgView?.snp.makeConstraints { (make) in
            make.width.equalTo(240)
            make.height.equalTo(64)
            make.centerX.equalToSuperview()
            make.top.equalTo(158)
        }
        
        let image2 = UIImage.qrCodeImageWithContent(qrString: number as String, size: 120)
        
        qrCodeImgView = UIImageView.init()
        self.addSubview(qrCodeImgView!)
        qrCodeImgView?.image = image2
        qrCodeImgView?.snp.makeConstraints { (make) in
            make.width.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-75)
        }
        
        
        mCloseBtn = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mCloseBtn!)
        mCloseBtn?.setImage(UIImage.init(named: "tankuang_guanbi"), for: UIControl.State.normal)
        mCloseBtn?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(MineVipCodeWindowH + 30)
            make.centerX.equalToSuperview()
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
}



//添加会员卡
let MineAddVipCardViewH:CGFloat  =  80

class MineAddVipCardView: UIView {
    
    weak var delegate:MineViewsDelegate?
    
    //背景视图
    var mBackView:UIView?
    //左侧加号
    var mLeftIcon:UIImageView?
    //右侧箭头
    var mRightIcon:UIImageView?
    //标题
    var mTitleLab:UILabel?
    //按钮
    var mButton:UIButton?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        mBackView = UIView.init()
        mBackView?.backgroundColor = UIColor.hexStringToColor(hexString: "EAEAEA")
        self.addSubview(mBackView!)
        mBackView?.clipsToBounds = true
        mBackView?.layer.cornerRadius = 4
        mBackView?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 30)
            make.height.equalTo(44)
            make.center.equalToSuperview()
        })
        
        
        mLeftIcon = UIImageView.init()
        mLeftIcon?.clipsToBounds = true
        mLeftIcon?.layer.cornerRadius = (mLeftIcon?.height)! * 0.5
        mLeftIcon?.image = UIImage.init(named: "tianjialika")
        mLeftIcon?.isUserInteractionEnabled = true
        mBackView!.addSubview(mLeftIcon!)
        mLeftIcon?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(20)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mTitleLab = UILabel.init()
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mBackView?.addSubview(mTitleLab!)
        mTitleLab?.text = "添加健康卡"
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo((mLeftIcon?.snp.right)!).offset(10)
            make.centerY.equalToSuperview()
        })
        
        
        mRightIcon = UIImageView.init()
        mRightIcon?.clipsToBounds = true
        mRightIcon?.layer.cornerRadius = (mLeftIcon?.height)! * 0.5
        mRightIcon?.image = UIImage.init(named: "zhaohuimima_jiantou")
        mRightIcon?.isUserInteractionEnabled = true
        mBackView!.addSubview(mRightIcon!)
        mRightIcon?.snp.makeConstraints({ (make) in
            make.width.equalTo(7)
            make.height.equalTo(14)
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        })
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mButton!)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(mBackView!)
            make.top.left.equalTo(0)
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加按钮点击
    @objc func buttonPressed(sender:UIButton){
        delegate?.MineAddVipCardViewBtnClick!(sender: sender)
    }
    
}






/// 健康卡详情header
let MineVipCodeDetHeaderH:CGFloat = 240

class MineVipCodeDetHeader: UIView {
    
    
    //白色背景图
    var mBackView:UIView?
    //阴影视图
    var showView1:UIView?
    //皇冠图标
    var mImgView:UIImageView?
    //标题
    var mTitleLab:UILabel?
    //卡号
    var mNumberLab:UILabel?
    //线条
    var mLine:UIView?
    //价格
    var mPriceLab:UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BackGroundColor
        
        mBackView = UIView.init()
        mBackView?.clipsToBounds = true
        mBackView?.layer.cornerRadius = 5
        self.addSubview(mBackView!)
        mBackView?.backgroundColor = UIColor.white
        mBackView?.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_Width - 30)
            make.height.equalTo(212)
            make.centerX.equalToSuperview()
            make.top.equalTo(18)
        }
        
        
        showView1 = UIView.init()
        showView1?.backgroundColor = UIColor.black
        showView1?.layer.shadowColor = UIColor.colorWithRGB(_r: 35, _g: 67, _b: 62).cgColor
        showView1?.layer.shadowOffset = CGSize.init(width: 0, height: 10)
        showView1?.layer.shadowOpacity = 0.8;
        showView1?.layer.shadowRadius = 12;
        mBackView?.addSubview(showView1!)
        showView1?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(20)
            make.top.equalTo(35)
            make.centerX.equalToSuperview()
        })
        
        
        mImgView = UIImageView.init()
        mImgView?.clipsToBounds = true
        mImgView?.layer.cornerRadius = (mImgView?.height)! * 0.5
        mBackView?.addSubview(mImgView!)
        mImgView?.image = UIImage.init(named: "huiyuanka_xiangqing")
        mImgView?.isUserInteractionEnabled = true
        mImgView?.snp.makeConstraints { (make) in
            make.width.height.equalTo(55)
            make.center.equalTo(showView1!)
        }
        
        
        mTitleLab = UILabel.init()
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mBackView?.addSubview(mTitleLab!)
        mTitleLab?.text = "会员卡"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo((mImgView?.snp.bottom)!).offset(12)
        })
        
        
        let number:NSString = "5674563"
        let string = number.getStringWithInterval(number:4)
        
        mNumberLab = UILabel.init()
        mNumberLab?.textAlignment = NSTextAlignment.left
        mNumberLab?.font = UIFont.systemFont(ofSize: 18)
        mNumberLab?.textColor = UIColor.hexStringToColor(hexString: "4A4A4A")
        mBackView?.addSubview(mNumberLab!)
        mNumberLab?.text = string as String
        mNumberLab?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo((mTitleLab?.snp.bottom)!).offset(3)
        })
        
        
        mLine = UIView.init()
        mBackView?.addSubview(mLine!)
        mLine?.backgroundColor = LineColor
        mLine?.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(1)
            make.bottom.equalTo(-55)
        }
        
        
        mPriceLab = UILabel.init()
        mPriceLab?.textAlignment = NSTextAlignment.left
        mPriceLab?.font = UIFont.systemFont(ofSize: 20)
        mPriceLab?.textColor = UIColor.hexStringToColor(hexString: "FFAF00")
        mBackView?.addSubview(mPriceLab!)
        mPriceLab?.text = "可用余额：￥989.00"
        mPriceLab?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-15)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





/// 健康卡详情cell
let MineVipCardDetCellId = "MineVipCardDetCellId"
let MineVipCardDetCellH:CGFloat = 45

class MineVipCardDetCell: UITableViewCell {
    
    //分组
    var indexPath:IndexPath?
    //白色背景
    var mBackView:UIView?
    //左侧标题
    var mTitleLab:UILabel?
    //右侧详情
    var mDetialLab:UILabel?
    //右侧箭头
    var mRightIcon:UIImageView?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        self.contentView.backgroundColor = BackGroundColor
        
        mBackView = UIView.init()
        mBackView?.clipsToBounds = true
        mBackView?.layer.cornerRadius = 4
        contentView.addSubview(mBackView!)
        mBackView?.backgroundColor = UIColor.white
        mBackView?.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_Width - 30)
            make.height.equalTo(MineVipCardDetCellH - 0.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(0)
        }
        
        
        mTitleLab = UILabel.init()
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mBackView?.addSubview(mTitleLab!)
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        mDetialLab = UILabel.init()
        mDetialLab?.textAlignment = NSTextAlignment.left
        mDetialLab?.font = UIFont.systemFont(ofSize: 14)
        mDetialLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mBackView?.addSubview(mDetialLab!)
        mDetialLab?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        })
        
        
       
        mRightIcon = UIImageView.init()
        mBackView?.addSubview(mRightIcon!)
        mRightIcon?.image = UIImage.init(named: "zhaohuimima_jiantou")
        mRightIcon?.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(14)
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //健康卡详情数据
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
            
            if(indexPath?.row == 0){
                mRightIcon?.isHidden = true
                mTitleLab?.text = "绑定手机号"
                mDetialLab?.text = "13540033103"
            }
            else if(indexPath?.row == 1){
                mRightIcon?.isHidden = true
                mTitleLab?.text = "绑定日期"
                mDetialLab?.text = "2018-09-11"
            }
            else if(indexPath?.row == 2){
                mRightIcon?.isHidden = false
                mTitleLab?.text = "修改密码"
                mDetialLab?.text = ""
            }
            else{
                mRightIcon?.isHidden = false
                mTitleLab?.text = "交易记录"
                mDetialLab?.text = ""
            }
        }
    }
}



/// 优惠券顶部优惠码输入框
let MineVouchersListTopViewH:CGFloat = 60

class MineVouchersListTopView: UIView {
    
    weak var delegate:MineViewsDelegate?
    
    //左侧背景和输入框
    var mLeftImgView:UIImageView?
    var mTextF:UITextField?
    //右侧按钮
    var mRightBtn:UIButton?
    //左侧扫描
    var mLeftBtn:UIButton?
    var mLine:UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        mRightBtn = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mRightBtn!)
        mRightBtn?.tag = 10
        mRightBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mRightBtn?.backgroundColor = TitleColor
        mRightBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mRightBtn?.setTitle("兑换", for: UIControl.State.normal)
        mRightBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(70)
            make.height.equalTo(40)
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        })
        
        
        
        mLeftImgView = UIImageView.init()
        mLeftImgView?.backgroundColor = BackGroundColor
        mLeftImgView?.isUserInteractionEnabled = true
        self.addSubview(mLeftImgView!)
        mLeftImgView?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width-30-70-55)
            make.height.equalTo(40)
            make.right.equalTo((mRightBtn?.snp.left)!)
            make.centerY.equalToSuperview()
        })
        
        
        mTextF = UITextField.init()
        mTextF?.text = "请输入兑换码"
        mTextF?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mTextF?.font = UIFont.systemFont(ofSize: 16)
        mLeftImgView?.addSubview(mTextF!)
        mTextF?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(17.5)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        
        
        
        mRightBtn = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mRightBtn!)
        mRightBtn?.tag = 11
        mRightBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mRightBtn?.backgroundColor = UIColor.white
        mRightBtn?.setImage(UIImage.init(named: "saoyisao"), for: UIControl.State.normal)
        mRightBtn?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(40)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        mLine = UIView.init()
        mLine?.backgroundColor = LineColor
        self.addSubview(mLine!)
        mLine?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //兑换10  扫描11
    @objc func buttonPressed(sender:UIButton){
        delegate?.MineVouchersListTopViewBtnClick!(sender: sender, string: "")
    }
}
