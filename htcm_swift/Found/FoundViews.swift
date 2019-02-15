//
//  FoundViews.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/24.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

@objc protocol FoundViewsDelegate:NSObjectProtocol {
    
    //发现首页顶部cell按钮点击代理协议
    @objc optional func FoundTopCellBtnClick(indexPath:NSIndexPath, sender:UIButton)
}


/// 发现页面顶部cell
let FoundTopCellH:CGFloat = 215 * SCREEN_Width / 375
let FoundTopCellId = "FoundTopCellId"

class FoundTopCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        let sizeW:CGFloat = SCREEN_Width / 4
        let sizeH:CGFloat = FoundTopCellH * 0.5 - 15
        let imgSize:CGFloat = NSObject.getNumber(i5: 40, i6: 45, iPlus: 50, iPX: 60)
        
        let titles:NSArray = ["机构详情","部门科室","专家队伍","健康工具","特色服务","医疗美容"]
        let images:NSArray = ["t_jigouxiangqing","t_keshijianjie","t_zhuanjiaduiwu","t_jiankanggongju","t_tesefuwu","t_meirong"]
        
        for index in 0...titles.count-1{
            
            let top:CGFloat = CGFloat(index / 4) * CGFloat(sizeW + 5) + 10
            let left:CGFloat = CGFloat(index % 4) * sizeW
           
            let backView:UIView = UIView.init()
            backView.bounds = CGRect.init(x: 0, y: 0, width: sizeW, height: sizeH)
            backView.left = left
            backView.top = top
            backView.backgroundColor =  UIColor.white
            self.contentView.addSubview(backView)
            
            let button:UIButton = UIButton.init()
            button.bounds = CGRect.init(x: 0, y: 0, width: imgSize, height: imgSize)
            button.centerX = backView.width * 0.5
            button.top = 10
            button.tag = 10 + index
            button.setImage(UIImage.init(named: images[index] as! String), for: UIControl.State.normal)
            backView.addSubview(button)
                 button.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
            
            let label:UILabel = UILabel.init()
            label.bounds = CGRect.init(x: 0, y: 0, width: backView.width - 15, height: 25)
            label.top = button.bottom + 5
            label.centerX =  backView.width * 0.5
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = NSTextAlignment.center
            label.isUserInteractionEnabled = true
            backView.addSubview(label)
            label.text = (titles[index] as! String)
            
        }
    }
    
    
    //按钮点击
    @objc func buttonPressed(sender:UIButton){
        
        
    }

}



/// 发现页面顶部cell
let FoundBeautyCellH:CGFloat = 123
let FoundBeautyCellId = "FoundBeautyCellId"

class FoundBeautyCell: UITableViewCell ,UIScrollViewDelegate{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mScrollView:UIScrollView?
    var scrollerHeight:CGFloat?
    var btnWidth:CGFloat?
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white

        scrollerHeight = 94
        btnWidth = scrollerHeight! * 2.5
        
        mScrollView = UIScrollView.init()
        mScrollView?.frame = CGRect.init(x: 0, y: 10, width: SCREEN_Width, height: scrollerHeight!)
        mScrollView?.backgroundColor = UIColor.white
        mScrollView?.isPagingEnabled = false
        mScrollView?.delegate = self
        self.contentView.addSubview(mScrollView!)
        mScrollView?.maximumZoomScale = 2.0;
        mScrollView?.minimumZoomScale = 0.5;
        mScrollView?.canCancelContentTouches = false
        mScrollView?.delaysContentTouches = true
        mScrollView?.showsVerticalScrollIndicator = false;
        mScrollView?.showsHorizontalScrollIndicator = false;
        
    }
    
    
    //发现页面医疗美容数据
    private var _dataArray:NSMutableArray?
    var dataArray:NSMutableArray?{
        didSet{
            _dataArray = dataArray
            
            let number:NSInteger = 5
        
            let Width:CGFloat = btnWidth! * CGFloat(number) + CGFloat(11 * number)
            
            mScrollView!.contentSize = CGSize.init(width: Width, height: scrollerHeight!)
          
            for children in (mScrollView?.subviews)!{
                children.removeFromSuperview()
            }
            
            
            for index in 0...number-1{
                
                let imgv:UIImageView = UIImageView.init()
                imgv.frame = CGRect.init(x: 0, y: 0, width: btnWidth!, height: scrollerHeight!)
                imgv.left = CGFloat(index) * CGFloat(imgv.width + 10) + 10
                imgv.clipsToBounds = true
                imgv.layer.cornerRadius = 4
                imgv.tag = 10 + index
                imgv.isUserInteractionEnabled = true
                imgv.image = UIImage.init(named: ImagePlaceHoder3)
                mScrollView?.addSubview(imgv)
                
            }
            
        }
        
    }
    

}




