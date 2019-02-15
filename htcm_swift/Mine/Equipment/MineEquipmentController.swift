//
//  MineEquipmentController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/25.
//  Copyright © 2019 soldoros. All rights reserved.
//

//我的设备
import UIKit

class MineEquipmentController: BaseController {
    
    var mImgView:UIImageView?
    var mLabel:UILabel?
    var mButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackGroundColor
        self .setNavgaionTitle(string: "我的设备")

        mImgView = UIImageView.init()
        mImgView?.image = UIImage.init(named: "kong")
        view.addSubview(mImgView!)
        mImgView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(156)
            make.centerX.equalToSuperview()
            make.top.equalTo(104 + SafeAreaTop_Height)
        })
        
        mLabel = UILabel.init()
        mLabel?.textAlignment = NSTextAlignment.center
        mLabel?.font = UIFont.systemFont(ofSize: 14)
        mLabel?.textColor = UIColor.hexStringToColor(hexString: "999999")
        view.addSubview(mLabel!)
        mLabel?.text = "未找到可添加的设备"
        mLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo((mImgView?.snp.bottom)!).offset(20)
        })
        
        
        mButton = UIButton.init(type: UIButton.ButtonType.custom)
        view.addSubview(mButton!)
        mButton?.setTitle("立即搜索", for: UIControl.State.normal)
        mButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mButton?.backgroundColor = TitleColor
        mButton?.tag = 11
        mButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        mButton?.setBackgroundImage(UIImage.init(named: "denglu_bg1"), for: UIControl.State.normal)
        mButton?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width)
            make.height.equalTo(50)
            make.left.equalTo(0)
            make.bottom.equalTo(-SafeAreaBottom_Height)
        })
        
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
    }

}
