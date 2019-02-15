//
//  MineServiceOrderListController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/14.
//  Copyright © 2019 soldoros. All rights reserved.
//

//我的服务订单列表
import UIKit

class MineServiceOrderListController: BaseController ,UITableViewDelegate,UITableViewDataSource {
    
    //全部0  待支付1  可使用2  已使用3  已取消4
    var style:NSInteger?
    var topView:SSTableSwitchView?
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
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
        self.setNavgaionTitle(string: "服务订单")
        
        style = 0
        topView = SSTableSwitchView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: 45), switchBlock: { (sender) in
            self.style = sender.tag - 10
        })
        topView?.buttonArr = ["全部","待支付","可使用","已使用","已取消"]
        view.addSubview(topView!)
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height + (topView?.height)!, width: SCREEN_Width, height: MainViewSub_Height - (topView?.height)!), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        mTableView?.register(MineServiceOrderListHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: MineServiceOrderListHeaderId)
        mTableView?.register(MineServiceOrderListCell.classForCoder(), forCellReuseIdentifier: MineServiceOrderListCellId)
        mTableView?.register(MineOrderListPriceFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: MineOrderListPriceFooterId)
        mTableView?.register(MineOrderListEXFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: MineOrderListEXFooterId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        mTableView?.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineServiceOrderListHeaderH
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:MineServiceOrderListHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineServiceOrderListHeaderId) as! MineServiceOrderListHeader
        header.section = section
        header.serviceListDic = NSDictionary.init()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section % 2 == 0){ return MineOrderListPriceFooterH}
        else{
            return MineOrderListEXFooterH
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section % 2 == 0){
            let footer:MineOrderListPriceFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineOrderListPriceFooterId) as! MineOrderListPriceFooter
            footer.section = section
            footer.medicListDic = NSDictionary.init()
            return footer
        }
        else{
            let footer:MineOrderListEXFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineOrderListEXFooterId) as! MineOrderListEXFooter
            footer.section = section
            footer.medicListDic = NSDictionary.init()
            return footer
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineServiceOrderListCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineServiceOrderListCell = tableView.dequeueReusableCell(withIdentifier: MineServiceOrderListCellId, for: indexPath) as! MineServiceOrderListCell
        cell.indexPath = indexPath as IndexPath
        cell.serviceDic = NSDictionary.init()
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc:MineServiceOrderDetController = MineServiceOrderDetController()
        vc.style = self.style! - 1
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
