//
//  MineOrderViews.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/14.
//  Copyright © 2019 soldoros. All rights reserved.
//


import UIKit
import SnapKit



@objc protocol MineOrderViewsDelegate:NSObjectProtocol {
    
    //我的体检订单列表header按钮点击代理
    @objc optional func MineOrderListHeaderBtnClick(section:NSInteger)
    
    //我的体检订单列表footer按钮点击代理
    @objc optional func MineOrderListEXFooterBtnClick(section:NSInteger)
    
    //我的体检订单详情header点击代理
    @objc optional func MineOrderDetPriceHeader(section:NSInteger)
    
    //我的体检订单待支付的取消和联系客服
    @objc optional func MineOrderDetailCancelCell(sender:UIButton)
    
    //按钮点击回调
    @objc optional func MineBottomViewButtonClick(sender:UIButton)
    
    //操作的视图按钮点击代理
    @objc optional func MineOrderFunctionViewButtonClick(sender:UIButton)
    
    //服务订单详情的header按钮点击代理
    @objc optional func MineServiceOrderDetHeaderBtnClick(section:NSInteger)
}

/// 我的体检订单列表header
let MineMedicalOrderListHeaderId = "MineMedicalOrderListHeaderId"
let MineMedicalOrderListHeaderH:CGFloat  = 60

class MineMedicalOrderListHeader: UITableViewHeaderFooterView {
    
    weak var delegate:MineOrderViewsDelegate?
    
    //分组
    var section:NSInteger?
    //顶部10个像素的灰色线条
    var mLine:UIView?
    //订单标题
    var mTitleLab:UILabel?
    //订单简介
    var mDetailLab:UILabel?
    //右侧标签
    var mIconImgView:UIImageView?
    //主题按钮
    var mHeaderBtn:UIButton?


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mLine = UIView.init()
        mLine?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 10)
        mLine?.backgroundColor = BackGroundColor
        self.contentView.addSubview(mLine!)
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mTitleLab?.font = UIFont.systemFont(ofSize: 12)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(18)
            make.left.equalTo(10)
            make.width.equalTo(SCREEN_Width - 56 - 20)
        })
        
        
        mDetailLab = UILabel.init()
        self.contentView.addSubview(mDetailLab!)
        mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mDetailLab?.font = UIFont.systemFont(ofSize: 12)
        mDetailLab?.textAlignment = NSTextAlignment.left
        mDetailLab?.isUserInteractionEnabled = true
        mDetailLab?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-8)
            make.left.equalTo(10)
            make.width.equalTo(mTitleLab!)
        })

        
        mIconImgView = UIImageView.init()
        mIconImgView?.isUserInteractionEnabled = true
        self.contentView.addSubview(mIconImgView!)
        mIconImgView?.snp.makeConstraints({ (make) in
            make.width.equalTo(56)
            make.height.equalTo(18)
            make.right.equalTo(0)
            make.centerY.equalTo(mTitleLab!)
        })
        
        mHeaderBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mHeaderBtn?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: MineMedicalOrderListHeaderH)
        self.addSubview(mHeaderBtn!)
        mHeaderBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //点击header
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.MineOrderListHeaderBtnClick!(section: section!)
    }
    
    //体检订单列表的数据
    private var _medicListDic:NSDictionary?
    var medicListDic:NSDictionary?{
        didSet{
            _medicListDic = medicListDic
          
            let string = "体检人：神经萝卜 预约号：AP1800884403"
            let attString = NSMutableAttributedString.init(string: string)
            attString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.hexStringToColor(hexString: "333333"), range: NSRange.init(location: 4, length: 4))
            attString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.hexStringToColor(hexString: "333333"), range: NSRange.init(location: 13, length: 12))
            mTitleLab?.attributedText = attString
            
            mDetailLab?.text = "预约日期：2020-10-11"
            
            let tabs = ["daizgufu","yifukuan","daipingjia","yiquxiao"]
            mIconImgView?.image = UIImage.init(named: tabs[section! % 4])
            
        }
    }
}



/// 只有金额的footer
let  MineOrderListPriceFooterH:CGFloat = 36
let  MineOrderListPriceFooterId = "MineOrderListPriceFooterId"

class MineOrderListPriceFooter: UITableViewHeaderFooterView {
    
