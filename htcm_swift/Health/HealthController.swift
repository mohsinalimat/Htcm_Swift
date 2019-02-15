//
//  HealthController.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

class HealthController: BaseController ,UITableViewDelegate,UITableViewDataSource{

    var mTableView:UITableView?
    var datas:NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgaionTitle(string: _titleString!)
        self.setRightOneBtnTitle(string: "家人管理")
        view.backgroundColor = UIColor.white
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewRoot_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        
        mTableView?.register(HealthFamilyCell.classForCoder(), forCellReuseIdentifier: HealthFamilyCellId)
        
    }
   
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
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
        return 4
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HealthFamilyCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell:HealthFamilyCell = tableView.dequeueReusableCell(withIdentifier: HealthFamilyCellId, for: indexPath) as! HealthFamilyCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.healthDict = (NSDictionary.init() as! [NSString : NSInteger])
        return cell
      
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    //家人管理
    override func navgationButtonClick(sender: UIButton) {
        
        let vc:HealthFamilyListController = HealthFamilyListController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
