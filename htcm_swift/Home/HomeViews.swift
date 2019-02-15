//
//  HomeViews.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit



@objc protocol HomeViewsDelegate:NSObjectProtocol {
    //首页banner点击代理协议
    @objc optional func homeBannerCallBack(index:NSInteger)
    //首页顶部 预约体检 体检报告 我的体检 点击代理协议
    @objc optional func homeTopViewCallBack(sender:UIButton)
    //app通用header点击代理协议
    @objc optional func HomeTitleHeaderBtnClick(section:NSInteger)
    //首页未登录智能助理点击代理协议
    @objc optional func HomeNologoinCellBtnClick(indexPath:NSIndexPath)
    //首页智能助理按钮点击代理协议
    @objc optional func HomeAssistantCellBtnClick(indexPath:NSIndexPath, sender:UIButton)
    
    //体检套餐的header按钮点击回调
    @objc optional func HomePackageListHeader(sender:UIButton)
}


/// 首页banner
let HomeBannerH =  SCREEN_Width * 34/75

class HomeBanner: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate:HomeViewsDelegate?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.brown
        
        let image1:UIImage? = UIImage(named: "shouye_banner1")
        let image2:UIImage? = UIImage(named: "shouye_banner2")
        let image3:UIImage? = UIImage(named: "shouye_banner3")
        let image4:UIImage? = UIImage(named: "shouye_banner4")
        let images:NSArray = [image1!, image2!, image3!, image4!]
        
        let cycleScrollView = LLCycleScrollView.cycleScrollView(frame: self.bounds, imagesGroup: images)
        cycleScrollView.placeHolderImage = UIImage(named: ImagePlaceHoder5)
        cycleScrollView.callBackWithIndex = { (index : Int) in
           
            self.delegate?.homeBannerCallBack!(index:index)
        }
        self.addSubview(cycleScrollView)
        cycleScrollView.pageControl?.bottom -= 20
        
    }
    
}




/// 首页顶部 预约体检 体检报告 我的体检
let HomeTopChoiceViewId = "HomeTopChoiceViewId"
let HomeTopChoiceViewH  = 96

class HomeTopChoiceView: UITableViewHeaderFooterView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate:HomeViewsDelegate?
    
    override init(reuseIdentifier: String?) {

        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white

        let showView:UIView = UIView.init(frame: CGRect.init(x: 0, y: -15, width: Int(SCREEN_Width)-30, height: HomeTopChoiceViewH+5))
        showView.backgroundColor = UIColor.white
        self.contentView.addSubview(showView)
        showView.layer.shadowColor = UIColor.colorWithRGB(_r: 200, _g: 200, _b: 200).cgColor
        showView.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        showView.layer.shadowOpacity = 0.5;
        showView.layer.shadowRadius = 5;
        
        let mBackView:UIView = UIView.init(frame: showView.frame)
        mBackView.centerX = SCREEN_Width*0.5
        self.contentView.addSubview(mBackView)
        mBackView.clipsToBounds = true
        mBackView.layer.cornerRadius = 4
        mBackView.backgroundColor = UIColor.white
        
        showView.width = mBackView.width - 4
        showView.height = mBackView.height - 4
        showView.centerY = mBackView.centerY
        showView.centerX = mBackView.centerX
        
        let images:NSArray = ["shouye_yuyuetijian","shouye_tijianbaogao","shouye_wodetijian"]
        let titles:NSArray = ["预约体检","体检报告","我的体检"]
        
        for index in 0...titles.count-1{
            
            let btnView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: mBackView.width/CGFloat(titles.count), height: mBackView.height))
            btnView.centerX = CGFloat(index) * btnView.width + btnView.width*0.5
            mBackView.addSubview(btnView)
            btnView.backgroundColor = UIColor.white
            
            let imgV:UIImageView = UIImageView.init()
            imgV.bounds = CGRect.init(x: 0, y: 0, width: 42, height: 42)
            imgV.centerX = btnView.width*0.5
            imgV.top = 15
            imgV.isUserInteractionEnabled = true
            imgV.image = UIImage.init(named: images[index] as! String)
            btnView.addSubview(imgV)
            
            let lab:UILabel = UILabel.init()
            lab.bounds = CGRect.init(x: 0, y: 0, width: 80, height: 20)
            lab.textAlignment = NSTextAlignment.center
            lab.font = UIFont.systemFont(ofSize: 14)
            btnView.addSubview(lab)
            lab.isUserInteractionEnabled = true
            lab.text = titles[index] as? String
            lab.sizeToFit()
            lab.top = imgV.bottom + 9
            lab.centerX = btnView.width * 0.5
            
            let btn:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
            btn.frame = btnView.bounds
            btnView.addSubview(btn)
            btn.tag = index+10
            btn.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
 
        }
        
    }
    
    
    //预约体检10 体检报告11 我的体检12
    @objc func buttonPressed(sender:UIButton){
        delegate?.homeTopViewCallBack!(sender: sender)
    }
    
}