    //分组
    var section:NSInteger?
    var mTitleLab:UILabel?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "666666")
        mTitleLab?.font = UIFont.systemFont(ofSize: 12)
        mTitleLab?.textAlignment = NSTextAlignment.right
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.text = "合计：￥99.99"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(0)
            make.height.equalTo(MineOrderListPriceFooterH)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //体检订单列表的数据
    private var _medicListDic:NSDictionary?
    var medicListDic:NSDictionary?{
        didSet{
            _medicListDic = medicListDic
            
            
        }
    }
}



//操作按钮的视图
let MineOrderFunctionViewH:CGFloat = 45

class MineOrderFunctionView: UIView {
    
    weak var delegate:MineOrderViewsDelegate?
    
    //操作按钮
    var mButton1:UIButton?
    var mButton2:UIButton?
    var mButton3:UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        for i:NSInteger in 0...2{
            let button = UIButton.init(type: UIButton.ButtonType.custom)
            self.addSubview(button)
            button.setTitleColor(TitleColor, for: UIControl.State.normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = TitleColor.cgColor
            button.clipsToBounds = true
            button.layer.cornerRadius = 15
            button.tag = 10 + i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
            button.snp.makeConstraints { (make) in
                make.width.equalTo(84)
                make.height.equalTo(30)
                make.centerY.equalToSuperview()
                make.right.equalTo(-(10 + CGFloat(i) * 98))
            }
            if(i == 0){mButton1 = button}
            if(i == 1){mButton2 = button}
            if(i == 2){mButton3 = button}
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //操作按钮10+
    @objc func buttonPressed(sender:UIButton){
        delegate?.MineOrderFunctionViewButtonClick!(sender:sender)
    }
    
    private var _style:NSInteger?
    var style:NSInteger?{
        didSet{
            _style = style
            
            mButton1?.isHidden = false
            mButton2?.isHidden = true
            mButton3?.isHidden = true
            mButton1?.setTitle("立即支付", for: UIControl.State.normal)
        }
    }
    
}



/// 订单列表带金额和操作的footer 36+42
let  MineOrderListEXFooterH:CGFloat = 78
let  MineOrderListEXFooterId = "MineOrderListEXFooterId"

class MineOrderListEXFooter: UITableViewHeaderFooterView {
    
    
    weak var delegate:MineOrderViewsDelegate?
    //分组
    var section:NSInteger?
    var mTitleLab:UILabel?
    
    //操作部分
    var operationView:UIView?
    //操作按钮
    var mButton1:UIButton?
    var mButton2:UIButton?
    var mButton3:UIButton?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "666666")
        mTitleLab?.font = UIFont.systemFont(ofSize: 12)
        mTitleLab?.textAlignment = NSTextAlignment.right
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(0)
            make.height.equalTo(MineOrderListPriceFooterH)
        })
        
        operationView = UIView.init()
        operationView?.backgroundColor = UIColor.white
        self.contentView.addSubview(operationView!)
        operationView?.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(36)
            make.bottom.equalTo(0)
        }
        
        
        for i:NSInteger in 0...2{
            let button = UIButton.init(type: UIButton.ButtonType.custom)
            operationView?.addSubview(button)
            button.setTitleColor(TitleColor, for: UIControl.State.normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = TitleColor.cgColor
            button.clipsToBounds = true
            button.layer.cornerRadius = 15
            button.tag = 10 + i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
            button.snp.makeConstraints { (make) in
                make.width.equalTo(84)
                make.height.equalTo(30)
                make.centerY.equalToSuperview()
                make.right.equalTo(-(10 + CGFloat(i) * 98))
            }
            if(i == 0){mButton1 = button}
            if(i == 1){mButton2 = button}
            if(i == 2){mButton3 = button}
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //操作按钮10+
    @objc func buttonPressed(sender:UIButton){
        delegate?.MineOrderListEXFooterBtnClick!(section: section!)
    }
    
    //体检订单列表的数据
    private var _medicListDic:NSDictionary?
    var medicListDic:NSDictionary?{
        didSet{
            _medicListDic = medicListDic
            
            mTitleLab?.text = "合计：￥99.99"
            
            mButton1?.isHidden = false
            mButton2?.isHidden = true
            mButton3?.isHidden = true
            
            mButton1?.setTitle("立即支付", for: UIControl.State.normal)
        }
    }
}




/// 我的体检订单列表的cell
let MineMedicalOrderListCellId = "MineMedicalOrderListCellId"
let MineMedicalOrderListCellH:CGFloat = 42

class MineMedicalOrderListCell: UITableViewCell {
    
    //分组
    var indexPath:IndexPath?
    
    var mTitleLab:UILabel?
    var mDetailLab:UILabel?
    var mLine:UIView?
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        self.contentView.backgroundColor = BackGroundColor
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.equalTo(10)
            make.bottom.equalTo(0)
        })
        
        
        mDetailLab = UILabel.init()
        self.contentView.addSubview(mDetailLab!)
        mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mDetailLab?.font = UIFont.systemFont(ofSize: 16)
        mDetailLab?.textAlignment = NSTextAlignment.left
        mDetailLab?.isUserInteractionEnabled = true
        mDetailLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
        })
        
        
        mLine = UIView.init()
        mLine?.backgroundColor = CellLineColor
        self.contentView.addSubview(mLine!)
        mLine?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //体检订单列表的数据
    private var _medicListDic:NSDictionary?
    var medicListDic:NSDictionary?{
        didSet{
            _medicListDic = medicListDic
            
            mTitleLab?.text = "一般检查+内科"
            mDetailLab?.text = "￥399.00"
            mLine?.isHidden = true
        }
    }
}



