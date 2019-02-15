//
//  MineChangeVipCardPWController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/10.
//  Copyright © 2019 soldoros. All rights reserved.
//

//修改卡密码
import UIKit

class MineChangeVipCardPWController: BaseController,UITableViewDelegate,UITableViewDataSource,AccountViewsDelegate{
    
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "修改卡密码")
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = UIColor.white
        mTableView?.backgroundColor = UIColor.white
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mTableView?.register(AccountRegisterCell.classForCoder(), forCellReuseIdentifier: AccountRegisterCellId)
        mTableView?.register(AccountRegisterFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: AccountRegisterFooterId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    
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
        return AccountRegisterFooterH
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountRegisterFooterId) as! AccountRegisterFooter
        footer.delegate = self
        footer.changeCardPWDic = NSDictionary.init()
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AccountRegisterCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AccountRegisterCell = tableView.dequeueReusableCell(withIdentifier: AccountRegisterCellId, for: indexPath) as! AccountRegisterCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.indexPath = indexPath as NSIndexPath
        cell.changeCardPWDic = NSDictionary.init()
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    //确认修改密码
    func AccountRegisterFooterBtnClick(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /// 点击忘记密码回调
    func AccountRegisterFooterTextViewClick(textView: UITextView, url: URL) {
       
        let vc:AccountForgotPasswordController = AccountForgotPasswordController()
        vc.style = SMSStyle.styleValue4
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