/// APP通用的header
let homeTitleHeaderId  = "homeTitleHeaderId"
let homeTitleHeaderH:CGFloat   = 55.0
let homeTitleHeaderH2:CGFloat  = 45.0

class homeTitleHeader: UITableViewHeaderFooterView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:HomeViewsDelegate?
    //左侧文字
    var mTitleLab:UILabel?
    //右侧文字
    var mDetailLab:UILabel?
    //左侧线条
    var line:UIView?
    //header分组
    var section:NSInteger?
    //视图按钮
    var button:UIButton?
    //右侧箭头
    var mRightIcon:UIImageView?
    //底部线条
    var bottomLine:UIView?
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white

        line = UIView.init()
        line?.backgroundColor = TitleColor
        line?.bounds = CGRect.init(x: 0, y: 0, width: 3, height: 16)
        line?.left = 14
        line?.centerY = CGFloat(homeTitleHeaderH * 0.5)
        line?.clipsToBounds = true
        line?.layer.cornerRadius = (line?.width)! * 0.5
        self.contentView.addSubview(line!)
        
        mTitleLab = UILabel.init()
        mTitleLab?.bounds = CGRect.init(x: 0, y: 0, width: 200, height: CGFloat(homeTitleHeaderH) * 0.5)
        mTitleLab?.font = UIFont.boldSystemFont(ofSize: 18)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        self.contentView.addSubview(mTitleLab!)
        
        mRightIcon = UIImageView.init()
        mRightIcon?.bounds = CGRect.init(x: 0, y: 0, width: 8, height: 13)
        mRightIcon?.right = SCREEN_Width-16
        mRightIcon?.isUserInteractionEnabled = true
        mRightIcon?.centerY = CGFloat(homeTitleHeaderH) * 0.5
        self.contentView.addSubview(mRightIcon!)
        mRightIcon?.image = UIImage.init(named: "youjiantou")
        mRightIcon?.isHidden = true
        
        mDetailLab = UILabel.init()
        mDetailLab?.bounds = CGRect.init(x: 0, y: 0, width: 120, height: CGFloat(homeTitleHeaderH) * 0.5)
        mDetailLab?.font = UIFont.systemFont(ofSize: 14)
        mDetailLab?.textAlignment = NSTextAlignment.right
        mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        self.contentView.addSubview(mDetailLab!)
        mDetailLab?.isHidden = true
        
        bottomLine = UIView.init()
        bottomLine?.backgroundColor = UIColor.colorWithRGB(_r: 230, _g: 230, _b: 230)
        bottomLine?.frame = CGRect.init(x: 0, y: homeTitleHeaderH-0.5, width: SCREEN_Width, height: 0.5)
        self.contentView.addSubview(bottomLine!)
        bottomLine?.isHidden = true
        
        button = UIButton.init(type: UIButton.ButtonType.custom)
        button?.frame = self.bounds
        self.contentView.addSubview(button!)
        button?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        
    }
    
    ///点击按钮
    @objc func buttonPressed(sender:UIButton){
        
    }
    
    
    /// 是否显示左侧线条
    private var _showLine:Bool?
    var showLine : Bool? {
        didSet{
            _showLine = showLine
            line?.isHidden = !_showLine!
        }
    }
    
    ///首页数据
    private var _homeDict:[NSString:NSInteger]?
    var homeDict:[NSString:NSInteger]?{
        didSet{
            _homeDict = homeDict
            let type:NSInteger = (_homeDict?["type"]!)!
            if(type == 0) {
                mTitleLab?.text = "智能助理";
            }
            else if(type == -1) {
                mTitleLab?.text = "智能助理";
            }
            else if(type == 6) {
                mTitleLab?.text = "推荐资讯";
            }
            
            mTitleLab?.sizeToFit()
            mTitleLab?.centerY = homeTitleHeaderH * 0.5
            mTitleLab?.left = (line?.right)! + 7
        }
    }
    
    ///发现页面数据
    private var _foundDict:[NSString:NSInteger]?
    var foundDict:[NSString:NSInteger]?{
        didSet{
            _foundDict = foundDict

            if(section == 1) {
                mTitleLab?.text = "医疗美容";
            }
            else{
                mTitleLab?.text = "特色服务";
            }
            
            mTitleLab?.sizeToFit()
            mTitleLab?.centerY = homeTitleHeaderH * 0.5
            mTitleLab?.left = (line?.right)! + 7
        }
    }
    
    
}


