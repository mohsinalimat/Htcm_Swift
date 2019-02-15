//
//  HealthViews.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/21.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit


@objc protocol HealthViewsDelegate:NSObjectProtocol {
   
    //健康列表家人cell按钮点击代理协议
    @objc optional func HealthFamilyCellBtnClick(indexPath:NSIndexPath, sender:UIButton)
    
    //健康列表家人底部添加按钮点击代理协议
    @objc optional func HealthFamilyBottomBtnClick(sender:UIButton)
    
    //健康家人详情的设置默认和编辑
    @objc optional func HealthFamilyDetailBottomViewBtnClick(sender:UIButton)
}



/// 健康列表家人cell
let HealthFamilyCellH:CGFloat = 120.0
let HealthFamilyCellId = "HealthFamilyCellId"

class HealthFamilyCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:HealthViewsDelegate?
    //分组
    var indexPath:NSIndexPath?
    
    //背景图
    var mCardImg:UIImageView?
    //头像
    var mHeaderImg:UIImageView?
    //名称
    var mNamelab:UILabel?
    //关系
    var mRelationshipLab:UILabel?
    //卡号
    var mNumberLab:UILabel?
    //二维码
    var mCodeBtn:UIButton?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        self.contentView.backgroundColor = BackGroundColor
        
        mCardImg = UIImageView.init()
        mCardImg?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: HealthFamilyCellH)
        mCardImg?.top = 5
        mCardImg?.centerX = SCREEN_Width * 0.5
        self.contentView.addSubview(mCardImg!)
        mCardImg?.image = UIImage.init(named: "jiankangtabliebiao")
        mCardImg?.backgroundColor = BackGroundColor
        mCardImg?.isUserInteractionEnabled = true
        
        mHeaderImg = UIImageView.init()
        mHeaderImg?.bounds = CGRect.init(x: 0, y: 0, width: 48, height: 48)
        mHeaderImg?.left = 29 + NSObject.getNumber(i5: 2, i6: 12, iPlus: 14, iPX: 8)
        mHeaderImg?.centerY = (mCardImg?.height)! * 0.5 - NSObject.getNumber(i5: 2, i6: 2, iPlus: 3, iPX: 2)
        mCardImg?.addSubview(mHeaderImg!)
        mHeaderImg?.clipsToBounds = true
        mHeaderImg?.layer.cornerRadius = (mHeaderImg?.height)! * 0.5
        
        mNamelab =  UILabel.init()
        mNamelab?.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 20)
        mNamelab?.font = UIFont.systemFont(ofSize: 20)
        mNamelab?.textAlignment = NSTextAlignment.left
        mNamelab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mCardImg?.addSubview(mNamelab!)
        
        mRelationshipLab = UILabel.init()
        mRelationshipLab?.bounds = CGRect.init(x: 0, y: 0, width: 36, height: 16)
        mCardImg?.addSubview(mRelationshipLab!)
        mRelationshipLab?.textAlignment = NSTextAlignment.center
        mRelationshipLab?.backgroundColor = UIColor.colorWithRGB(_r: 251, _g: 188, _b: 54)
        mRelationshipLab?.textColor = UIColor.white
        mRelationshipLab?.font = UIFont.systemFont(ofSize: 10)
        mRelationshipLab?.clipsToBounds = true
        
        mCodeBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mCodeBtn?.bounds = CGRect.init(x: 0, y: 0, width: 32, height: 32)
        mCodeBtn?.right = (mCardImg?.width)! - 26
        mCodeBtn?.centerY = (mHeaderImg?.centerY)!
        mCodeBtn?.tag = 10
        mCardImg?.addSubview(mCodeBtn!)
        mCodeBtn?.setBackgroundImage(UIImage.init(named: "jiankangerweima"), for: UIControl.State.normal)
        mCodeBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        
        let numWidth = (mCardImg?.width)! - (mNamelab?.left)! - ((mCardImg?.width)! - (mCodeBtn?.left)!) - 20
        mNumberLab = UILabel.init()
        mNumberLab?.bounds = CGRect.init(x: 0, y: 0, width: numWidth, height: 20)
        mNumberLab?.font = UIFont.systemFont(ofSize: 16)
        mNumberLab?.textAlignment = NSTextAlignment.left
        mNumberLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mCardImg?.addSubview(mNumberLab!)
        
        
    }
    
    //按钮点击
    @objc func buttonPressed(sender:UIButton){
        
        
    }
    
    ///首页数据
    private var _healthDict:[NSString:NSInteger]?
    var healthDict:[NSString:NSInteger]?{
        didSet{
            _healthDict = healthDict
          
            mHeaderImg?.image = UIImage.init(named: "touxiang_weidenglu")
            
            
            mNamelab?.text = "神经萝卜"
            mNamelab?.sizeToFit()
            mNamelab?.top = 34
            mNamelab?.left = (mHeaderImg?.right)! + 10
            let Width:CGFloat = (mCardImg?.width)! - (mHeaderImg?.right)! - (mCodeBtn?.width)! - (mRelationshipLab?.width)! - 100
            if((mNamelab?.width)! > Width){
                mNamelab?.width = Width
            }
            
            mRelationshipLab?.text = "本人"
            mRelationshipLab?.sizeToFit()
            mRelationshipLab?.height = 16
            mRelationshipLab?.width += 12
            if((mRelationshipLab?.width)! > 50){
                mRelationshipLab?.width = 50
            }
            mRelationshipLab?.left = (mNamelab?.right)! + 5
            mRelationshipLab?.centerY = (mNamelab?.centerY)!
            mRelationshipLab?.layer.cornerRadius = (mRelationshipLab?.height)! * 0.5
            
            
            mNumberLab?.text = "208484934939434"
            mNumberLab?.sizeToFit()
            mNumberLab?.left = (mNamelab?.left)!
            mNumberLab?.top = (mRelationshipLab?.bottom)! + 8
            let numberWidth = (mCardImg?.width)! - (mHeaderImg?.right)! - (mCodeBtn?.width)! - (mRelationshipLab?.width)! - 50
            if((mNumberLab?.width)! > numberWidth){
                mNumberLab?.width = (mCardImg?.width)! - (mHeaderImg?.right)! - (mCodeBtn?.width)! - 40
            }
        }
    }
    
    
}