/// 发现页面顶部cell
let FoundServiceListCellH:CGFloat = 110
let FoundServiceListCellId = "FoundServiceListCellId"

class FoundServiceListCell: UITableViewCell ,UIScrollViewDelegate{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //线条
    var mLine:UIView?
    //左侧头像
    var mHeaderImg:UIImageView?
    //名字
    var mNameLab:UILabel?
    //职业
    var mJobLab:UILabel?
    //擅长
    var mGoodLab:UILabel?
    //评分
    var mScoreBtn:UIButton?
    //服务次数
    var mNumerLab:UILabel?
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white


        mLine = UIView.init()
        mLine?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - 15, height: 1)
        mLine?.left = 15
        mLine?.bottom = FoundServiceListCellH
        mLine?.backgroundColor = LineColor
        self.contentView.addSubview(mLine!)
        
        mHeaderImg = UIImageView.init()
        mHeaderImg?.bounds = CGRect.init(x: 0, y: 0, width: 94, height: 83)
        mHeaderImg?.centerY = FoundServiceListCellH * 0.5
        mHeaderImg?.left = 15
        mHeaderImg?.image = UIImage.init(named: ImagePlaceHoder6)
        mHeaderImg?.clipsToBounds = true
        mHeaderImg?.layer.cornerRadius = 5
        mHeaderImg?.contentMode = UIView.ContentMode.scaleToFill
        self.contentView.addSubview(mHeaderImg!)
        
        
        mNameLab = UILabel.init()
        mNameLab?.bounds = CGRect.init(x: 0, y: 0, width: 80, height: 25)
        mNameLab?.textAlignment = NSTextAlignment.left
        mNameLab?.font = UIFont.systemFont(ofSize: 16)
        mNameLab?.textColor = UIColor.hexStringToColor(hexString: "33333")
        self.contentView.addSubview(mNameLab!)
        mNameLab?.text =  "特色中医助孕管理"
        mNameLab?.sizeToFit()
        mNameLab?.top = (mHeaderImg?.top)!
        mNameLab?.left = (mHeaderImg?.right)! + 20
        
        
        mGoodLab = UILabel.init()
        mGoodLab?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width - (mHeaderImg?.right)! - 30, height: 25)
        mGoodLab?.textAlignment = NSTextAlignment.left
        mGoodLab?.font = UIFont.systemFont(ofSize: 14)
        mGoodLab?.textColor = UIColor.gray
        self.contentView.addSubview(mGoodLab!)
        mGoodLab?.numberOfLines = 2
        mGoodLab?.text =  "针对长期备孕不成功或为孕育宝宝做准备的人群，通过中医整体调养，辨症实施。"
        mGoodLab?.sizeToFit()
        mGoodLab?.top = (mNameLab?.bottom)! + 5
        mGoodLab?.left = (mNameLab?.left)!
        
        
        mJobLab = UILabel.init()
        mJobLab?.bounds = CGRect.init(x: 0, y: 0, width: 80, height: 25)
        mJobLab?.textAlignment = NSTextAlignment.left
        mJobLab?.font = UIFont.systemFont(ofSize: 12)
        mJobLab?.textColor = UIColor.lightGray
        self.contentView.addSubview(mJobLab!)
        mJobLab?.text =  "317人已享受"
        mJobLab?.sizeToFit()
        mJobLab?.bottom = (mHeaderImg?.bottom)!
        mJobLab?.left = (mNameLab?.left)!
        
    }
 
    
    //发现页面特色服务数据
    private var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        didSet{
            _dataDic = dataDic
            
            
        }
        
    }
}