/// 首页未登录智能助理
let HomeNologoinCellId          = "HomeNologoinCellId"
let HomeNologoinCellH:CGFloat   = 151.0

class HomeNologoinCell: UITableViewCell {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:HomeViewsDelegate?
    
    //白色背景
    var indexPath:NSIndexPath?
    //白色背景
    var mBackView:UIView?
    //左上角头像
    var mHeaderBtn:UIButton?
    //未登录文字
    var mNameBtn:UIButton?
    //线条
    var mLine:UIView?
    //新手指引
    var mPromptlab:UILabel?
    //详细信息
    var mDetailLab:UILabel?
    //立即登录按钮
    var mLoginBtn:UIButton?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.HomeNologoinCellBtnClick!(indexPath: indexPath!)
    }
    
}



/// 首页智能助理为空展示机构图
let HomeAssistantImageCellId          = "HomeAssistantImageCellId"
let HomeAssistantImageCellH:CGFloat   = (SCREEN_Width-30) * 270/694 + 20

class HomeAssistantImageCell: UITableViewCell {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:HomeViewsDelegate?
    
    //白色背景
    var indexPath:NSIndexPath?
    //白色背景
    var mBackView:UIView?
    //左上角头像
    var mHeaderBtn:UIButton?
    //未登录文字
    var mNameBtn:UIButton?
    //线条
    var mLine:UIView?
    //新手指引
    var mPromptlab:UILabel?
    //详细信息
    var mDetailLab:UILabel?
    //立即登录按钮
    var mLoginBtn:UIButton?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.HomeNologoinCellBtnClick!(indexPath: indexPath!)
    }
    
}




/// 首页智能助理
let HomeAssistantCellId          = "HomeAssistantCellId"
let HomeAssistantCellH:CGFloat   = 168.0

class HomeAssistantCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:HomeViewsDelegate?
    //分组
    var indexPath:NSIndexPath?
    
    //白色背景
    var mBackView:UIView?
    //左上角头像
    var mHeaderBtn:UIButton?
    //名字
    var mNameLab:UILabel?
    //体检号、预约号
    var mMedicalNumlab:UILabel?
    //右上角叉叉
    var mDeleteBtn:UIButton?
    //右上角条形码、二维码
    var mCodeBtn:UIButton?
    //线条
    var mLine:UIView?
    //详情
    var mDetlab:UILabel?
    //详情副标题
    var mDetVicelab:UILabel?
    //支付、查看报告、自助登记
    var mButton:UIButton?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        let showView1:UIView = UIView.init(frame: CGRect.init(x: 15, y: 5, width: Int(SCREEN_Width - 30), height: Int(HomeAssistantCellH - 5)))
        showView1.backgroundColor = UIColor.white
        self.contentView.addSubview(showView1)
        showView1.layer.shadowColor = UIColor.colorWithRGB(_r: 35, _g: 67, _b: 62).cgColor
        showView1.layer.shadowOffset = CGSize.init(width: -5, height: -5)
        showView1.layer.shadowOpacity = 0.12;
        showView1.layer.shadowRadius = 5;
        
        let showView:UIView = UIView.init(frame: CGRect.init(x: 15, y: 5, width: Int(SCREEN_Width - 30), height: Int(HomeAssistantCellH - 5)))
        showView.backgroundColor = UIColor.white
        self.contentView.addSubview(showView)
        showView.layer.shadowColor = UIColor.colorWithRGB(_r: 35, _g: 67, _b: 62).cgColor
        showView.layer.shadowOffset = CGSize.init(width: 5, height: 5)
        showView.layer.shadowOpacity = 0.12;
        showView.layer.shadowRadius = 5;
        
        
        mBackView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(SCREEN_Width - 30), height: Int(HomeAssistantCellH - 20)))
        mBackView!.centerX = SCREEN_Width*0.5
        mBackView?.centerY = HomeAssistantCellH * 0.5
        self.contentView.addSubview(mBackView!)
        mBackView!.clipsToBounds = true
        mBackView!.layer.cornerRadius = 5
        mBackView!.backgroundColor = UIColor.white
        
        showView1.width = mBackView!.width-4;
        showView1.height = mBackView!.height-4;
        showView1.centerY = mBackView!.centerY;
        showView1.centerX = mBackView!.centerX;
        showView.width = mBackView!.width-4;
        showView.height = mBackView!.height-4;
        showView.centerY = mBackView!.centerY;
        showView.centerX = mBackView!.centerX;
        
        
        mLine = UIView.init()
        mLine?.frame = CGRect.init(x: 0, y: 66, width: (mBackView?.width)!, height: 1)
        mLine?.backgroundColor = UIColor.hexStringToColor(hexString: "F4F4F4")
        mBackView?.addSubview(mLine!)
        
        
        mHeaderBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mHeaderBtn?.frame = CGRect.init(x: 15, y: 15, width: 38, height: 38)
        mHeaderBtn?.tag = 10
        mBackView?.addSubview(mHeaderBtn!)
        mHeaderBtn?.clipsToBounds = true
        mHeaderBtn?.layer.cornerRadius = (mHeaderBtn?.height)! * 0.5
        mHeaderBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        mNameLab = UILabel.init()
        mNameLab?.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 28)
        mBackView?.addSubview(mNameLab!)
        mNameLab?.font = UIFont.boldSystemFont(ofSize: 16)
        mNameLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        
        
        mDeleteBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mDeleteBtn?.bounds = CGRect.init(x: 0, y: 0, width: 35, height: 35)
        mDeleteBtn?.right = (mBackView?.width)!
        mDeleteBtn?.top = 0
        mDeleteBtn?.tag = 30
        mBackView?.addSubview(mDeleteBtn!)
        mDeleteBtn?.setImage(UIImage.init(named: "shouyeguanbi"), for: UIControl.State.normal)
        mDeleteBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        mCodeBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mCodeBtn?.bounds = CGRect.init(x: 0, y: 0, width: 26, height: 26)
        mCodeBtn?.right = (mBackView?.width)! - 40
        mCodeBtn?.top = 20
        mCodeBtn?.tag = 13
        mBackView?.addSubview(mCodeBtn!)
        mCodeBtn?.setImage(UIImage.init(named: "jiankangerweima"), for: UIControl.State.normal)
        mCodeBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
        mMedicalNumlab = UILabel.init()
        mMedicalNumlab?.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 28)
        mMedicalNumlab?.tag = 100
        mBackView?.addSubview(mMedicalNumlab!)
        mMedicalNumlab?.font = UIFont.systemFont(ofSize: 12)
        mMedicalNumlab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        
        
        mDetlab = UILabel.init()
        mDetlab?.bounds = CGRect.init(x: 0, y: 0, width: (mBackView?.width)! * 0.73, height: 28)
        mDetlab?.tag = 101
        mBackView?.addSubview(mDetlab!)
        mDetlab?.font = UIFont.boldSystemFont(ofSize: 16)
        mDetlab?.textAlignment = NSTextAlignment.left
        mDetlab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mDetlab?.top = (mLine?.bottom)! + 15
        mDetlab?.left = 15
        
        
        mDetVicelab = UILabel.init()
        mDetVicelab?.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 28)
        mDetVicelab?.tag = 102
        mBackView?.addSubview(mDetVicelab!)
        mDetVicelab?.font = UIFont.systemFont(ofSize: 12)
        mDetVicelab?.textAlignment = NSTextAlignment.left
        mDetVicelab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mDetVicelab?.top = (mLine?.bottom)! + 15
        mDetVicelab?.left = 15
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        mButton?.bounds = CGRect.init(x: 0, y: 0, width: 75, height: 28)
        mButton?.right = (mBackView?.width)! - 8
        mButton?.top = (mLine?.bottom)! + 26
        mButton?.tag = 14
        mBackView?.addSubview(mButton!)
        mButton?.clipsToBounds = true
        mButton?.layer.cornerRadius = (mButton?.height)! * 0.5
        mButton?.backgroundColor = TitleColor
        mButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
    }
    
    //头像10  右上角叉叉30  二维码/条形码13  支付/查看报告/自助登记14
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.HomeAssistantCellBtnClick!(indexPath: indexPath! ,sender: sender)
    }
    
    ///首页数据
    private var _homeDict:[NSString:NSInteger]?
    var homeDict:[NSString:NSInteger]?{
        didSet{
            _homeDict = homeDict
            
            mHeaderBtn?.setImage(UIImage.init(named: "touxiang_weidenglu"), for: UIControl.State.normal)
            
            mNameLab?.text = "神经萝卜"
            mNameLab?.sizeToFit()
            mNameLab?.top = 15
            mNameLab?.left = (mHeaderBtn?.right)! + 10
            
            
            mMedicalNumlab?.text = "预约号：23412414123"
            mMedicalNumlab?.sizeToFit()
            mMedicalNumlab?.bottom = (mLine?.top)! - 15
            mMedicalNumlab?.left = (mNameLab?.left)!
            
            
            mDetlab?.text = "预约了2018-12-11的体检"
            
            mDetVicelab?.text = "待付金额：￥188.00元"
            mDetVicelab?.sizeToFit()
            mDetVicelab?.top = (mLine?.bottom)! + 48
            
            mButton?.setTitle("立即支付", for: UIControl.State.normal)
        }
    }
    
}