/// 我的服务订单列表header
let MineServiceOrderListHeaderId = "MineServiceOrderListHeaderId"
let MineServiceOrderListHeaderH:CGFloat = 52

class MineServiceOrderListHeader: UITableViewHeaderFooterView {
    
    weak var delegate:MineOrderViewsDelegate?
    
    //分组
    var section:NSInteger?
    //顶部10个像素的灰色线条
    var mLine:UIView?
    //订单标题
    var mTitleLab:UILabel?
    //右侧标签
    var mIconImgView:UIImageView?
    //主题按钮
    var mHeaderBtn:UIButton?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mLine = UIView.init()
        mLine?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 10)
        mLine?.backgroundColor = BackGroundColor
        self.contentView.addSubview(mLine!)
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.height.equalTo(MineServiceOrderListHeaderH - 10)
            make.width.equalTo(SCREEN_Width * 0.5)
        })
        
        
        mIconImgView = UIImageView.init()
        mIconImgView?.isUserInteractionEnabled = true
        self.contentView.addSubview(mIconImgView!)
        mIconImgView?.snp.makeConstraints({ (make) in
            make.width.equalTo(56)
            make.height.equalTo(18)
            make.right.equalTo(0)
            make.centerY.equalTo(mTitleLab!)
        })
        
        mHeaderBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mHeaderBtn?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: MineServiceOrderListHeaderH)
        self.addSubview(mHeaderBtn!)
        mHeaderBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        delegate?.MineOrderListHeaderBtnClick!(section: section!)
    }
    
    
    //我的服务订单列表数据
    private var _serviceListDic:NSDictionary?
    var serviceListDic:NSDictionary?{
        didSet{
            _serviceListDic = serviceListDic
            
            mTitleLab?.text = "特色服务"
            
            let tabs = ["daizgufu","keshiyong","wh_biaoqian_yishiyong","yiquxiao"]
            mIconImgView?.image = UIImage.init(named: tabs[section! % 4])
        }
    }
}



/// 我的服务订单列表cell
let MineServiceOrderListCellId = "MineServiceOrderListCellId"
let MineServiceOrderListCellH:CGFloat = 82

class MineServiceOrderListCell: UITableViewCell {
    
    //分组
    var indexPath:IndexPath?
    
