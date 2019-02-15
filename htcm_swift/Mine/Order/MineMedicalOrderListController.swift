//
//  MineMedicalOrderListController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/14.
//  Copyright © 2019 soldoros. All rights reserved.
//


//我的体检订单列表
import UIKit

class MineMedicalOrderListController: BaseController,UITableViewDelegate,UITableViewDataSource,MineOrderViewsDelegate {
    
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
        self.setNavgaionTitle(string: "体检订单")
        
        topView = SSTableSwitchView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: 45), switchBlock: { (sender) in
            
        })
        topView?.buttonArr = ["全部","待支付","已付款","待评价","已取消"]
        view.addSubview(topView!)
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height + (topView?.height)!, width: SCREEN_Width, height: MainViewSub_Height - (topView?.height)!), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
       
        mTableView?.register(MineMedicalOrderListHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: MineMedicalOrderListHeaderId)
        mTableView?.register(MineMedicalOrderListCell.classForCoder(), forCellReuseIdentifier: MineMedicalOrderListCellId)
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
        return MineMedicalOrderListHeaderH
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:MineMedicalOrderListHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineMedicalOrderListHeaderId) as! MineMedicalOrderListHeader
        header.section = section
        header.medicListDic = NSDictionary.init()
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
            footer.delegate = self as MineOrderViewsDelegate
            footer.section = section
            footer.medicListDic = NSDictionary.init()
            return footer
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineMedicalOrderListCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineMedicalOrderListCell = tableView.dequeueReusableCell(withIdentifier: MineMedicalOrderListCellId, for: indexPath) as! MineMedicalOrderListCell
        cell.indexPath = indexPath as IndexPath
        cell.medicListDic = NSDictionary.init()
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        let vc:MineMedicalOrderDetController = MineMedicalOrderDetController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //列表footer按钮点击回调
    func MineOrderListEXFooterBtnClick(section: NSInteger) {
        
        let vc:PBPayController = PBPayController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