/// 首页未登录智能助理
let HomeInformationCellId          = "HomeInformationCellId"
let HomeInformationCellH:CGFloat   = 98.0

class HomeInformationCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //代理
    weak var delegate:HomeViewsDelegate?
    //分组
    var indexPath:NSIndexPath?
    
    //底部线条
    var mLine:UIView?
    //左侧图片
    var mLeftImg:UIImageView?
    //标题
    var mTitleLab:UILabel?
    //标签
    var mLabel:UILabel?
    //点赞
    var mScoreBtn:UIButton?
    //浏览人数
    var mSeeBtn:UIButton?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mLeftImg = UIImageView.init(frame: CGRect.init(x: 15, y: 15, width: 90, height: 70))
        mLeftImg?.centerY = HomeInformationCellH * 0.5
        mLeftImg?.left = 15
        self.contentView.addSubview(mLeftImg!)
        mLeftImg?.clipsToBounds = true
        mLeftImg?.layer.cornerRadius = 4
        mLeftImg?.contentMode =  UIView.ContentMode.scaleToFill
        
        mTitleLab = UILabel.init()
        mTitleLab?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - mLeftImg!.right - 27, height: 48)
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.numberOfLines = 2
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(mTitleLab!)
        
        mLabel = UILabel.init()
        mLabel?.bounds = CGRect.init(x: 0, y: 0,width: 48, height: 14)
        mLabel?.font = UIFont.systemFont(ofSize: 10)
        mLabel?.textColor = TitleColor
        mLabel?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(mLabel!)
        mLabel?.clipsToBounds = true
        mLabel?.layer.cornerRadius = 3
        mLabel?.layer.borderColor = TitleColor.cgColor
        mLabel?.layer.borderWidth = 1
        
        mSeeBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mSeeBtn?.bounds = CGRect.init(x: 0, y: 0, width: 55, height: 20)
        mSeeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        mSeeBtn?.setImage(UIImage.init(named: "liulan"), for: UIControl.State.normal)
        mSeeBtn?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mSeeBtn?.imageEdgeInsets = UIEdgeInsets.init(top: 1, left: -2, bottom: -1, right: 0)
        mSeeBtn?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        mSeeBtn?.contentVerticalAlignment =  UIControl.ContentVerticalAlignment.center
        self.contentView.addSubview(mSeeBtn!)
        
        
        mScoreBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mScoreBtn?.bounds = CGRect.init(x: 0, y: 0, width: 55, height: 20)
        mScoreBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        mScoreBtn?.setImage(UIImage.init(named: "shouye_shoucang"), for: UIControl.State.normal)
        mScoreBtn?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mScoreBtn?.imageEdgeInsets = UIEdgeInsets.init(top: 1, left: -2, bottom: -1, right: 0)
        mScoreBtn?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        mScoreBtn?.contentVerticalAlignment =  UIControl.ContentVerticalAlignment.center
        self.contentView.addSubview(mScoreBtn!)
        
        
        mLine = UIView.init()
        mLine?.frame = CGRect.init(x: 15, y: HomeInformationCellH-0.5, width: SCREEN_Width-30, height: 0.5)
        mLine?.backgroundColor = UIColor.hexStringToColor(hexString: "F0F0F0")
        self.contentView.addSubview(mLine!)
    
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.HomeNologoinCellBtnClick!(indexPath: indexPath!)
    }
    
    
    ///首页数据
    private var _homeDict:[NSString:NSInteger]?
    var homeDict:[NSString:NSInteger]?{
        didSet{
            _homeDict = homeDict
            
            mLeftImg?.image = UIImage.init(named: ImagePlaceHoder6)

            let string:NSString = "1000份钜惠健康大礼包火热开抢，错过等明年......"
            let attString:NSMutableAttributedString = NSMutableAttributedString.init(string: string as String)
            let paragraphStye = NSMutableParagraphStyle()
            //调整行间距
            paragraphStye.lineSpacing = 4
            let rang:NSRange = NSMakeRange(0, attString.length)
            attString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: rang)
            
            mTitleLab?.width =  SCREEN_Width - mLeftImg!.right - 27
            mTitleLab?.attributedText = attString
            mTitleLab?.sizeToFit()
            mTitleLab?.top = (mLeftImg?.top)!
            mTitleLab?.left = (mLeftImg?.right)! + 14;
            
            mLabel?.text = "健康中心"
            mLabel?.sizeToFit()
            mLabel?.width += 10
            mLabel?.height += 7
            mLabel?.bottom = mLeftImg!.bottom;
            mLabel?.left = mTitleLab!.left;
            
            
            mSeeBtn?.setTitle("1342", for: UIControl.State.normal)
            mSeeBtn?.right = SCREEN_Width-10
            mSeeBtn?.centerY = (mLabel?.centerY)!
        
            
            mScoreBtn?.setTitle("455", for: UIControl.State.normal)
            mScoreBtn?.right = (mSeeBtn?.left)! - 10
            mScoreBtn?.centerY = (mSeeBtn?.centerY)!
         
        }
    }
    
    
}




