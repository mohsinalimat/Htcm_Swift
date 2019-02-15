//
//  MineCollectionListController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/25.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

class MineCollectionListController: BaseController,UITableViewDelegate,UITableViewDataSource,MineOrderViewsDelegate {
    
    var topView:SSTableScrollSwitchView?
    var topString:NSString?
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    //单例
    var user:UserDefaults?
    
    override init() {
        super.init()
        user = UserDefaults.standard
        self.datas = NSMutableArray.init()
        topString = "体检套餐"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "体检订单")
        
        let arr:NSArray = ["体检套餐","医生","资讯","特色服务","医疗美容"]
        topView = SSTableScrollSwitchView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: 50), switchBlock: { (sender) in
            self.topString = (arr[sender.tag - 10] as! NSString)
        })
        topView?.array = arr
        view.addSubview(topView!)
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height + (topView?.height)!, width: SCREEN_Width, height: MainViewSub_Height - (topView?.height)!), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.register(HomeMedicalPackageListCell.classForCoder(), forCellReuseIdentifier: HomeMedicalPackageListCellId)
       
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        mTableView?.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    //"体检套餐","医生","资讯","特色服务","医疗美容"
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(topString == "体检套餐"){
            return UITableView.automaticDimension
        }
        else{
            return 100
        }
    }
    
    
    //"体检套餐","医生","资讯","特色服务","医疗美容"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(topString == "体检套餐"){
            let cell:HomeMedicalPackageListCell = tableView.dequeueReusableCell(withIdentifier: HomeMedicalPackageListCellId, for: indexPath) as! HomeMedicalPackageListCell
            cell.indexPath = indexPath as NSIndexPath
            return cell
        }
        else{
            return UITableViewCell.init()
        }
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    
}
