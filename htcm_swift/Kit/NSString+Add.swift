//
//  NSString+Add.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/10.
//  Copyright © 2019 soldoros. All rights reserved.
//

import Foundation
import UIKit

extension NSString{

    
    /// 将字符串每间隔number个就生成一个空格再返回
    ///
    /// - Parameters:
    ///   - number: 传入间隔的数量
    /// - Returns: 返回处理后的字符串
    func getStringWithInterval(number:NSInteger) -> NSString{
        
        let num:NSNumber = NSNumber.init(value: self.integerValue)
        let formatter:NumberFormatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = number
        formatter.groupingSeparator = " "
        
        return formatter.string(from: num)! as NSString
    }

    
    
    /// 获取文本的尺寸
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - font: 字体
    ///   - maxSize: 最大宽高
    /// - Returns: 返回尺寸
    class func getTextSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }

    
    
    /// 设置字符串的高度
    ///
    /// - Parameters:
    ///   - string: 传入字符串
    ///   - height: 传入行间距
    /// - Returns: 返回可变字符串
    class func getAttstringWithHeight(string:String,height:CGFloat)->NSMutableAttributedString{
    
        let attString = NSMutableAttributedString(string:string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = height
        attString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, string.count))
        return attString
        
    }
    
    
    /// 设置字符串的颜色
    ///
    /// - Parameters:
    ///   - string: 传入字符串
    ///   - color: 传入颜色
    /// - Returns: 返回可变字符串
    class func getAttstringWithColor(string:String,color:UIColor,rang:NSRange)->NSMutableAttributedString{
        
        let attString = NSMutableAttributedString.init(string: string)
        attString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: rang)
        return attString
    }
    
    /// 设置字符串的大小
    ///
    /// - Parameters:
    ///   - string: 传入字符串
    ///   - font: 传入字体
    /// - Returns: 返回可变字符串
    class func getAttstringWithFont(string:String,font:UIFont,rang:NSRange)->NSMutableAttributedString{
        
        let attString = NSMutableAttributedString.init(string: string)
        attString.addAttribute(NSAttributedString.Key.font, value: font,range: rang)
        return attString
    }
    
    
    
    
    /// 将字符串处理成间隔空格的字符串
    ///
    /// - Parameters:
    ///   - string: 传入完整的字符串
    ///   - space: 每间隔space个字符就增加一个空格
    /// - Returns: 返回处理后的字符串
    class func getBlankSpaceString(string:NSString, space:NSInteger)->NSString{
        
        let number = NSNumber.init(floatLiteral: string.doubleValue)
        let formatter:NumberFormatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = space
        formatter.groupingSeparator = " "
        let str = formatter.string(from: number)
        return str as! NSString
    }
    
    
}