//家人列表的底部添加按钮
let HealthFamilyBottomFooterH = 80

class HealthFamilyBottomFooter: UIView {
    
    weak var delegate:HealthViewsDelegate?
    var mButton:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BackGroundColor
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        mButton?.tag = 10
        self.addSubview(mButton!)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton?.setTitle("添加家人", for: UIControl.State.normal)
        mButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mButton?.clipsToBounds = true
        mButton?.layer.cornerRadius = 22
        mButton?.backgroundColor = TitleColor
        mButton?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.width.equalTo(SCREEN_Width - 60)
            make.height.equalTo(44)
        })
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //添加家人
    @objc func buttonPressed(sender:UIButton){
        delegate?.HealthFamilyBottomBtnClick!(sender: sender)
    }
    
}



/// 健康列表家人cell
let HealthFamilyListCellH:CGFloat = 120.0
let HealthFamilyListCellId = "HealthFamilyListCellId"

class HealthFamilyListCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:HealthViewsDelegate?
    //分组
    var indexPath:NSIndexPath?
    //背景图
    var mCardImg:UIImageView?
    //头像
    var mHeaderImg:UIImageView?
    //名称
    var mNamelab:UILabel?
    //手机号
    var mPhoneLab:UILabel?
    //家人关系
    var mRelationshipTextView:UITextView?
    //卡号
    var mNumberLab:UILabel?
    //二维码
    var mCodeImg:UIImageView?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        self.contentView.backgroundColor = BackGroundColor
        
        
        mCardImg = UIImageView.init()
        self.contentView.addSubview(mCardImg!)
        mCardImg?.image = UIImage.imageFromColor(color: UIColor.white)
        mCardImg?.backgroundColor = BackGroundColor
        mCardImg?.isUserInteractionEnabled = true
        mCardImg?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 30)
            make.height.equalTo(HealthFamilyListCellH - 20)
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
        })
        
        
        mHeaderImg = UIImageView.init()
        mCardImg?.addSubview(mHeaderImg!)
        mHeaderImg?.clipsToBounds = true
        mHeaderImg?.layer.cornerRadius = 30
        mHeaderImg?.image = UIImage.init(named: ImagePlaceHoder6)
        mHeaderImg?.image = UIImage.init(named: "touxiang_weidenglu")
        mHeaderImg?.snp.makeConstraints({ (make) in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        })
        
        
        mNamelab =  UILabel.init()
        mNamelab?.font = UIFont.boldSystemFont(ofSize: 16)
        mNamelab?.textAlignment = NSTextAlignment.left
        mNamelab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mCardImg?.addSubview(mNamelab!)
        mNamelab?.isUserInteractionEnabled = true
        mNamelab?.text = "神经萝卜"
        mNamelab?.snp.makeConstraints({ (make) in
            make.top.equalTo((mHeaderImg?.snp.top)!).offset(3)
            make.left.equalTo((mHeaderImg?.snp.right)!).offset(5)
        })
        
        
        
        mPhoneLab =  UILabel.init()
        mPhoneLab?.font = UIFont.systemFont(ofSize: 12)
        mPhoneLab?.textAlignment = NSTextAlignment.left
        mPhoneLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mCardImg?.addSubview(mPhoneLab!)
        mPhoneLab?.isUserInteractionEnabled = true
        mPhoneLab?.text = "138****8000"
        mPhoneLab?.snp.makeConstraints({ (make) in
            make.top.equalTo((mNamelab?.snp.bottom)!).offset(5)
            make.left.equalTo(mNamelab!)
            
        })
    
        
        mNumberLab = UILabel.init()
        mNumberLab?.font = UIFont.systemFont(ofSize: 12)
        mNumberLab?.textAlignment = NSTextAlignment.left
        mNumberLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mNumberLab?.isUserInteractionEnabled = true
        mCardImg?.addSubview(mNumberLab!)
        mNumberLab?.text = "42342253253252353453252"
        mNumberLab?.snp.makeConstraints({ (make) in
            make.top.equalTo((mPhoneLab?.snp.bottom)!).offset(3)
            make.left.equalTo(mNamelab!)
        })
        
        
        let size:CGSize = NSString.getTextSize(text: "本人", font: UIFont.systemFont(ofSize: 10), maxSize: CGSize.init(width: 65, height: 16))
        
        mRelationshipTextView = UITextView.init()
        mCardImg?.addSubview(mRelationshipTextView!)
        mRelationshipTextView?.textAlignment = NSTextAlignment.center
        mRelationshipTextView?.backgroundColor = UIColor.colorWithRGB(_r: 251, _g: 188, _b: 54)
        mRelationshipTextView?.textColor = UIColor.white
        mRelationshipTextView?.font = UIFont.systemFont(ofSize: 10)
        mRelationshipTextView?.clipsToBounds = true
        mRelationshipTextView?.layer.cornerRadius = 8
        mRelationshipTextView!.textContainerInset = UIEdgeInsets.init(top: 2, left: 0, bottom: 0, right: 0)
        mRelationshipTextView?.text = "本人"
        mRelationshipTextView?.snp.makeConstraints({ (make) in
            make.width.equalTo(size.width + 12)
            make.height.equalTo(16)
            make.centerY.equalTo(mNamelab!)
            make.left.equalTo((mNamelab?.snp.right)!).offset(5)
        })
        
        
        mCodeImg = UIImageView.init()
        mCodeImg?.image = UIImage.init(named: "jiankangerweima")
        mCardImg!.addSubview(mCodeImg!)
        mCardImg?.isUserInteractionEnabled = true
        mCodeImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(32)
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        })
        
        
    }
    
    //按钮点击
    @objc func buttonPressed(sender:UIButton){
        
        
    }
    
    ///首页数据
    private var _healthDict:[NSString:NSInteger]?
    var healthDict:[NSString:NSInteger]?{
        didSet{
            _healthDict = healthDict
            
            
        }
    }
    
}



