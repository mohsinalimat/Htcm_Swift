//
//  SSDatePickerController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/23.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

protocol SSDatePickerViewDelegate:NSObjectProtocol{
    
    func SSDatePickerViewResult(index:NSInteger,date:NSString)
}

/// 时间选择器
let SSDatePickerViewW:CGFloat =  SCREEN_Width-30
let SSDatePickerViewH:CGFloat =  320

class SSDatePickerView: UIView {
    
    weak var delegate:SSDatePickerViewDelegate?
    
    var mTitleLab:UILabel?
    var mBackBtn:UIButton?
    var mOKBtn:UIButton?
    var datePicker:UIDatePicker?
    var timeString:NSString?
    
    var line1:UIView?
    var line2:UIView?
    var line3:UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        timeString = ""
        
        mTitleLab = UILabel.init()
        mTitleLab?.font = UIFont.boldSystemFont(ofSize: 14)
        mTitleLab?.textAlignment = NSTextAlignment.center
        mTitleLab?.textColor = UIColor.hexStringToColor(hexString: "333333")
        mTitleLab?.text = "请选择日期"
        self.addSubview(mTitleLab!)
        mTitleLab?.snp.makeConstraints({ (make) in
            make.width.equalTo(SSDatePickerViewW)
            make.height.equalTo(50)
            make.top.equalTo(0)
            make.left.equalTo(0)
        })
        
        
        line1 = UIView.init()
        line1?.backgroundColor = CellLineColor
        self.addSubview(line1!)
        line1?.snp.makeConstraints({ (make) in
             make.width.equalTo(SSDatePickerViewW)
             make.height.equalTo(0.5)
             make.bottom.equalTo(mTitleLab!)
             make.left.equalTo(0)
        })
        
        
        mBackBtn = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mBackBtn!)
        mBackBtn?.setTitle("取消", for: UIControl.State.normal)
        mBackBtn?.setTitleColor(TitleColor, for: UIControl.State.normal)
        mBackBtn?.tag = 10
        mBackBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mBackBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mBackBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width * 0.5)
            make.height.equalTo(45)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        
        mOKBtn = UIButton.init(type: UIButton.ButtonType.custom)
        self.addSubview(mOKBtn!)
        mOKBtn?.setTitle("确认", for: UIControl.State.normal)
        mOKBtn?.setTitleColor(TitleColor, for: UIControl.State.normal)
        mOKBtn?.tag = 11
        mOKBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mOKBtn?.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mOKBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width * 0.5)
            make.height.equalTo(45)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        
        line2 = UIView.init()
        line2?.backgroundColor = CellLineColor
        self.addSubview(line2!)
        line2?.snp.makeConstraints({ (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(45)
            make.bottom.equalTo(0)
            make.centerX.equalToSuperview()
        })
        
        
        line3 = UIView.init()
        line3?.backgroundColor = CellLineColor
        self.addSubview(line3!)
        line3?.snp.makeConstraints({ (make) in
            make.width.equalTo(SSDatePickerViewW)
            make.height.equalTo(0.5)
            make.top.equalTo((mOKBtn?.snp.top)!)
            make.left.equalTo(0)
        })
        
        
        datePicker = UIDatePicker.init()
        datePicker?.locale = NSLocale.init(localeIdentifier: "zh") as Locale
        datePicker!.datePickerMode = UIDatePicker.Mode.date
        datePicker?.addTarget(self, action: #selector(valueChange(picker:)), for: UIControl.Event.valueChanged)
        datePicker?.minimumDate = Date.init()
        datePicker?.maximumDate = Date.init(timeInterval: 365*24*60*60, since: Date.init())
        self.addSubview(datePicker!)
        datePicker?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(45)
            make.width.equalTo(SSDatePickerViewW)
            make.bottom.equalTo(-45)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(sender:UIButton){
        
        delegate?.SSDatePickerViewResult(index: sender.tag, date: timeString!)
    }
    
    
    //时间选择器的时间发生变化
    @objc func valueChange(picker:UIDatePicker){

        let fmt = DateFormatter.init()
        fmt.dateFormat = "YYYY-MM-dd"
        timeString = fmt.string(from: (datePicker?.date)!) as NSString
    }
    
    
}



/// 选择时间回调
typealias  DatePickerBlock = (_ date: NSString) -> ()

/// 时间选择器的控制器
class SSDatePickerController: UIViewController,SSDatePickerViewDelegate{
    
    var datePickerBlock:DatePickerBlock?
    var datePickerView:SSDatePickerView?
    var backView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        backView = UIView.init()
        backView?.frame = view.bounds
        view.addSubview(backView!)
        backView?.backgroundColor = UIColor.black
        backView?.alpha = 0.01
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init()
        tap.addTarget(self, action: #selector(tapAction(action:)))
        self.view.addGestureRecognizer(tap)
       
        datePickerView = SSDatePickerView.init(frame: CGRect.init(x: 0, y: 0, width: SSDatePickerViewW, height: SSDatePickerViewH))
        datePickerView?.delegate = self
        datePickerView?.centerX = SCREEN_Width * 0.5
        datePickerView?.centerY = SCREEN_Height * 0.5
        datePickerView!.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        view.addSubview(datePickerView!)
        
    }
    
    //设置动画
    func setPickerViewAnimation(){
        datePickerView!.animateIn()
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.backView?.alpha = 0.5
        }) { (Bool) in
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    @objc func tapAction(action:UITapGestureRecognizer) -> Void {
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.backView?.alpha = 0.01
            self.datePickerView!.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { (Bool) in
            self.view.isUserInteractionEnabled = true
            self.backView?.removeFromSuperview()
            self.datePickerView?.removeFromSuperview()
            self.backView = nil
            self.datePickerView = nil
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //返回结果 取消10  确认11
    func SSDatePickerViewResult(index: NSInteger, date: NSString) {
        self.tapAction(action: UITapGestureRecognizer())
        if(index == 11){
            datePickerBlock!(date)
        }
    }

}