/// 套餐列表的header
let HomePackageListHeaderId = "HomePackageListHeaderId"
let HomePackageListHeaderH:CGFloat = 45

class HomePackageListHeader: UITableViewHeaderFooterView {
    
    //价格 分类 精确
    var mButton1:UIButton?
    var mButton2:UIButton?
    var mButton3:UIButton?
    //当前选中的按钮
    var currentBtn:UIButton?
    
    //选中状态
    var selected:Bool?
    
    //底部线条
    var line:UIView?
    
    var line1:UIView?
    var line2:UIView?
    var line3:UIView?
    var line4:UIView?
    
    var number:NSInteger?
    var btnWidth:CGFloat?
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        number = 3
        btnWidth = SCREEN_Width / 3
        
        let titles:NSArray = ["综合","全部价格","销量"]
        for i:NSInteger in 0...titles.count-1{
            
            let btn:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setImage(UIImage.init(named: "shouye_shoucang"), for: UIControl.State.normal)
            btn.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
            btn.contentVerticalAlignment =  UIControl.ContentVerticalAlignment.center
            contentView.addSubview(btn)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// 体检套餐的cell
let HomeMedicalPackageListCellId = "HomeMedicalPackageListCellId"
let HomeMedicalPackageListCellH:CGFloat = 98

class HomeMedicalPackageListCell: UITableViewCell {
    
    var indexPath:NSIndexPath?
    
    var mBackView:UIView?
    var mButton:UIButton?
    var mTitleLab:UILabel?
    var tabView:UIView?
    var mNumberLab:UILabel?
    var mIcon:UIImageView?
    var mPriceLab:UILabel?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        contentView.backgroundColor = BackGroundColor
        
        mBackView = UIView.init()
        mBackView?.backgroundColor = UIColor.white
        contentView.addSubview(mBackView!)
        mBackView?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.bottom.equalTo(0)
        })
        
        
        mTitleLab = UILabel.init()
        mBackView?.addSubview(mTitleLab!)
        mTitleLab?.text = "中医大全面体检（男）"
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.top.equalTo(13)
        })
        
        mPriceLab = UILabel.init()
        mBackView?.addSubview(mPriceLab!)
        mPriceLab?.text = "￥99.00"
        mPriceLab?.textColor = UIColor.hexStringToColor(hexString: "FF6262")
        mPriceLab?.textAlignment = NSTextAlignment.left
        mPriceLab?.font = UIFont.systemFont(ofSize: 20)
        mPriceLab?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.top.equalTo(mTitleLab!)
        })
        
        
        tabView = UIView.init()
        mBackView?.addSubview(tabView!)
       
        let colors:NSArray = [UIColor.colorWithRGB(_r: 71, _g: 199, _b: 252),UIColor.colorWithRGB(_r: 110, _g: 195, _b: 24)]
        
        let texts:NSArray = ["全面","男性"]
        var oldLab:UILabel?
        for i:NSInteger in 0...texts.count-1{
            
            let rect:CGSize = NSString.getTextSize(text: texts[i] as! String, font: UIFont.systemFont(ofSize: 10), maxSize: CGSize.init(width: 150, height: 30))
            
            let label = UILabel.init()
            label.text = (texts[i] as! String)
            label.textColor = (colors[i] as! UIColor)
            label.clipsToBounds = true
            label.layer.cornerRadius = 4
            label.layer.borderColor = (colors[i] as! UIColor).cgColor
            label.layer.borderWidth = 1
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 10)
            tabView?.addSubview(label)
            
            if(i == 0){
                label.snp.makeConstraints({ (make) in
                    make.left.top.equalTo(0)
                    make.width.equalTo(rect.width + 10)
                    make.height.equalTo(rect.height + 5)
                })
            }
            else{
                
                label.snp.makeConstraints({ (make) in
                    make.left.equalTo(oldLab!.snp.right).offset(7)
                    make.top.equalTo(oldLab!.snp.top)
                    make.width.equalTo(rect.width + 10)
                    make.height.equalTo(oldLab!)
                })
                
            }
            
            
            
            oldLab = label
            
            if(i == texts.count-1){
                oldLab!.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(-5)
                })
                tabView!.snp.makeConstraints { (make) in
                    make.height.equalTo(25)
                    make.top.equalTo((mTitleLab?.snp.bottom)!).offset(8)
                    make.left.equalTo(mTitleLab!)
                }
            }
        }
        
        
        mIcon = UIImageView.init()
        mBackView?.addSubview(mIcon!)
        mIcon?.image = UIImage.init(named: "hot")
        mIcon?.snp.makeConstraints({ (make) in
            make.width.equalTo(12)
            make.height.equalTo(15)
            make.left.equalTo((mTitleLab?.snp.right)!).offset(10)
            make.centerY.equalTo(mTitleLab!)
        })
        
        
        
        mNumberLab = UILabel.init()
        mBackView?.addSubview(mNumberLab!)
        mNumberLab?.text = "83人已检"
        mNumberLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mNumberLab?.textAlignment = NSTextAlignment.left
        mNumberLab?.font = UIFont.systemFont(ofSize: 16)
        mNumberLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(mTitleLab!)
            make.top.equalTo((tabView?.snp.bottom)!)
            make.bottom.equalTo(-15)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var _labels:NSArray?
    var labels:NSArray?{
        set{
           _labels = newValue
        }
        get{
            return _labels
        }
    }
    
}