///家人详情的设置默认和 编辑
let HealthFamilyDetailBottomViewH:CGFloat = 130

class HealthFamilyDetailBottomView: UIView {
    
    
    weak var delegate:HealthViewsDelegate?
    var mButton1:UIButton?
    var mButton2:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BackGroundColor
        
        
        mButton1 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton1?.tag = 10
        self.addSubview(mButton1!)
        mButton1?.setTitle("设置默认就诊人", for: UIControl.State.normal)
        mButton1?.setTitleColor(TitleColor, for: UIControl.State.normal)
        mButton1?.layer.borderColor = UIColor.colorWithRGB(_r: 204, _g: 204, _b: 204).cgColor
        mButton1?.layer.borderWidth = 1
        mButton1?.clipsToBounds = true
        mButton1?.layer.cornerRadius = 3
        mButton1?.backgroundColor = UIColor.white
        mButton1?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton1?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(SCREEN_Width - 60)
            make.height.equalTo(44)
            make.top.equalTo(20)
        })
        
        
        
        mButton2 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton2?.tag = 11
        self.addSubview(mButton2!)
        mButton2?.setTitle("编辑家人信息", for: UIControl.State.normal)
        mButton2?.setTitleColor(TitleColor, for: UIControl.State.normal)
        mButton2?.layer.borderColor = UIColor.colorWithRGB(_r: 204, _g: 204, _b: 204).cgColor
        mButton2?.layer.borderWidth = 1
        mButton2?.clipsToBounds = true
        mButton2?.layer.cornerRadius = 3
        mButton2?.backgroundColor = UIColor.white
        mButton2?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton2?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(SCREEN_Width - 60)
            make.height.equalTo(44)
            make.top.equalTo((mButton1?.snp.bottom)!).offset(10)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //按钮点击
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.HealthFamilyDetailBottomViewBtnClick!(sender: sender)
    }
}