    var mLeftImgView:UIImageView?
    var mTitleLab:UILabel?
    var mDetailLab:UILabel?
    var mPriceLab:UILabel?
    var mLine:UIView?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        self.contentView.backgroundColor = BackGroundColor
        
        
        mLeftImgView = UIImageView.init()
        self.contentView.addSubview(mLeftImgView!)
        mLeftImgView?.snp.makeConstraints({ (make) in
            make.width.equalTo(66)
            make.height.equalTo(62)
            make.left.equalTo(14)
            make.centerY.equalToSuperview()
        })
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(mLeftImgView!.snp.top).offset(2)
            make.left.equalTo(mLeftImgView!.snp.right).offset(10)
        })
        
        mPriceLab = UILabel.init()
        mPriceLab?.numberOfLines = 2
        self.contentView.addSubview(mPriceLab!)
        mPriceLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mPriceLab?.font = UIFont.systemFont(ofSize: 14)
        mPriceLab?.textAlignment = NSTextAlignment.left
        mPriceLab?.isUserInteractionEnabled = true
        mPriceLab?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(mTitleLab!)
            make.right.equalTo(-10)
        })
        
        
        mDetailLab = UILabel.init()
        mDetailLab?.numberOfLines = 2
        self.contentView.addSubview(mDetailLab!)
        mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "666666")
        mDetailLab?.font = UIFont.systemFont(ofSize: 14)
        mDetailLab?.textAlignment = NSTextAlignment.left
        mDetailLab?.isUserInteractionEnabled = true
        mDetailLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(mTitleLab!.snp.bottom).offset(5)
            make.left.equalTo(mTitleLab!)
            make.right.equalTo(-10)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //我的服务订单列表数据
    private var _serviceDic:NSDictionary?
    var serviceDic:NSDictionary?{
        didSet{
            _serviceDic = serviceDic
            
            mPriceLab?.isHidden = true
            
            mLeftImgView?.image = UIImage.init(named: ImagePlaceHoder6)
            mTitleLab?.text = "超级服务"
            mDetailLab?.text = "适用症：1.治疗色素痣（黑痣、青痣、红痣）和疣（寻常疣、丝状疣、传染性软疣）效果很好，一般都不会复发！"
            
            
        }
    }
    
    //我的服务订单列表数据
    private var _serviceDetDic:NSDictionary?
    var serviceDetDic:NSDictionary?{
        didSet{
            _serviceDetDic = serviceDetDic
            mPriceLab?.isHidden = false
            
            mLeftImgView?.image = UIImage.init(named: ImagePlaceHoder6)
            mTitleLab?.text = "超级服务"
            mDetailLab?.text = "适用症：1.治疗色素痣（黑痣、青痣、红痣）和疣（寻常疣、丝状疣、传染性软疣）效果很好，一般都不会复发！"
            mPriceLab?.text = "￥199.00"
            
        }
    }
}


/// 体检订单详情顶部状态
let MineOrderDetTopHeaderId = "MineOrderDetTopHeaderId"
let MineOrderDetTopHeaderH:CGFloat = 45

class MineOrderDetTopHeader: UITableViewHeaderFooterView {
    
    
    var section:NSInteger?
    var mTitleLab:UILabel?
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 20)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.height.equalTo(MineOrderDetTopHeaderH)
            make.left.equalTo(10)
            make.width.equalTo(SCREEN_Width * 0.7)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //体检订单详情数据
    private var _medicDetDic:NSDictionary?
    var medicDetDic:NSDictionary?{
        didSet{
            _medicDetDic = medicDetDic
            
            let texts:NSArray = ["待支付","已支付","待评价","已完成","已取消"]
            let colors:NSArray = [UIColor.hexStringToColor(hexString: "FF6262"),UIColor.hexStringToColor(hexString: "333333"),UIColor.hexStringToColor(hexString: "333333"),UIColor.hexStringToColor(hexString: "333333"),UIColor.hexStringToColor(hexString: "333333")]
            
            mTitleLab?.text = (texts[section! % 5] as! String)
            mTitleLab?.textColor = (colors[section! % 5] as! UIColor)
        }
    }
}


/// 订单部分通用的cell
let MineOrderGeneralCellId = "MineOrderGeneralCellId"
let MineOrderGeneralCellH:CGFloat = 33
let MineOrderGeneralCellH2:CGFloat = 40

class MineOrderGeneralCell: UITableViewCell {
    
    //分组
    var indexPath:IndexPath?
    //名称
    var mTitleLab:UILabel?
    //详情
    var mDetailLab:UILabel?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        mTitleLab?.font = UIFont.systemFont(ofSize: 12)
        mTitleLab?.textAlignment = NSTextAlignment.left
        
        
        mDetailLab = UILabel.init()
        self.contentView.addSubview(mDetailLab!)
        mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mDetailLab?.font = UIFont.systemFont(ofSize: 12)
        mDetailLab?.textAlignment = NSTextAlignment.left
        mDetailLab?.numberOfLines = 0
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //我的服务订单详情数据
    private var _serviceDetDic:NSDictionary?
    var serviceDetDic:NSDictionary?{
        didSet{
            
            _medicalProDic = medicalProDic
        
            self.backgroundColor = UIColor.white
            mDetailLab?.isHidden = true
            mTitleLab?.font = UIFont.systemFont(ofSize: 12)
            
            mTitleLab?.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.centerY.equalToSuperview()
            })
            
