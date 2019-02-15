//
//  MineMessageController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

class MineMessageListController: BaseController ,UITableViewDelegate,UITableViewDataSource {
    
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
        self.setNavgaionTitle(string: "服务通知")
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.rowHeight = UITableView.automaticDimension
        mTableView?.estimatedRowHeight = 100
         mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mTableView?.register(MineMessageListCell.classForCoder(), forCellReuseIdentifier: MineMessageListCellId)
        mTableView?.register(MineMessageListHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: MineMessageListHeaderId)
        
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
        return MineMessageListHeaderH
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:MineMessageListHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: MineMessageListHeaderId) as! MineMessageListHeader
        header.section = section
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineMessageListCell = tableView.dequeueReusableCell(withIdentifier: MineMessageListCellId, for: indexPath) as! MineMessageListCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.indexPath = indexPath as NSIndexPath
        cell.dataDic = NSDictionary.init()
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //退出登录
        if(indexPath.section == 1){
            self.loginOut()
        }
        
    }
    
    
    //退出登录
    func loginOut(){
        
        let alert:UIAlertController = UIAlertController.init(title: nil, message: "退出登录后数据会保存，下次登录还可正常使用", preferredStyle: UIAlertController.Style.actionSheet)
        let outAction:UIAlertAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAction:UIAlertAction = UIAlertAction.init(title: "确认退出", style: UIAlertAction.Style.destructive) { (UIAlertAction) in
            
            let dic:NSDictionary = ["news":"0"]
            NSObject.makeUserLoginNo()
            self.sendNotifCation(key: NotiMyMsgChange)
            self.sendNotifCation(key: NotiLoginChange)
            self.sendNotifCation(key: NotiHomeChange)
            self.sendNotifCation(key: NotiNewMessageChange, object: dic)
            
            let vc:AccountLoginController = AccountLoginController()
            let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
            self.navigationController?.present(nav, animated: true, completion: nil)
            self.tabBarController?.selectedIndex = 3
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(outAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
