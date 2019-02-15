//
//  PBViews.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

@objc protocol PBViewsDelegate:NSObjectProtocol {
    
    //支付类型cell按钮点击代理协议
    @objc optional func PBPayOrderCellBtnClick(indexPath:NSIndexPath, sender:UIButton)
    //卡支付cell按钮点击代理协议
    @objc optional func PayOrdercCradCellBtnClick(indexPath:NSIndexPath, sender:UIButton)
    //卡支付添加健康卡点击代理协议
    @objc optional func PayOrderAddCradFooterBtnClick(sender:UIButton)

}



/// 支付方式
let PayOrderCellId = "PayOrderCellId"
let PayOrderCellH:CGFloat = 55

class PayOrderCell: UITableViewCell {
    
    weak var delegate:PBViewsDelegate?

    var indexPath:IndexPath?
    
    var mLeftImg:UIImageView?
    var mTitleLab:UILabel?
    var mRightBtn:UIButton?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        mLeftImg = UIImageView.init()
        contentView.addSubview(mLeftImg!)
        mLeftImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalTo((mLeftImg?.snp.right)!).offset(10)
            make.width.equalTo(SCREEN_Width - 100)
        })
        
        
        mRightBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mRightBtn?.setImage(UIImage.init(named: "fuxuankuangicon1"), for: UIControl.State.normal)
        mRightBtn?.setImage(UIImage.init(named: "fuxuankuangicon2"), for: UIControl.State.normal)
        self.addSubview(mRightBtn!)
        mRightBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for:  UIControl.Event.touchUpInside)
        mRightBtn?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(18)
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
        })

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
    }
    
    
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
            let imgs = ["zhifubao","weixin"]
            let titles = ["支付宝支付","微信支付"]
            mLeftImg?.image = UIImage.init(named: imgs[(indexPath?.row)!])
            mTitleLab!.text = titles[indexPath!.row]
        }
    }
    
}




/// 健康卡支付cell
let PayOrdercCradCellId = "PayOrdercCradCellId"
let PayOrdercCradCellH:CGFloat = 55

class PayOrdercCradCell: UITableViewCell {
    
    weak var delegate:PBViewsDelegate?
    
    var indexPath:IndexPath?
    
    var mLeftImg:UIImageView?
    var mTitleLab:UILabel?
    var mRightBtn:UIButton?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        mLeftImg = UIImageView.init()
        contentView.addSubview(mLeftImg!)
        mLeftImg?.image = UIImage.init(named: "huiyuanka_xiangqing")
        mLeftImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(40)
            make.centerY.equalToSuperview()
        })
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 18)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalTo((mLeftImg?.snp.right)!).offset(10)
            make.width.equalTo(SCREEN_Width - 100)
        })
        
        
        mRightBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mRightBtn?.setImage(UIImage.init(named: "fuxuankuangicon1"), for: UIControl.State.normal)
        mRightBtn?.setImage(UIImage.init(named: "fuxuankuangicon2"), for: UIControl.State.normal)
        self.addSubview(mRightBtn!)
        mRightBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for:  UIControl.Event.touchUpInside)
        mRightBtn?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(18)
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        sender.isSelected = !sender.isSelected
        delegate?.PayOrdercCradCellBtnClick!(indexPath: indexPath! as NSIndexPath, sender: sender)
    }
    
    
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
        
            mTitleLab!.text = "5433434剩余（￥99.99）"
        }
    }
    
}


/// 选择支付方式的header
let PayTypeHeaderId = "PayTypeHeaderId"
let PayTypeHeaderH:CGFloat = 55

class PayTypeHeader: UITableViewHeaderFooterView {
    
    var mTitleLab:UILabel?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.boldSystemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.text = "选择支付方式"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalTo(15)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





/// 健康卡的header
let PayOrderCradHeaderId = "PayOrderCradHeaderId"
let PayOrderCradHeaderH:CGFloat = 55

class PayOrderCradHeader: UITableViewHeaderFooterView {
    
    var section:NSInteger?
    
    var mLeftImg:UIImageView?
    var mTitleLab:UILabel?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        
        mLeftImg = UIImageView.init()
        contentView.addSubview(mLeftImg!)
        mLeftImg?.clipsToBounds = true
        mLeftImg?.layer.cornerRadius = 15
        mLeftImg?.backgroundColor = TitleColor
        mLeftImg?.image = UIImage.init(named: "zhineng_zhifubao")
        mLeftImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        })
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.text = "健康礼卡"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalTo((mLeftImg?.snp.right)!).offset(10)
            make.width.equalTo(SCREEN_Width - 100)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



/// 支付列表添加健康卡
let PayOrderAddCradFooterId:String = "PayOrderAddCradFooterId"
let PayOrderAddCradFooterH:CGFloat = 45

class PayOrderAddCradFooter: UITableViewHeaderFooterView {
    
    weak var delegate:PBViewsDelegate?
    
    var mLeftImg:UIImageView?
    var mTitleLab:UILabel?
    var mButton:UIButton?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        mLeftImg = UIImageView.init()
        contentView.addSubview(mLeftImg!)
        mLeftImg?.clipsToBounds = true
        mLeftImg?.layer.cornerRadius = 15
        mLeftImg?.isUserInteractionEnabled = true
        mLeftImg?.image = UIImage.init(named: "tianjiachengyuan")
        mLeftImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(40)
            make.centerY.equalToSuperview()
        })
        
        
        mTitleLab = UILabel.init()
        self.contentView.addSubview(mTitleLab!)
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.font = UIFont.systemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.left
        mTitleLab?.isUserInteractionEnabled = true
        mTitleLab?.text = "添加健康卡"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalTo((mLeftImg?.snp.right)!).offset(10)
            make.width.equalTo(SCREEN_Width - 100)
        })
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mButton!)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for:  UIControl.Event.touchUpInside)
        mButton?.snp.makeConstraints({ (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        })

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        delegate?.PayOrderAddCradFooterBtnClick!(sender: sender)
    }
}