            if(indexPath?.section == 1){
                mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
                if(indexPath?.row == 0){
                    mTitleLab?.text = "订单金额：￥99.00"
                }
                else{
                    mTitleLab?.text = "已付金额：￥99.00"
                }
            }
            else{
                mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
                if(indexPath?.row == 0){
                    mTitleLab?.text = "订单编号：42532352"
                }
                else if(indexPath?.row == 1){
                    mTitleLab?.text = "创建时间：2018-09-11"
                }
                else if(indexPath?.row == 2){
                    mTitleLab?.text = "结算单号：CXF2342541514"
                }
                else {
                    mTitleLab?.text = "结算时间：2018-09-12"
                }
            }
        }
    }
    
    
    //我的体检订单详情项目展开的数据
    private var _medicalProDic:NSDictionary?
    var medicalProDic:NSDictionary?{
        didSet{
            _medicalProDic = medicalProDic
            self.backgroundColor = UIColor.hexStringToColor(hexString: "F5FAF8")
            self.contentView.backgroundColor = UIColor.hexStringToColor(hexString: "F5FAF8")
            mTitleLab?.font = UIFont.systemFont(ofSize: 12)
            mDetailLab?.font = UIFont.systemFont(ofSize: 12)
            mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
            mDetailLab?.textColor = UIColor.colorWithRGB(_r: 251, _g: 97, _b: 100)
            mTitleLab?.text = "小项目N号"
            mDetailLab?.text = "未付"
            mDetailLab?.textAlignment = NSTextAlignment.right
            
            mTitleLab?.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.equalTo(7)
            })
            mDetailLab?.snp.makeConstraints({ (make) in
                make.width.equalTo(SCREEN_Width - 90)
                make.left.equalTo((mTitleLab?.snp.right)!)
                make.top.equalTo(mTitleLab!)
                make.bottom.equalTo(-7)
            })
        }
    }
    
    //我的体检订单详情待支付数据
    private var _medicalPayDic:NSDictionary?
    var medicalPayDic:NSDictionary?{
        didSet{
            _medicalProDic = medicalProDic
            self.backgroundColor = UIColor.white
            self.contentView.backgroundColor = UIColor.white
            mTitleLab?.font = UIFont.boldSystemFont(ofSize: 14)
            mDetailLab?.font = UIFont.boldSystemFont(ofSize: 14)
            mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
            mDetailLab?.textColor = UIColor.colorWithRGB(_r: 252, _g: 99, _b: 102)
            mTitleLab?.text = "待支付"
            mDetailLab?.text = "￥99.00"
            mDetailLab?.textAlignment = NSTextAlignment.right
            
            mTitleLab?.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.centerY.equalToSuperview()
            })
            mDetailLab?.snp.makeConstraints({ (make) in
                make.right.equalTo(-15)
                make.centerY.equalToSuperview()
            })

        }
    }
    
    //我的体检订单详情待支付数据
    private var _medicalDetString:String?
    var medicalDetString:String?{
        didSet{
            _medicalDetString = medicalDetString
            self.backgroundColor = UIColor.white
            self.contentView.backgroundColor = UIColor.white
            mTitleLab?.font = UIFont.systemFont(ofSize: 14)
            mDetailLab?.font = UIFont.systemFont(ofSize: 14)
            mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
            mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
            mDetailLab?.textAlignment = NSTextAlignment.left
            
            if(indexPath?.row == 0){
                mTitleLab?.text = "预约号："
                mDetailLab?.text = "AP234356523"
            }
            else if(indexPath?.row == 1){
                mTitleLab?.text = "创建日期："
                mDetailLab?.text = "2020-01-14 10:09:33"
            }
            
            mTitleLab?.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.centerY.equalToSuperview()
            })
            mDetailLab?.snp.makeConstraints({ (make) in
                make.width.equalTo(SCREEN_Width - 90)
                make.left.equalTo((mTitleLab?.snp.right)!)
                make.centerY.equalToSuperview()
            })
            
        }
    }
    
    
    //我的体检订单详情状态数据和手机号
    private var _medicalDetDic:NSDictionary?
    var medicalDetDic:NSDictionary?{
        didSet{
            _medicalDetDic = medicalDetDic
            self.backgroundColor = UIColor.white
            self.contentView.backgroundColor = UIColor.white
            mTitleLab?.font = UIFont.systemFont(ofSize: 14)
            mDetailLab?.font = UIFont.systemFont(ofSize: 14)
            mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
            mDetailLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
            mDetailLab?.textAlignment = NSTextAlignment.left
            
            if(indexPath?.section == 0){
            
                if(indexPath?.row == 0){
                    mTitleLab?.text = "体检人："
                    mDetailLab?.text = "神经萝卜"
                }
                else if(indexPath?.row == 1){
                    mTitleLab?.text = "预约日期："
                    mDetailLab?.text = "2020-01-14"
                }
                else if(indexPath?.row == 2){
                    mTitleLab?.text = "体检机构："
                    mDetailLab?.text = "成都中医大健康管理中心"
                }
                else{
                    mTitleLab?.text = "体检地址："
                    mDetailLab?.text = "成都市武侯区人民南路四段17号（地铁一号线倪家桥A口对面）"
                }

                mTitleLab?.snp.makeConstraints({ (make) in
                    make.left.equalTo(15)
                    make.top.equalTo(7)
                })
                mDetailLab?.snp.makeConstraints({ (make) in
                    make.width.equalTo(SCREEN_Width - 90)
                    make.left.equalTo((mTitleLab?.snp.right)!)
                    make.top.equalTo(mTitleLab!)
                    make.bottom.equalTo(-7)
                })
            }
                
            else if(indexPath?.section == 1){
                mTitleLab?.text = "手机号："
                mDetailLab?.text = "13540033103"
               
                mTitleLab?.snp.makeConstraints({ (make) in
                    make.left.equalTo(15)
                    make.centerY.equalToSuperview()
                })
                mDetailLab?.snp.makeConstraints({ (make) in
                    make.width.equalTo(SCREEN_Width - 90)
                    make.left.equalTo((mTitleLab?.snp.right)!)
                    make.centerY.equalToSuperview()
                })
                
            }
            
        }
        
    
        
        
        
    }
    
}