/// 健康家人管理详情cell1 标题和详情都在左侧
let HealthFamilyDetCell1Id = "HealthFamilyDetCell1Id"
let HealthFamilyDetCell1H:CGFloat = 60

class HealthFamilyDetCell1: UITableViewCell {
    
    
    var mTitleLab:UILabel?
    var mDetLab:UILabel?
    var certificationImg:UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.text = "健康卡："
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mDetLab = UILabel.init()
        mDetLab?.font = UIFont.systemFont(ofSize: 16)
        mDetLab?.textAlignment = NSTextAlignment.right
        mDetLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mDetLab!)
        mDetLab?.text = "408348239234223"
        mDetLab?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo((mTitleLab?.snp.right)!).offset(10)
        })
        
        
        
        certificationImg = UIImageView.init()
        self.addSubview(certificationImg!)
        certificationImg?.isUserInteractionEnabled = true
        certificationImg?.image = UIImage.init(named: "jiankangerweima")
        certificationImg?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.width.height.equalTo(32)
            make.centerY.equalToSuperview()
        })
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



/// 健康家人管理详情cell2 标题和详情都在左侧
let HealthFamilyDetCell2Id = "HealthFamilyDetCell2Id"
let HealthFamilyDetCell2H:CGFloat = 60

class HealthFamilyDetCell2: UITableViewCell {
    
    
    var indexPath:NSIndexPath?
    var mHeaderImg:UIImageView?
    var mTitleLab:UILabel?
    var mLine:UIView?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.text = "头像"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mHeaderImg = UIImageView.init()
        self.contentView.addSubview(mHeaderImg!)
        mHeaderImg?.isUserInteractionEnabled = true
        mHeaderImg?.image = UIImage.init(named: "touxiang_weidenglu")
        mHeaderImg?.clipsToBounds = true
        mHeaderImg?.layer.cornerRadius = HealthFamilyDetCell2H * 0.3
        mHeaderImg?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.width.height.equalTo(HealthFamilyDetCell2H * 0.6)
            make.centerY.equalToSuperview()
        })
        
        
        mLine = UIView.init()
        mLine?.backgroundColor = LineColor
        contentView.addSubview(mLine!)
        mLine?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 15)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        })
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
}




/// 健康家人管理详情cell3 标题和详情都在左侧
let HealthFamilyDetCell3Id = "HealthFamilyDetCell3Id"
let HealthFamilyDetCell3H:CGFloat = 45

class HealthFamilyDetCell3: UITableViewCell {
    
    
    var indexPath:NSIndexPath?
    
