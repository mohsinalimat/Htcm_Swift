//
//  MineHeaderImgController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

class MineHeaderImgController: BaseController {
    
    //头像
    var mImgView:UIImageView?
    //选择图片
    var mAddImage:SSAddImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "用户头像")
        self.setRightOneBtnTitle(string: "更新")
        
        mImgView = UIImageView.init()
        mImgView?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Width)
        mImgView?.centerX = SCREEN_Width * 0.5
        mImgView?.centerY = SCREEN_Height * 0.5
        mImgView?.image = UIImage.init(named: "touxiang_weidenglu")
        view.addSubview(mImgView!)
        
        
    }
    
    //返回 更新头像
    override func navgationButtonClick(sender: UIButton) {
        if(sender == leftBtn1){
            self.navigationController?.popViewController(animated: true)
        }
        else{
            
            DispatchQueue.main.async(execute: {
                self.mAddImage = SSAddImage()
                self.mAddImage!.getImagePicker(controller: self, modelType: SSImagePickerModelType.SSImagePickerModelImage, pickerBlock: { (_ style:SSImagePickerWayStyle,_ type:SSImagePickerModelType,_ datas:Any) in
                    
                    self.mImgView?.image = (datas as! UIImage)
                    
                })
            })
        }
    }

}
