//
//  SSTableSwitchView.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/14.
//  Copyright © 2019 soldoros. All rights reserved.
//

//我的收藏列表
import UIKit
import SnapKit


//列表定不筛选的按钮点击代码块
typealias SSTableSwitchViewBlock = (_ sender:UIButton) -> ()


//列表定不筛选的固定视图
class SSTableSwitchView: UIView {
    
    var _switchBlock:SSTableSwitchViewBlock?
    
    //按钮数组
    var _buttonArr:NSArray?
    //按钮文字选中颜色 未选中颜色 尺寸
    var _btnDefaultColor:UIColor?
    var _btnSelectedColor:UIColor?
    var _btnFont:UIFont?
    //线条、线条颜色、当前选中的按钮
    var _line:UIView?
    var _lineColor:UIColor?
    var _currentBtn:UIButton?
    //底部线条
    var _mBottomLine:UIView?
    
    var ssWidth:CGFloat?
    var ssHeight:CGFloat?
    
    init(frame: CGRect, switchBlock:@escaping SSTableSwitchViewBlock) {
        
        super.init(frame: frame)
        
        _switchBlock = switchBlock
        
        ssWidth = self.width / 3
        ssHeight = self.height
        
        self.buttonArr = []
        self.switchColor(titleColor: TitleColor)
        _btnFont = UIFont.systemFont(ofSize: 16)
        _btnDefaultColor = UIColor.gray
        _btnSelectedColor = TitleColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置线条颜色
    func switchColor(titleColor:UIColor){
        _lineColor = titleColor
        if(_line != nil){
            _line?.backgroundColor = _lineColor
        }
    }
    
    //设置按钮
    var buttonArr:NSArray?{
        didSet{
            _buttonArr = buttonArr
            if((_buttonArr?.count)! <= 0){return}
            
            ssWidth = self.width / CGFloat((_buttonArr?.count)!)
            
            for i:NSInteger in 0...(_buttonArr?.count)!-1{
                let button:UIButton = self.buttonWithIndex(index: i)
                if(i==0){
                    _currentBtn = button
                    _currentBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                }
            }
            
            _mBottomLine = UIView.init()
            _mBottomLine?.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 1)
            _mBottomLine?.left = 0
            _mBottomLine?.bottom = self.height
            _mBottomLine?.backgroundColor = UIColor.hexStringToColor(hexString: "F0F0F0")
            self.addSubview(_mBottomLine!)
            
            let lab:UILabel = UILabel.init()
            lab.font = _currentBtn?.titleLabel?.font
            lab.text = _currentBtn?.titleLabel?.text
            lab.sizeToFit()
            
            _line = UIView.init()
            _line?.bounds = CGRect.init(x: 0, y: 0, width: lab.width, height: 2)
            _line?.centerX = ssWidth! * 0.5
            _line?.bottom = self.height
            _line?.backgroundColor = _lineColor
            self.addSubview(_line!)
            
        }
    }
    
    
    func buttonWithIndex(index:NSInteger) -> UIButton{
        
        let number:CGFloat = CGFloat(index)
        
        let btn:UIButton = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: number * ssWidth!, y: 0, width: ssWidth!, height: ssHeight!)
        btn.setTitle((_buttonArr![index] as! String), for: UIControl.State.normal)
        btn.setTitleColor(_btnDefaultColor, for: UIControl.State.normal)
        btn.setTitleColor(_btnSelectedColor, for: UIControl.State.selected)
        btn.titleLabel?.font = _btnFont
        btn.isSelected = false
        if(index == 0){btn.isSelected = true}
        btn.tag = 10 + index
        self.addSubview(btn)
        btn.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return btn
    }
    
    
    @objc func buttonPressed(sender:UIButton){
        
        if(sender == _currentBtn){return}
        
        else{
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self._currentBtn?.isSelected = false;
                self._currentBtn?.titleLabel!.font = self._btnFont;
                
                self._currentBtn = sender;
                self._currentBtn?.isSelected = true;
                self._currentBtn?.titleLabel!.font = UIFont.systemFont(ofSize: 16)
                
                
                let lab:UILabel = UILabel.init()
                lab.font = self._currentBtn?.titleLabel?.font
                lab.text = self._currentBtn?.titleLabel?.text
                lab.sizeToFit()
                self._line?.width = lab.width;
                
                self._line?.centerX = self.ssWidth! * CGFloat(sender.tag-10) + self.ssWidth! * 0.5;
                
            }) { (Bool) in
                
            }
            
            
            _switchBlock!(sender)
        }
    }
}


/// 列表定不筛选的滚动视图
class SSTableScrollSwitchView: UIView,UIScrollViewDelegate {
    
    var _switchBlock:SSTableSwitchViewBlock?
    
    var mScrollView:UIScrollView?
    var mBottomLine:UIView?
    var itemWidth:CGFloat?
    var mSitchView:SSTableSwitchView?
    
    var _array:NSArray?
    
    init(frame: CGRect, switchBlock:@escaping SSTableSwitchViewBlock) {
        
        super.init(frame: frame)
        _switchBlock = switchBlock
        itemWidth = self.width / 3.6
        
        mScrollView = UIScrollView.init()
        mScrollView?.frame = self.bounds
        mScrollView?.backgroundColor = UIColor.white
        mScrollView?.isPagingEnabled = false
        mScrollView?.delegate = self
        self.addSubview(mScrollView!)
        mScrollView?.maximumZoomScale = 2.0;
        mScrollView?.minimumZoomScale = 0.5;
        mScrollView?.canCancelContentTouches = false;
        mScrollView?.delaysContentTouches = true;
        mScrollView?.showsVerticalScrollIndicator = false;
        mScrollView?.showsHorizontalScrollIndicator = false;
        
        
        mSitchView = SSTableSwitchView.init(frame: (mScrollView?.bounds)!, switchBlock: { (sender) in
            
            var index:NSInteger = sender.tag - 10  -  1
            if(index < 0){index = 0}
            
            var point:CGPoint = CGPoint.init(x: CGFloat(index) * self.itemWidth!, y: 0)
            if(point.x > (self.mScrollView?.contentSize.width)!  - (self.mScrollView?.width)!){
                point.x = (self.mScrollView?.contentSize.width)!  - (self.mScrollView?.width)!
            }
            self.mScrollView?.setContentOffset(point, animated: true)
            self._switchBlock!(sender)
        })
        
        mScrollView?.addSubview(mSitchView!)
        mSitchView?._mBottomLine?.isHidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var array:NSArray?{
        didSet{
            _array = array
            
            var width:CGFloat = CGFloat((_array?.count)!) * itemWidth!
            if(width < self.width){
                width = self.width
            }
            
            mScrollView?.contentSize = CGSize.init(width: width, height: (mScrollView?.height)!)
            mSitchView?.frame = CGRect.init(x: 0, y: 0, width: (mScrollView?.contentSize.width)!, height: (mScrollView?.contentSize.height)!)
            mSitchView?.buttonArr = _array
        }
    }
}