    var mTitleLab:UILabel?
    var mDetLab:UILabel?
    var mLine:UIView?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mDetLab = UILabel.init()
        mDetLab?.font = UIFont.systemFont(ofSize: 16)
        mDetLab?.textAlignment = NSTextAlignment.left
        mDetLab?.textColor = UIColor.hexStringToColor(hexString: "666666")
        self.contentView.addSubview(mDetLab!)
        mDetLab?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        })
        
        
        mLine = UIView.init()
        mLine?.backgroundColor = LineColor
        contentView.addSubview(mLine!)
        mLine?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 15)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        })
        mLine?.isHidden = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //家人详情数据
    private var _famDetDic:NSDictionary?
    var famDetDic:NSDictionary?{
        set{
            _famDetDic = newValue
            
            mLine?.isHidden = true
            //姓名 年龄 身份证
            if(indexPath!.section == 1){
                mLine?.isHidden = false
                
                if(indexPath!.row == 1){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "姓名*", color: UIColor.red, rang: NSRange.init(location: 2, length: 1))
                    mDetLab!.text = "神经萝卜"
                }
                else if (indexPath!.row == 3){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "出生日期*", color: UIColor.red, rang: NSRange.init(location: 4, length: 1))
                    mDetLab!.text = "2018-09-11"
                }
                else if (indexPath!.row == 4){
                    mTitleLab!.text = "身份证号";
                    mDetLab!.text = "435634563463466"
                    mLine?.isHidden = true
                }
            }
                
                //电话号码
            else if (indexPath!.section == 2){
                mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "手机号*", color: UIColor.red, rang: NSRange.init(location: 3, length: 1))
                mDetLab?.text = "1354990098"
            }
                
                //家人关系
            else if(indexPath!.section == 3){
                mDetLab!.text = "本人"
                mTitleLab!.text = "家人关系"
            }
        }
        
        get{
            return _famDetDic
        }
    }
    
    
    //编辑家人数据
    private var _famEditDic:NSDictionary?
    var famEditDic:NSDictionary?{
        set{
            _famEditDic = newValue
            
            mLine?.isHidden = true
            //姓名 年龄 身份证
            if(indexPath!.section == 0){
                mLine?.isHidden = false
                
                if(indexPath!.row == 1){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "姓名*", color: UIColor.red, rang: NSRange.init(location: 2, length: 1))
                    mDetLab!.text = "神经萝卜"
                }
                else if (indexPath!.row == 3){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "出生日期*", color: UIColor.red, rang: NSRange.init(location: 4, length: 1))
                    mDetLab!.text = "2018-09-11"
                }
                else if (indexPath!.row == 4){
                    mTitleLab!.text = "身份证号";
                    mDetLab!.text = "435634563463466"
                    mLine?.isHidden = true
                }
            }
                
                //电话号码
            else if (indexPath!.section == 1){
                mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "手机号*", color: UIColor.red, rang: NSRange.init(location: 3, length: 1))
                mDetLab?.text = "1354990098"
            }
           
        }
        
        get{
            return _famEditDic
        }
    }
}




/// 健康家人的性别cell
let HealthFamilyGenderCellId = "HealthFamilyGenderCellId"
let HealthFamilyGenderCellH:CGFloat = 45

class HealthFamilyGenderCell: UITableViewCell {
    
    
    var indexPath:NSIndexPath?
    var mTitleLab:UILabel?
    var mButton1:UIButton?
    var mButton2:UIButton?
    var mLine:UIView?
    var currentBtn:UIButton?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "性别*", color: UIColor.red, rang: NSRange.init(location: 2, length: 1))
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mButton2 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton2?.tag = 12
        self.addSubview(mButton2!)
        mButton2?.setTitle("女", for: UIControl.State.normal)
        mButton2?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mButton2?.setTitleColor(UIColor.white, for: UIControl.State.selected)
        mButton2?.setBackgroundImage(UIImage.init(named: "wh_anniu_xiangqing_hui"), for: UIControl.State.normal)
        mButton2?.setBackgroundImage(UIImage.init(named: "jiankangzice"), for: UIControl.State.selected)
        mButton2?.clipsToBounds = true
        mButton2?.layer.cornerRadius = 12
        mButton2?.backgroundColor = UIColor.white
        mButton2?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton2?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton2?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.width.equalTo(54)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        })
        
        
        mButton1 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton1?.tag = 11
        self.addSubview(mButton1!)
        mButton1?.setTitle("男", for: UIControl.State.normal)
        mButton1?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mButton1?.setTitleColor(UIColor.white, for: UIControl.State.selected)
        mButton1?.setBackgroundImage(UIImage.init(named: "wh_anniu_xiangqing_hui"), for: UIControl.State.normal)
        mButton1?.setBackgroundImage(UIImage.init(named: "jiankangzice"), for: UIControl.State.selected)
        mButton1?.clipsToBounds = true
        mButton1?.layer.cornerRadius = 12
        mButton1?.backgroundColor = UIColor.white
        mButton1?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton1?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton1?.snp.makeConstraints({ (make) in
            make.right.equalTo((mButton2?.snp.left)!).offset(-10)
            make.width.equalTo(54)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        })
        
        
        mLine = UIView.init()
        mLine?.backgroundColor = LineColor
        contentView.addSubview(mLine!)
        mLine?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 15)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        })
        
        
        self.genderStyle = 1
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func  buttonPressed(sender:UIButton){
        if(sender == currentBtn){
            return
        }
        else{
            self.genderStyle = sender.tag-10
        }
    }
    
    //选择性别 男1  女2
    private var _genderStyle:NSInteger?
    var genderStyle:NSInteger?{
    
        set{
            _genderStyle = newValue
            
            if(_genderStyle == 1){
                mButton1?.isSelected = true
                mButton2?.isSelected = false
                currentBtn = mButton1
            }
            else{
                mButton1?.isSelected = false
                mButton2?.isSelected = true
                currentBtn = mButton2
            }
        }
        get{
            return _genderStyle
        }
    }
    
}



