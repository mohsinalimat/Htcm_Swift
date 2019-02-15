//
//  HealthFamilyListController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/21.
//  Copyright © 2019 soldoros. All rights reserved.
//

//家人列表
import UIKit

class HealthFamilyListController: BaseController ,UITableViewDelegate,UITableViewDataSource,HealthViewsDelegate{
    
    
    var family_id:NSString?
    var mTableView:UITableView?
    var datas:NSMutableArray?
    
    var bottomView:HealthFamilyBottomFooter?
    
    override init() {
        super.init()
        family_id = ""
        datas = NSMutableArray.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgaionTitle(string: "家人管理")
        view.backgroundColor = UIColor.white
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        
        mTableView?.register(HealthFamilyListCell.classForCoder(), forCellReuseIdentifier: HealthFamilyListCellId)
        
        bottomView = HealthFamilyBottomFooter.init(frame: CGRect.init(x: 0, y: 0, width: Int(SCREEN_Width), height: HealthFamilyBottomFooterH))
        bottomView?.delegate = self
        mTableView?.tableFooterView = bottomView
        
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
        
        let cell:HealthFamilyListCell = tableView.dequeueReusableCell(withIdentifier: HealthFamilyListCellId, for: indexPath) as! HealthFamilyListCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:HealthFamilyDetController = HealthFamilyDetController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    //添加家人
    func HealthFamilyBottomBtnClick(sender: UIButton) {
        
        let vc:HealthAddFamilyController = HealthAddFamilyController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