/// 体检订单详情顶部状态
let MineOrderDetGeneralHeaderId = "MineOrderDetGeneralHeaderId"
let MineOrderDetGeneralHeaderH:CGFloat = 45

class MineOrderDetGeneralHeader: UITableViewHeaderFooterView {

    weak var delegate:MineOrderViewsDelegate?

    var section:NSInteger?
    var mTitleLab:UILabel?
    var mArrowImg:UIImageView?
    var mButton:UIButton?


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white

        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(10)
            make.width.equalTo(SCREEN_Width * 0.7)
        })


        mArrowImg = UIImageView.init()
        mArrowImg?.image = UIImage.init(named: "zhankai")
        self.contentView.addSubview(mArrowImg!)
        mArrowImg?.isUserInteractionEnabled = true
        mArrowImg?.snp.makeConstraints({ (make) in
            make.width.equalTo(14)
            make.height.equalTo(7)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        })


        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        mButton?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: MineOrderDetGeneralHeaderH)
        self.addSubview(mButton!)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //点击展开收起
    @objc func buttonPressed(sender:UIButton){
        if(_medicDetDic!["open"]as! String == "0"){
            mArrowImg?.image = UIImage.init(named: "zhankai")
        }
        else{
            mArrowImg?.image = UIImage.init(named: "shouqi")
        }
        delegate?.MineOrderDetPriceHeader!(section: section!)
    }

    //体检订单详情数据
    private var _medicDetDic:NSDictionary?
    var medicDetDic:NSDictionary?{
        didSet{
            _medicDetDic = medicDetDic
            mTitleLab?.text = "体检套餐N"
        }
    }
}



/// 我的体检订单待支付的取消订单、联系客服
let MineOrderDetailFunctionCellId = "MineOrderDetailFunctionCellId"
let MineOrderDetailFunctionCellH:CGFloat = 45

class MineOrderDetailFunctionCell: UITableViewCell {