///添加家人的footer
let HealthFamilyFooterH:CGFloat = 80
let HealthFamilyFooterId = "HealthFamilyFooterId"

class HealthFamilyFooter: UITableViewHeaderFooterView {
    
    weak var delegate:HealthViewsDelegate?
    
    /// 详情 1    编辑2
    var _type:NSInteger?
    var section:NSInteger?
    var mButton:UIButton?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor;
        contentView.backgroundColor = BackGroundColor
        
        _type = 1
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        mButton?.tag = 100
        contentView.addSubview(mButton!)
        mButton?.setTitle("确定", for: UIControl.State.normal)
        mButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mButton?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mButton?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center;
        mButton?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(300 * SCREEN_Width / 375)
            make.height.equalTo(300 * SCREEN_Width / 375 * 12 / 65)
            make.top.equalTo(20)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        delegate?.HealthFamilyBottomBtnClick!(sender: sender)
    }
    
    
    var type:NSInteger?{
        set{
            _type = newValue
            
            /// 家人详情1  家人编辑2
            if(_type == 1){
                 mButton?.setTitle("确定", for: UIControl.State.normal)
            }
            else if(_type == 2){
                 mButton?.setTitle("保存", for: UIControl.State.normal)
            }
        }
        get{
            return _type
        }
    }
    
}

/// 健康家人管理添加家人cell1 设置头像
let HealthAddFamilyCell1Id = "HealthAddFamilyCell1Id"
let HealthAddFamilyCell1H:CGFloat = 60
let HealthAddDetLeft:CGFloat = 120

class HealthAddFamilyCell1: UITableViewCell {
    
    var indexPath:NSIndexPath?
    var mTitleLab:UILabel?
    var mButtonImg:UIImageView?
    var mBottomLine:UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        contentView.addSubview(mTitleLab!)
        mTitleLab?.text = "头像"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mButtonImg = UIImageView.init()
        contentView.addSubview(mButtonImg!)
        mButtonImg?.image = UIImage.init(named: "touxiang_weidenglu")
        mButtonImg?.isUserInteractionEnabled = true
        mButtonImg?.clipsToBounds = true
        mButtonImg?.layer.cornerRadius = HealthAddFamilyCell1H * 0.3
        mButtonImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(HealthAddFamilyCell1H * 0.6)
            make.left.equalTo(HealthAddDetLeft)
            make.centerY.equalToSuperview()
        })
        
        
        mBottomLine = UIView.init()
        contentView.addSubview(mBottomLine!)
        mBottomLine?.backgroundColor = CellLineColor
        mBottomLine?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 15)
            make.height.equalTo(0.5)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



/// 健康家人管理添加家人cell2 姓名 性别 年龄 身份证号
let HealthAddFamilyCell2Id = "HealthAddFamilyCell2Id"
let HealthAddFamilyCell2H:CGFloat = 45

class HealthAddFamilyCell2: UITableViewCell,UITextFieldDelegate {
    
