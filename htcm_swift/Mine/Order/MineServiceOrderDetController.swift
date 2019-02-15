//
//  MineServiceOrderDetController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/18.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

class MineServiceOrderDetController: BaseController ,UITableViewDelegate,UITableViewDataSource,MineOrderViewsDelegate {
    
    
    //待支付0 可使用1 已使用2 已取消3
    var style:NSInteger?
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?

    //操作按钮的视图
    var footer:MineOrderFunctionView?
    
    override init() {
        super.init()
        self.datas = NSMutableArray.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "服务订单详情")
        
        footer = MineOrderFunctionView.init(frame: CGRect.init(x: 0, y: SCREEN_Height - SafeAreaBottom_Height - MineOrderFunctionViewH, width: SCREEN_Width, height: MineOrderFunctionViewH));
        footer?.delegate = (self as MineOrderViewsDelegate)
        footer?.style = 0
        view.addSubview(footer!)
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height - MineOrderFunctionViewH), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        mTableView?.register(MineServiceOrderDetHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: MineServiceOrderDetHeaderId)
        mTableView?.register(MineServiceOrderListCell.classForCoder(), forCellReuseIdentifier: MineServiceOrderListCellId)
        
        mTableView?.register(MineServiceOrderTopBlankCell.classForCoder(), forCellReuseIdentifier: MineServiceOrderTopBlankCellId)
        
        mTableView?.register(MineServiceOrderSerCodeCell.classForCoder(), forCellReuseIdentifier: MineServiceOrderSerCodeCellId)
        
        mTableView?.register(MineOrderGeneralCell.classForCoder(), forCellReuseIdentifier: MineOrderGeneralCellId)
        
        mTableView?.register(MineServiceOrderDescriptionCell.classForCoder(), forCellReuseIdentifier: MineServiceOrderDescriptionCellId)
  
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        mTableView?.reloadData()
    }
    
    
    //特色服务  订单金额  订单编号
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==0){return MineServiceOrderDetHeaderH}
        else {return 0.01}
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section==0){
            let header:MineServiceOrderDetHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineServiceOrderDetHeaderId) as! MineServiceOrderDetHeader
            header.section = section
            header.style = style!
            header.serviceOrderDetDic = NSDictionary.init()
            return header
        }
        else {
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    //特色服务  订单金额  订单编号
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            if(style == 0 ||  style == 3){
                return 2
            }
            else {
                return 2
            }
        }
        else if (section == 1){
            if(style == 3){
                return 1
            }
            else {
                return 2
            }
        }
        else if(section == 2){
            if(style == 0 || style == 3){
                return 2;
            }
            else {
                return 4
            }
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section==0){
            if(indexPath.row==0){
                return MineServiceOrderListCellH
            }
            else{
                if(style == 0 || style==3){
                    return MineServiceOrderTopBlankCellH
                }
                else {
                    return MineServiceOrderSerCodeCellH
                }
            }
        }
        else if(indexPath.section == 1 || indexPath.section == 2) {
            return MineOrderGeneralCellH
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section==0){
            //图文
            if(indexPath.row==0){
                
                let cell:MineServiceOrderListCell = tableView.dequeueReusableCell(withIdentifier: MineServiceOrderListCellId, for: indexPath) as! MineServiceOrderListCell
                cell.serviceDetDic = NSDictionary.init()
                return cell
            }
            else{
                //空白
                if(style == 0 || style==3){
                    let cell:MineServiceOrderTopBlankCell = tableView.dequeueReusableCell(withIdentifier: MineServiceOrderTopBlankCellId, for: indexPath) as! MineServiceOrderTopBlankCell
                    return cell
                }
                //服务码
                else {
                    let cell:MineServiceOrderSerCodeCell = tableView.dequeueReusableCell(withIdentifier: MineServiceOrderSerCodeCellId, for: indexPath) as! MineServiceOrderSerCodeCell
                    cell.indexPath = indexPath as NSIndexPath
                    cell.serviceDic = NSDictionary.init()
                    return cell
                }
            }
        }
        //订单金额 订单编号
        else if(indexPath.section==1 || indexPath.section==2) {
            let cell:MineOrderGeneralCell = tableView.dequeueReusableCell(withIdentifier: MineOrderGeneralCellId, for: indexPath) as! MineOrderGeneralCell
            cell.indexPath = indexPath as IndexPath
            cell.serviceDetDic = NSDictionary.init()
            return cell
        }
        else {
            let cell:MineServiceOrderDescriptionCell = tableView.dequeueReusableCell(withIdentifier: MineServiceOrderDescriptionCellId, for: indexPath) as! MineServiceOrderDescriptionCell
            cell.dataDic = NSDictionary.init()
            return cell
        }
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    //底部操作按钮点击回调
    func MineOrderFunctionViewButtonClick(sender: UIButton) {
        
        let vc:PBPayController = PBPayController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
