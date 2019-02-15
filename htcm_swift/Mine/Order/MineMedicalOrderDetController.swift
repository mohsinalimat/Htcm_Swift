//
//  MineMedicalOrderDetController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/15.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

class MineMedicalOrderDetController: BaseController ,UITableViewDelegate,UITableViewDataSource,MineOrderViewsDelegate {
    
    
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    //底部按钮
    var payBottomView:MineBottomView?
    //单例
    var user:UserDefaults?
    
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
        self.setNavgaionTitle(string: "体检订单")
        
        payBottomView = MineBottomView.init(frame: CGRect.init(x: 0, y: SCREEN_Height - SafeAreaBottom_Height - MineBottomViewH, width:SCREEN_Width , height: MineBottomViewH), style: 1)
        payBottomView?.delegate = self
        view.addSubview(payBottomView!)
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        mTableView!.height = MainViewSub_Height - MineBottomViewH
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.estimatedRowHeight = 50
        
        mTableView?.register(MineOrderDetTopHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: MineOrderDetTopHeaderId)
        mTableView?.register(MineOrderDetGeneralHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: MineOrderDetGeneralHeaderId)

        mTableView?.register(MineOrderGeneralCell.classForCoder(), forCellReuseIdentifier: MineOrderGeneralCellId)
       
        mTableView?.register(MineOrderDetailFunctionCell.classForCoder(), forCellReuseIdentifier: MineOrderDetailFunctionCellId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        datas?.addObjects(from: ["0","1",["open":"0"],["open":"0"],"3","4"])
        mTableView?.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (datas?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return MineOrderDetTopHeaderH
        }
        else if(section == 1){
            return 0
        }
        else{
            if((datas![section] as AnyObject).isKind(of: NSDictionary.classForCoder())){
                return 50
            }
            else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){
            let header:MineOrderDetTopHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineOrderDetTopHeaderId) as! MineOrderDetTopHeader
            header.section = section
            header.medicDetDic = NSDictionary.init()
            return header
        }
        else if((datas![section] as AnyObject).isKind(of: NSDictionary.classForCoder())){
            let header:MineOrderDetGeneralHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineOrderDetGeneralHeaderId) as! MineOrderDetGeneralHeader
            header.delegate = self
            header.section = section
            header.medicDetDic = (datas![section] as! NSDictionary)
            return header
        }
        else{ return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 0){ return 1}
        else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    //支付状态 手机号 项目 取消订单  预约号
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((datas![section] as AnyObject).isKind(of: NSDictionary.classForCoder())){
            let dic:NSDictionary = datas![section] as! NSDictionary
            if((dic.value(forKey: "open")as! String) == "0"){
                return 0
            }
            else{ return 4 }
        }
        else{
            let index:NSInteger = (datas![section] as! NSString).integerValue
            if(index == 0){
                return 4
            }
            else if(index == 1){
                return 1
            }
            else if(index == 3){
                return 2
            }
            else{
                return 2
            }
        }
    }
    
    //支付状态 手机号 项目 取消订单  预约号
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if((datas![indexPath.section] as AnyObject).isKind(of: NSDictionary.classForCoder())){
            return MineOrderGeneralCellH
        }
        else{
        
            let index:NSInteger = (datas![indexPath.section] as! NSString).integerValue
            if(index == 0){
                if(indexPath.row != 3){
                    return MineOrderGeneralCellH
                }
                else{
                    return UITableView.automaticDimension
                }
            }
            else if(index == 1){
                return MineOrderGeneralCellH2
            }
            else if(index == 3){
                return MineMedicalOrderListCellH
            }
            else{
                return MineMedicalOrderListCellH
            }
        }

    }
    
    //支付状态 手机号 项目 取消订单  预约号
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if((datas![indexPath.section] as AnyObject).isKind(of: NSDictionary.classForCoder())){
            let cell:MineOrderGeneralCell = tableView.dequeueReusableCell(withIdentifier: MineOrderGeneralCellId, for: indexPath) as! MineOrderGeneralCell
            cell.indexPath = indexPath as IndexPath
            cell.medicalProDic = (datas![indexPath.section] as! NSDictionary)
            return cell
        }
        else{
            let index:NSInteger = (datas![indexPath.section] as! NSString).integerValue
            if(index == 0){
                let cell:MineOrderGeneralCell = tableView.dequeueReusableCell(withIdentifier: MineOrderGeneralCellId, for: indexPath) as! MineOrderGeneralCell
                cell.indexPath = indexPath as IndexPath
                cell.medicalDetDic = NSDictionary.init()
                return cell
            }
            else if(index == 3){
                if(indexPath.row == 0){
                    let cell:MineOrderGeneralCell = tableView.dequeueReusableCell(withIdentifier: MineOrderGeneralCellId, for: indexPath) as! MineOrderGeneralCell
                    cell.indexPath = indexPath as IndexPath
                    cell.medicalPayDic = NSDictionary.init()
                    return cell
                }
                else{
                    let cell:MineOrderDetailFunctionCell = tableView.dequeueReusableCell(withIdentifier: MineOrderDetailFunctionCellId, for: indexPath) as! MineOrderDetailFunctionCell
                    cell.delegate = self
                    return cell
                }
            }
            else{
                let cell:MineOrderGeneralCell = tableView.dequeueReusableCell(withIdentifier: MineOrderGeneralCellId, for: indexPath) as! MineOrderGeneralCell
                cell.indexPath = indexPath as IndexPath
                cell.medicalDetString = (datas![indexPath.section] as! String)
                return cell
            }
            
        }
        
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    //取消订单100  联系客服101
    func MineOrderDetailCancelCell(sender: UIButton) {
        
    }
    
    //项目展开收起回调
    func MineOrderDetPriceHeader(section: NSInteger) {
        let dic:NSMutableDictionary = NSMutableDictionary.init(dictionary: datas![section]as! NSDictionary)
        if((dic["open"]as! String) == "0"){
            dic.setValue("1", forKey: "open")
        }else{
            dic.setValue("0", forKey: "open")
        }
        
        datas![section] = dic
        mTableView?.reloadData()
    }
    
    
    //立即支付
    func MineBottomViewButtonClick(sender: UIButton) {
        
        let vc:PBPayController = PBPayController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