    weak var delegate:MineOrderViewsDelegate?

    var indexPath:NSIndexPath?

    var mButton1:UIButton?
    var mButton2:UIButton?
    var mLine1:UIView?
    var mLine2:UIView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white


        mButton1 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton1?.tag = 100
        mButton1?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton1?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mButton1?.setTitle("取消订单", for: UIControl.State.normal)
        mButton1?.setImage(UIImage.init(named: "quxiaodingdan"), for: UIControl.State.normal)
        self.addSubview(mButton1!)
        mButton1?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton1?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -4)
        mButton1?.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -4, bottom: 0, right: 5)
        mButton1?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width * 0.5)
            make.height.equalTo(MineOrderDetailFunctionCellH)
            make.left.equalTo(0)
            make.top.equalTo(0)
        })


        mButton2 = UIButton.init(type: UIButton.ButtonType.custom)
        mButton2?.tag = 101
        mButton2?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mButton2?.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
        mButton2?.setTitle("联系客服", for: UIControl.State.normal)
        mButton2?.setImage(UIImage.init(named: "kefu"), for: UIControl.State.normal)
        self.addSubview(mButton2!)
        mButton2?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton2?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -4)
        mButton2?.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -4, bottom: 0, right: 5)
        mButton2?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width * 0.5)
            make.height.equalTo(MineOrderDetailFunctionCellH)
            make.left.equalTo((mButton1?.snp.right)!)
            make.top.equalTo(0)
        })


        mLine1 = UIView.init()
        mLine1?.backgroundColor = UIColor.hexStringToColor(hexString: "E4E3E5")
        self.contentView.addSubview(mLine1!)
        mLine1?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
            make.top.equalTo(0)
        })


        mLine2 = UIView.init()
        mLine2?.backgroundColor = UIColor.hexStringToColor(hexString: "E4E3E5")
        self.contentView.addSubview(mLine2!)
        mLine2?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 取消订单100  联系客服101
    @objc func buttonPressed(sender:UIButton){

        delegate?.MineOrderDetailCancelCell!(sender: sender)
    }

}



/// 控制器底部按钮
let MineBottomViewH:CGFloat = 58

class MineBottomView: UIView {
    
    weak var delegate:MineOrderViewsDelegate?
    
    var _style:NSInteger?
    var mButton:UIButton?
    
    init(frame: CGRect, style:NSInteger) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        _style = style
        
        mButton = UIButton.init(type: .custom)
        self.addSubview(mButton!)
        mButton?.backgroundColor = TitleColor
        mButton?.clipsToBounds = true
        mButton?.layer.cornerRadius = 19
        mButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if(_style == 1){
            mButton?.setTitle("立即支付", for: UIControl.State.normal)
        }else if(_style == 2){
            mButton?.setTitle("立即登记", for: UIControl.State.normal)
        }else if(_style == 3){
            mButton?.setTitle("自助登记", for: UIControl.State.normal)
        }
        
        mButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width - 30)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
            make.centerY.equalToSuperview()
        })
        
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.MineBottomViewButtonClick!(sender: sender)
    }
    
}


/// 服务订单详情header
let MineServiceOrderDetHeaderId = "MineServiceOrderDetHeaderId"
let MineServiceOrderDetHeaderH:CGFloat = 52

class MineServiceOrderDetHeader: UITableViewHeaderFooterView {
    
    weak var delegate:MineOrderViewsDelegate?
    
