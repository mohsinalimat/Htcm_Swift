//
//  UIButton+Add.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/28.
//  Copyright © 2018 soldoros. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{


    
    /// 按钮的图文垂直居中
    ///
    /// - Parameters:
    ///   - height: 垂直高度
    ///   - distance: 垂直间距
    func setImgTitleVerticalCenter(height:CGFloat,distance:CGFloat){
      
        var imgViewSize:CGSize?
        var titleSize:CGSize?
        var btnSize:CGSize?
        
        var imgViewEdge:UIEdgeInsets?
        var titleEdge:UIEdgeInsets?
        
        imgViewSize = self.imageView?.bounds.size
        titleSize = self.titleLabel?.bounds.size
        btnSize = self.bounds.size
        
        imgViewEdge = UIEdgeInsets.init(top: height, left: 0, bottom: (btnSize?.height)! - (imgViewSize?.height)! - height, right: distance * 0.5 - (titleSize?.width)!)
        titleEdge = UIEdgeInsets.init(top: (imgViewSize?.height)! + height, left: 0 - (imgViewSize?.width)!, bottom: 0, right: 0)
   
        self.imageEdgeInsets = imgViewEdge!
        self.titleEdgeInsets = titleEdge!
        
    }

    
    /// 按钮的图文左右居中 文字在左 图片在右
    func setImgTitleCenteredAround(){
        
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center;
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: (self.imageView?.size.width)!, bottom: 0, right: (self.imageView?.size.width)!)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: self.titleLabel!.bounds.size.width+5, bottom: 0, right: 0 - self.titleLabel!.bounds.size.width)
        
    }

}
