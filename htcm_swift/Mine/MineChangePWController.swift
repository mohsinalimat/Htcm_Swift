//
//  MineChangePWController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

//修改密码
class MineChangePWController: BaseController,UITableViewDelegate,UITableViewDataSource,MineViewsDelegate {

    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "修改登录密码")
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.register(MineChangPasswordCell.classForCoder(), forCellReuseIdentifier: MineChangPasswordCellId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

        let header = MineChangPasswordHeader.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: MineChangPasswordHeaderH))
        mTableView?.tableHeaderView = header
        
        let bottom = MineChangPasswordBottom.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: MineChangPasswordBottomH))
        bottom.style = 0
        bottom.delegate = self
        mTableView?.tableFooterView = bottom
    }
    

    //判断是否需要退出登录的按钮
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineChangPasswordCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineChangPasswordCell = tableView.dequeueReusableCell(withIdentifier: MineChangPasswordCellId, for: indexPath) as! MineChangPasswordCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.indexPath = indexPath as NSIndexPath
        cell.style =  0
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //确认修改100  未设置或忘记旧密码101
    func MineChangPasswordBottomBtnClick(sender: UIButton) {
        if(sender.tag == 100){
            NSObject.makeUserLoginNo()
            self.sendNotifCation(key: NotiMyMsgChange)
            let vc:AccountLoginController = AccountLoginController()
            let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
            self.navigationController?.present(nav, animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
        else{
            let vc:AccountForgotPasswordController = AccountForgotPasswordController()
            vc.style = SMSStyle.styleValue3
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
