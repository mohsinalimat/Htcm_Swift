//
//  UIImage+Add.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/28.
//  Copyright © 2018 soldoros. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{

    
    //通过颜色生成图片
    class func  imageFromColor(color:UIColor)->UIImage{
 
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return img
        
    }
    
    
    //通过颜色生成图片 带上frame
    class func imageFromColor(color:UIColor, frame:CGRect)->UIImage{
    
        let rect = frame
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return img
        
    }
    
    
    /// 更改图片的颜色
    ///
    /// - Parameter color: 传入颜色值
    /// - Returns: 返回图片
    func imageWithColor(color:UIColor)->UIImage{
        
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!

    }
    
    
    //给图片设置拉伸保护区域 保护左侧和右侧
    class func setImgWithProtectWidth(imageStr:NSString, width:CGFloat)->UIImage {
        
        let image = UIImage.init(named: imageStr as String)
        let insets:UIEdgeInsets = UIEdgeInsets.init(top: 0, left: width, bottom: 0, right: width)
        image?.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)
        return image!
        
    }
    
    
    //给图片设置拉伸保护区域 保护上下左右
    class func setImgWithProtectInsets(imageStr:NSString, insets:UIEdgeInsets)->UIImage {
        
        let image = UIImage.init(named: imageStr as String)
        image?.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)
        return image!
        
    }
    
    
    /// 根据字符串生成二维码
    ///
    /// - Parameter qrString: 传入字符串
    /// - Returns: 返回二维码图片
    class func qrCodeImageWithContent(qrString: String,size:CGFloat) -> UIImage?{
     
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(qrString.data(using: String.Encoding.utf8), forKey: "inputMessage")
        //取出生成的二维码（不清晰）
        if let outputImage = filter?.outputImage {
            //生成清晰度更好的二维码
            let qrCodeImage:UIImage = UIImage.setupHighDefinitionUIImage(outputImage, width1: size,height1: size)
            return qrCodeImage
        }
        
        return UIImage()
        
    }
    
    
    /// 生成条形码
    ///
    /// - Parameters:
    ///   - messgae: 传入字符串
    ///   - width: 传入条形码宽度
    ///   - height: 传入条形码高度
    /// - Returns: 返回条形码图片
    class func barcodeImageWithContent(messgae:NSString,width:CGFloat,height:CGFloat) -> UIImage {
        var returnImage:UIImage?
        if (messgae.length > 0 && width > 0 && height > 0){
            let inputData:NSData? = messgae.data(using: String.Encoding.utf8.rawValue)! as NSData
            // CICode128BarcodeGenerator
            let filter = CIFilter.init(name: "CICode128BarcodeGenerator")!
            filter.setValue(inputData, forKey: "inputMessage")
            var ciImage = filter.outputImage!
            let scaleX = width/ciImage.extent.size.width
            let scaleY = height/ciImage.extent.size.height
            ciImage = ciImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
            let qrCodeImage:UIImage = UIImage.setupHighDefinitionUIImage(ciImage, width1: width,height1: height)
            returnImage = qrCodeImage
        }else {
            returnImage = nil;
        }
        return returnImage!
    }
    
    
    
    //生成高清的UIImage
    class func setupHighDefinitionUIImage(_ image: CIImage, width1: CGFloat, height1:CGFloat) -> UIImage {
        
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(width1/integral.width, height1/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
        
    }
    
    
    
   
    
}