    //待支付 可使用 已使用 已取消
    var style:NSInteger?
    //分组
    var section:NSInteger?
    //灰色部分
    var mLine:UIView?
    //标题
    var mTitleLab:UILabel?
    //简介
    var mDetailLab:UILabel?
    //标签
    var mRightBtn:UIButton?
    //箭头
    var mArrowImg:UIImageView?
    //按钮
    var mButton:UIButton?
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        
        mLine = UIView.init()
        mLine?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 10)
        mLine?.backgroundColor = BackGroundColor
        self.contentView.addSubview(mLine!)
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.height.equalTo(MineServiceOrderDetHeaderH - 10)
            make.width.equalTo(SCREEN_Width * 0.5)
        })
        
        mDetailLab = UILabel.init()
        self.contentView.addSubview(mDetailLab!)
        mDetailLab?.textColor = TitleColor
        mDetailLab?.font = UIFont.systemFont(ofSize: 14)
        mDetailLab?.textAlignment = NSTextAlignment.left
        mDetailLab?.isUserInteractionEnabled = true
        mDetailLab?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(mTitleLab!)
            make.right.equalTo(-15)
        })
        
        
        mRightBtn = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mRightBtn!)
        mRightBtn?.isUserInteractionEnabled = true
        mRightBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(56)
            make.height.equalTo(18)
            make.right.equalTo(0)
            make.centerY.equalToSuperview()
        })
        
        
        
        mArrowImg = UIImageView.init()
        mArrowImg?.image = UIImage.init(named: "zhaohuimima_jiantou")
        self.contentView.addSubview(mArrowImg!)
        mArrowImg?.isUserInteractionEnabled = true
        mArrowImg?.snp.makeConstraints({ (make) in
            make.width.equalTo(7)
            make.height.equalTo(14)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        })
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mButton!)
        mButton?.tag = 100
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width)
            make.height.equalToSuperview()
            make.left.equalTo(0)
            make.centerY.equalToSuperview()
        })
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.MineServiceOrderDetHeaderBtnClick!(section: section!)
    }
    
    
    //服务订单详情数据
    private var _serviceOrderDetDic:NSDictionary?
    var serviceOrderDetDic:NSDictionary?{
        didSet{
            
            _serviceOrderDetDic = serviceOrderDetDic
            
            mArrowImg?.isHidden = true
            mTitleLab?.text = "服务订单"
            
                //待支付
            if(style == 0){
                mRightBtn?.setImage(UIImage.init(named: "daizgufu"), for: UIControl.State.normal)
            }
                //可使用
            else if(style == 1){
                mRightBtn?.setImage(UIImage.init(named: "keshiyong_1"), for: UIControl.State.normal)
            }
                //已使用
            else if(style == 1){
                mRightBtn?.setImage(UIImage.init(named: "wh_biaoqian_yishiyong"), for: UIControl.State.normal)
            }
                //已取消
            else if(style == 1){
                mRightBtn?.setImage(UIImage.init(named: "yiquxiao"), for: UIControl.State.normal)
            }
        }
    }
    
    
}



/// 服务订单详情的空白cell
let MineServiceOrderTopBlankCellId = "MineServiceOrderTopBlankCellId"
let MineServiceOrderTopBlankCellH:CGFloat = 15

class MineServiceOrderTopBlankCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// 服务码
let MineServiceOrderSerCodeCellId = "MineServiceOrderSerCodeCellId"
let MineServiceOrderSerCodeCellH:CGFloat = 40

class MineServiceOrderSerCodeCell: UITableViewCell {
    
    var indexPath:NSIndexPath?
    var mTitleLab:UILabel?
    var mStatusBtn:UIButton?
    var mLine:UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 16)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.height.equalToSuperview()
            make.left.equalTo(15)
            make.top.equalTo(0)
        })
        
        
        mStatusBtn = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mStatusBtn!)
        mStatusBtn?.tag = 100
        mStatusBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mStatusBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(44)
            make.height.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(mTitleLab!)
        })
        
        mLine = UIView.init()
        mLine?.backgroundColor = LineColor
        contentView.addSubview(mLine!)
        mLine?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width)
            make.height.equalTo(1)
            make.left.equalTo(0)
            make.bottom.equalTo(MineServiceOrderSerCodeCellH)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(sender:UIButton){
        
    }
    
    
    //我的服务订单详情数据
    private var _serviceDic:NSDictionary?
    var serviceDic:NSDictionary?{
        didSet{
            _serviceDic = serviceDic
            
            
            mTitleLab?.text = "服务码：23542342345"
            
            
        }
    }
}


/// 服务说明cell
let MineServiceOrderDescriptionCellId = "MineServiceOrderDescriptionCellId"

class MineServiceOrderDescriptionCell: UITableViewCell {
    
    var indexPath:NSIndexPath?
    var mTitleLab:UILabel?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = BackGroundColor
        contentView.backgroundColor = BackGroundColor
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 12)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.numberOfLines = 0
        mTitleLab?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.left.equalTo(15)
            make.top.equalTo(10)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
            
            let string:String = "服务说明：\n您可以凭有效服务码，前往机构享受服务。"
            mTitleLab?.text = string
            
        }
    }
    
    
}
