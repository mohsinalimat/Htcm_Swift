//
//  MineGeneralListController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/25.
//  Copyright © 2019 soldoros. All rights reserved.
//

//通用的列表视图
import UIKit


/// 列表展示的数据类型
///
/// - listProblems: 常见问题列表
/// - listAppointment: 体检预约
enum MineGeneralListType {
    case listProblems
    case listAppointment
}

class MineGeneralListController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    var listType:MineGeneralListType?
    
    var mTableView:UITableView?
    var datas:NSArray?
    
    override init() {
        super.init()
        listType = MineGeneralListType.listProblems
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        if(listType == MineGeneralListType.listProblems){
            self.setNavgaionTitle(string: "常见问题")
        }
        else{
            self.setNavgaionTitle(string: "体检预约")
        }
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.rowHeight = UITableView.automaticDimension
        mTableView?.estimatedRowHeight = 100
        mTableView?.register(MineSettingCell.classForCoder(), forCellReuseIdentifier: MineSettingCellId)
        
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
        return 10
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
        return (datas?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineSettingCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineSettingCell = tableView.dequeueReusableCell(withIdentifier: MineSettingCellId, for: indexPath) as! MineSettingCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.indexPath = indexPath as NSIndexPath
        cell.generalString = (datas![indexPath.row] as! NSString)
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(listType == MineGeneralListType.listProblems){
            //体检预约
            if(indexPath.row == 0){
                let vc:MineGeneralListController = MineGeneralListController()
                vc.hidesBottomBarWhenPushed = true
                vc.listType = MineGeneralListType.listAppointment
                vc.datas = ["如何购买体检套餐并预约","下单后到机构机构如何进行体检","在线预约时间去体检，机构不提供服务怎么办？"]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //体检报告
            else if(indexPath.row == 1){
                let vc:PBWebViewController = PBWebViewController()
                vc.titleString = "体检报告问题"
                vc.urlString = "http://www.baidu.com"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //订单相关
            else if(indexPath.row == 2){
                let vc:PBWebViewController = PBWebViewController()
                vc.titleString = "订单问题"
                vc.urlString = "http://www.baidu.com"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        
        }
        
        else{
            let vc:PBWebViewController = PBWebViewController()
            vc.titleString = "问题详情"
            vc.urlString = "http://www.baidu.com"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
