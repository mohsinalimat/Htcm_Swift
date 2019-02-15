//
//  PBPayController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

class PBPayController: BaseController  ,UITableViewDelegate,UITableViewDataSource,PBViewsDelegate {
    
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    //单例
    var user:UserDefaults?
    
    var mPayButton:UIButton?
    
    override init() {
        super.init()
        user = UserDefaults.standard
        self.datas = NSMutableArray.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "支付方式")
        
        mPayButton = UIButton.init(type: UIButton.ButtonType.custom)
        view.addSubview(mPayButton!)
        mPayButton?.setTitle("确认支付", for: UIControl.State.normal)
        mPayButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        mPayButton?.backgroundColor = TitleColor
        mPayButton?.tag = 11
        mPayButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mPayButton?.addTarget(self, action: #selector(payButtonPressed(sender:)), for: UIControl.Event.touchUpInside)
        mPayButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(SCREEN_Width)
            make.height.equalTo(50)
            make.left.equalTo(0)
            make.bottom.equalTo(-SafeAreaBottom_Height)
        })
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height - 50), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.rowHeight = UITableView.automaticDimension
        mTableView?.estimatedRowHeight = 100
        
        
        mTableView?.register(PayOrderCell.classForCoder(), forCellReuseIdentifier: PayOrderCellId)
        mTableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        mTableView?.register(PayOrdercCradCell.classForCoder(), forCellReuseIdentifier: PayOrdercCradCellId)
        mTableView?.register(PayOrderCradHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: PayOrderCradHeaderId)
        mTableView?.register(PayOrderAddCradFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: PayOrderAddCradFooterId)
        mTableView?.register(PayTypeHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: PayTypeHeaderId)
        
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        mTableView?.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){return 0.01}
        else if(section == 1){return PayTypeHeaderH}
        else {return 55}
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){return nil}
        else if(section == 1){
            let header:PayTypeHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: PayTypeHeaderId) as! PayTypeHeader
            return header
        }
        else{
            let header:PayOrderCradHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: PayOrderCradHeaderId) as! PayOrderCradHeader
            header.section = section
            return header
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 0){ return 10 }
        else if (section == 1){ return 0.01 }
        else {return 40}
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section == 0 || section == 1){return nil}
        else{
            let footer:PayOrderAddCradFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: PayOrderAddCradFooterId) as! PayOrderAddCradFooter
            footer.delegate = self as PBViewsDelegate
            return footer
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){return 1}
        else if(section == 1){return 1}
        else {return 1}
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){return 55}
        else if(indexPath.section == 1){return PayOrderCellH}
        else {return PayOrdercCradCellH}
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let att =  [NSAttributedString.Key.foregroundColor: UIColor.red]
            let string = NSMutableAttributedString.init(string: "支付金额：￥99.00")
            string.addAttributes(att, range: NSRange.init(location: 5, length: 6))
            
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.attributedText = string
            return cell
        }
        else if(indexPath.section == 1){
            let cell:PayOrderCell = tableView.dequeueReusableCell(withIdentifier: PayOrderCellId, for: indexPath) as! PayOrderCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.delegate = (self as PBViewsDelegate)
            cell.indexPath = indexPath as IndexPath
            cell.dataDic = NSDictionary.init()
            return cell
        }
        else{
            let cell:PayOrdercCradCell = tableView.dequeueReusableCell(withIdentifier: PayOrdercCradCellId, for: indexPath) as! PayOrdercCradCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.delegate = (self as PBViewsDelegate)
            cell.indexPath = indexPath
            cell.dataDic = NSDictionary.init()
            return cell
        }
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    //支付方式选择
    func PBPayOrderCellBtnClick(indexPath: NSIndexPath, sender: UIButton) {
        
        
    }
    
    //卡片里面的选项按钮点击
    func PayOrderAddCradFooterBtnClick(sender: UIButton) {
        let vc:MineAddVipCardController = MineAddVipCardController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    
    //支付
    @objc func payButtonPressed(sender:UIButton){
        
        
    }
    
}