    var indexPath:NSIndexPath?
    var mTitleLab:UILabel?
    var mBottomLine:UIView?
    var mTextF:UITextField?
    
    //选择性别  不可编辑性别1 可编辑2
    var mButton1:UIButton?
    var mButton2:UIButton?
    var currentBtn:UIButton?
    var _genderStyle:NSInteger?
    var btnStyle:NSInteger?

    //添加家人数据
    var _addFamilyDic:NSDictionary?
    //家人详情数据
    var _familyDetDic:NSDictionary?
    //保存输入框的数据
    var textString:NSString?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        
        textString = ""
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        contentView.addSubview(mTitleLab!)
        mTitleLab?.text = "头像"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mTextF = UITextField.init()
        mTextF?.font = UIFont.systemFont(ofSize: 16)
        mTextF?.delegate = self
        contentView.addSubview(mTextF!)
        mTextF?.clearButtonMode = UITextField.ViewMode.whileEditing
        mTextF?.isUserInteractionEnabled = true
        mTextF?.addTarget(self, action: #selector(textFChange(textField:)), for: UIControl.Event.editingChanged)
        mTextF?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 150)
            make.left.equalTo(HealthAddDetLeft)
            make.centerY.equalToSuperview()
            make.height.equalTo(HealthAddFamilyCell2H)
        })
        
        mButton1 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton1?.tag = 11
        contentView.addSubview(mButton1!)
        mButton1?.setTitle("男", for: UIControl.State.normal)
        mButton1?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mButton1?.setTitleColor(UIColor.white, for: UIControl.State.selected)
        mButton1?.setBackgroundImage(UIImage.init(named: "wh_anniu_xiangqing_hui"), for: UIControl.State.normal)
        mButton1?.setBackgroundImage(UIImage.init(named: "jiankangzice"), for: UIControl.State.selected)
        mButton1?.clipsToBounds = true
        mButton1?.layer.cornerRadius = 12
        mButton1?.backgroundColor = UIColor.white
        mButton1?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton1?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton1?.snp.makeConstraints({ (make) in
            make.left.equalTo(mTextF!)
            make.width.equalTo(54)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        })
        
        
        
        mButton2 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton2?.tag = 12
        contentView.addSubview(mButton2!)
        mButton2?.setTitle("女", for: UIControl.State.normal)
        mButton2?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mButton2?.setTitleColor(UIColor.white, for: UIControl.State.selected)
        mButton2?.setBackgroundImage(UIImage.init(named: "wh_anniu_xiangqing_hui"), for: UIControl.State.normal)
        mButton2?.setBackgroundImage(UIImage.init(named: "jiankangzice"), for: UIControl.State.selected)
        mButton2?.clipsToBounds = true
        mButton2?.layer.cornerRadius = 12
        mButton2?.backgroundColor = UIColor.white
        mButton2?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton2?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton2?.snp.makeConstraints({ (make) in
            make.left.equalTo((mButton1?.snp.right)!).offset(10)
            make.width.equalTo(54)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        })
        
        
        
        mBottomLine = UIView.init()
        contentView.addSubview(mBottomLine!)
        mBottomLine?.backgroundColor = UIColor.hexStringToColor(hexString: "E6E6E6")
        mBottomLine?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 15)
            make.height.equalTo(0.5)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        
        self.genderStyle = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func textFChange(textField:UITextField){
        
    }
    
    /// 男11 女12
    @objc func buttonPressed(sender:UIButton){
        if(sender == currentBtn){return}
        else {self.genderStyle = sender.tag - 10}
    }
    
    //选择性别 男1 女2
    var genderStyle:NSInteger?{
        set{
            _genderStyle = newValue
            if(_genderStyle == 1){
                mButton1?.isSelected = true
                mButton2?.isSelected = false
                currentBtn = mButton1
            }
            else{
                mButton1?.isSelected = false
                mButton2?.isSelected = true
                currentBtn = mButton2
            }
        }
        get{
            return _genderStyle
        }
    }
    
    //添加家人的数据
    var familyDetDic:NSDictionary?{
        set{
            _familyDetDic = newValue
            
            mTextF?.isHidden = false
            mButton1?.isHidden = true
            mButton2?.isHidden = true
            mTextF?.isEnabled = true
            
            if(indexPath?.section == 0){
                
                if(indexPath!.row==4){mBottomLine?.isHidden = true}
                else {mBottomLine?.isHidden = false}
                
                if(indexPath?.row == 1){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "姓名*", color: UIColor.red, rang: NSRange.init(location: 2, length: 1))
                    mTextF!.placeholder = "请输入姓名";
                    mTextF!.keyboardType = UIKeyboardType.default
                }else if(indexPath!.row == 2){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "性别*", color: UIColor.red, rang: NSRange.init(location: 2, length: 1))
                    mTextF!.isHidden = true
                    mButton1!.isHidden = false
                    mButton2!.isHidden = false
                    mTextF!.keyboardType = UIKeyboardType.default
                }else if(indexPath!.row == 3){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "出生日期*", color: UIColor.red, rang: NSRange.init(location: 4, length: 1))
                    mTextF!.placeholder = "请选择出生日期";
                    mTextF?.isEnabled = false
                }else {
                    mTitleLab!.text = "身份证号"
                    mTextF!.placeholder = "请输入身份证号码"
                }
            }else if (indexPath!.section == 1){
                if(indexPath!.row==1){mBottomLine?.isHidden = true}
                else {mBottomLine?.isHidden = false}
                
                if(self.indexPath!.row==0){
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "手机号*", color: UIColor.red, rang: NSRange.init(location: 3, length: 1))
                    mTextF!.placeholder = "此号码将作为体检时登记号码"
                    mTextF!.keyboardType = UIKeyboardType.numberPad
                }else{
                    mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "验证码*", color: UIColor.red, rang: NSRange.init(location: 3, length: 1))
                    mTextF!.placeholder = "请输入验证码";
                    mTextF!.keyboardType = UIKeyboardType.numberPad
                }
            }
        }
        get{
            return _familyDetDic
        }
    }
}

