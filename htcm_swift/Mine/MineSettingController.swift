//
//  MineSettingController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/7.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

//设置
class MineSettingController: BaseController,UITableViewDelegate,UITableViewDataSource {

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
        self.setNavgaionTitle(string: "设置")
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.register(MineSettingCell.classForCoder(), forCellReuseIdentifier: MineSettingCellId)

        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
   
        datas?.addObjects(from: ["安全设置","通用","分享给好友","意见反馈","关于"])
        if(user?.bool(forKey: USER_Login) == false){
            datas?.removeObject(at: 0)
        }
        
        mTableView?.reloadData()
    }
    
    
    //判断是否需要退出登录的按钮
    func numberOfSections(in tableView: UITableView) -> Int {
        if(user?.bool(forKey: USER_Login) == true){
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return (datas?.count)!
        }else{
            return 1
        }
    }
    
    //健康卡、优惠券    其他信息
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineSettingCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell:MineSettingCell = tableView.dequeueReusableCell(withIdentifier: MineSettingCellId, for: indexPath) as! MineSettingCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.indexPath = indexPath as NSIndexPath
        cell.string =  (datas![indexPath.row] as! String)
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
