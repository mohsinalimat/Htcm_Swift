//
//  MineChangePhoneController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

//更换手机号
class MineChangePhoneController: BaseController {
    
    //顶部背景视图
    var backView:UIView?
    //手机图片
    var mImgView:UIImageView?
    //手机号
    var mLabel:UILabel?
    //确定按钮
    var mLoginBtn:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackGroundColor
        self.setNavgaionTitle(string: "更换手机号")
        
        backView = UIView.init()
        backView?.frame = CGRect.init(x: 0, y: SafeAreaTop_Height + 10, width: SCREEN_Width, height: 186)
        backView?.backgroundColor = UIColor.white
        view.addSubview(backView!)
        
        mImgView = UIImageView.init()
        mImgView?.bounds = CGRect.init(x: 0, y: 0, width: 48, height: 86)
        mImgView?.centerX = SCREEN_Width * 0.5
        mImgView?.top = 30
        mImgView?.image = UIImage.init(named: "shouji")
        backView?.addSubview(mImgView!)
        
        
        mLabel = UILabel.init()
        mLabel?.bounds = CGRect.init(x: 0, y: 0, width:120, height: 25)
        mLabel?.font = UIFont.systemFont(ofSize: 14)
        mLabel?.textAlignment = NSTextAlignment.center
        mLabel?.textColor = UIColor.hexStringToColor(hexString: "333333")
        backView?.addSubview(mLabel!)
        mLabel?.text = "您的手机号为135****103"
        mLabel?.sizeToFit()
        mLabel?.top = (mImgView?.bottom)! + 20
        mLabel?.centerX = (mImgView?.centerX)!
        
        
        mLoginBtn = UIButton.init(type: UIButton.ButtonType.custom)
        mLoginBtn?.bounds = CGRect.init(x: 0, y: 0, width: LoginBtnWidth, height: LoginBtnHeight)
        mLoginBtn?.centerX = SCREEN_Width * 0.5
        mLoginBtn?.top = (backView?.bottom)! + 30
        mLoginBtn?.tag = 100
        view?.addSubview(mLoginBtn!)
        mLoginBtn?.setBackgroundImage(UIImage.init(named: "htcm_anniu"), for: UIControl.State.normal)
        mLoginBtn?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mLoginBtn?.setTitle("确定", for: UIControl.State.normal)
        mLoginBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mLoginBtn?.titleEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
        mLoginBtn!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        
    }

    
    //确定
    @objc func buttonPressed(sender:UIButton){
        let vc:MineChangePhoneValidationController = MineChangePhoneValidationController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
