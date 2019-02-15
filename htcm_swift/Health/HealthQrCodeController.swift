//
//  HealthQrCodeController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/23.
//  Copyright © 2019 soldoros. All rights reserved.
//


//二维码界面
import UIKit

class HealthQrCodeController: BaseController {
    
    
    var mHeaderImg:UIImageView?
    var mNamelab:UILabel?
    var mCodeImg:UIImageView?
    var mTitleLab:UILabel?
    var mDetLab:UILabel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setRightOneBtnImg(imgStr: "wh_shanchu")
        self.leftBtn1?.removeFromSuperview()
        self.leftBtn1 = nil
        self.navLine?.isHidden = true
        
        mHeaderImg = UIImageView.init()
        mHeaderImg?.clipsToBounds = true
        mHeaderImg?.layer.cornerRadius = 45
        view.addSubview(mHeaderImg!)
        mHeaderImg?.image = UIImage.init(named: "touxiang_weidenglu")
        mHeaderImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(90)
            make.centerX.equalToSuperview()
            make.top.equalTo(80)
        })
        
        
        
        mNamelab = UILabel.init()
        mNamelab?.font = UIFont.boldSystemFont(ofSize: 20)
        mNamelab?.textAlignment = NSTextAlignment.center
        mNamelab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        view.addSubview(mNamelab!)
        mNamelab?.text = "神经萝卜"
        mNamelab?.snp.makeConstraints({ (make) in
            make.top.equalTo((mHeaderImg?.snp.bottom)!).offset(10)
            make.centerX.equalToSuperview()
        })
        
        
        let image:UIImage = UIImage.qrCodeImageWithContent(qrString: "13540033103", size: 40)!
        
        mCodeImg = UIImageView.init()
        mCodeImg?.image = image
        view.addSubview(mCodeImg!)
        mCodeImg?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(SCREEN_Width * 0.6)
            make.centerX.equalToSuperview()
            make.top.equalTo((mNamelab?.snp.bottom)!).offset(30)
        })
        
        
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.systemFont(ofSize: 12)
        mTitleLab?.textAlignment = NSTextAlignment.center
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "999999")
        view.addSubview(mTitleLab!)
        mTitleLab?.text = "成都中医大健康体检中心"
        mTitleLab?.snp.makeConstraints({ (make) in
            make.top.equalTo((mCodeImg?.snp.bottom)!).offset(40)
            make.centerX.equalToSuperview()
        })
        
        
        
        let string = NSString.getBlankSpaceString(string: "345234525234534", space: 4)
        
        mDetLab = UILabel.init()
        mDetLab?.font = UIFont.systemFont(ofSize: 12)
        mDetLab?.textAlignment = NSTextAlignment.center
        mDetLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        view.addSubview(mDetLab!)
        mDetLab?.text = string as String
        mDetLab?.snp.makeConstraints({ (make) in
            make.top.equalTo((mTitleLab?.snp.bottom)!).offset(5)
            make.centerX.equalToSuperview()
        })
        
    }

    
    override func navgationButtonClick(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