/// 健康家人管理添加家人cell5 姓名 性别 年龄 身份证号
let HealthAddFamilyCell5Id = "HealthAddFamilyCell5Id"
let HealthAddFamilyCell5H:CGFloat = 45

class HealthAddFamilyCell5: UITableViewCell {
    
    
    var indexPath:NSIndexPath?
    var mTitleLab:UILabel?
    var relationship:NSInteger?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        contentView.addSubview(mTitleLab!)
        mTitleLab?.attributedText = NSString.getAttstringWithColor(string: "家人关系*", color: UIColor.red, rang: NSRange.init(location: 4, length: 1))
        mTitleLab?.snp.makeConstraints({ (make) in
            make.width.equalTo(120)
            make.height.equalTo(HealthAddFamilyCell5H * 0.5)
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.bottom.equalTo(-30)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



/// 健康家人管理添加家人cell6 姓名 性别 年龄 身份证号
let HealthAddFamilyCell6Id = "HealthAddFamilyCell6Id"
let HealthAddFamilyCell6H:CGFloat = 40

class HealthAddFamilyCell6: UITableViewCell,UITextFieldDelegate {
    
    
    var indexPath:NSIndexPath?
    var mBackView:UIView?
    var mTextF:UITextField?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        
        
        mBackView = UIView.init()
        contentView.addSubview(mBackView!)
        mBackView?.backgroundColor = UIColor.white
        mBackView?.clipsToBounds = true
        mBackView?.layer.cornerRadius = (HealthAddFamilyCell6H-10) * 0.5
        mBackView?.layer.borderColor = UIColor.hexStringToColor(hexString: "999999").cgColor
        mBackView?.layer.borderWidth = 0.5
        mBackView?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.equalTo(HealthAddDetLeft)
            make.height.equalTo(HealthAddFamilyCell6H - 10)
            make.width.equalTo( SCREEN_Width - HealthAddDetLeft - 15)
        })
        
        
        mTextF = UITextField.init()
        mTextF?.font = UIFont.systemFont(ofSize: 14)
        mTextF?.delegate = self
        mBackView!.addSubview(mTextF!)
        mTextF?.clearButtonMode = UITextField.ViewMode.whileEditing
        mTextF?.isUserInteractionEnabled = true
        mTextF?.placeholder = "请输入其他关系"
        mTextF?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - HealthAddDetLeft - 45)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(HealthAddFamilyCell6H - 10)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string.count == 0){
            return true
        }
        if (range.location < 16){
            return true
        }
        else{
            return false
        }
    }
}
