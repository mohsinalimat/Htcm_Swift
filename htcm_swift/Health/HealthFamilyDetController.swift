//
//  HealthFamilyDetController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/21.
//  Copyright © 2019 soldoros. All rights reserved.
//

//家人详情
import UIKit

class HealthFamilyDetController: BaseController ,UITableViewDelegate,UITableViewDataSource,HealthViewsDelegate{
    
    
    var family_id:NSString?
    var mTableView:UITableView?
    var datas:NSMutableArray?
    
    var bottomView:HealthFamilyDetailBottomView?
    
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
        
        mTableView?.register(HealthFamilyDetCell1.classForCoder(), forCellReuseIdentifier: HealthFamilyDetCell1Id)
        mTableView?.register(HealthFamilyDetCell2.classForCoder(), forCellReuseIdentifier: HealthFamilyDetCell2Id)
        mTableView?.register(HealthFamilyGenderCell.classForCoder(), forCellReuseIdentifier: HealthFamilyGenderCellId)
        mTableView?.register(HealthFamilyDetCell3.classForCoder(), forCellReuseIdentifier: HealthFamilyDetCell3Id)
        
        bottomView = HealthFamilyDetailBottomView.init(frame: CGRect.init(x: 0, y: 0, width: Int(SCREEN_Width), height: Int(HealthFamilyDetailBottomViewH)))
        bottomView?.delegate = self
        mTableView?.tableFooterView = bottomView
        
    }
    
    
    //健康卡 头像 姓名 性别 生日 身份证号 手机号 家人关系
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        if(section == 1){return 5}
        else {return 1}
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return HealthFamilyDetCell1H
        }
        else if(indexPath.section == 1){
            if(indexPath.row == 0){
                return HealthFamilyDetCell2H
            }
            else if(indexPath.row == 1 || indexPath.row == 3 ||
                indexPath.row == 4){
                return HealthFamilyDetCell3H
            }
            else {return HealthFamilyGenderCellH}
        }
        else{
            return HealthFamilyDetCell3H
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //健康卡
        if(indexPath.section == 0){
            let cell:HealthFamilyDetCell1 = tableView.dequeueReusableCell(withIdentifier: HealthFamilyDetCell1Id, for: indexPath) as! HealthFamilyDetCell1
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        else if(indexPath.section == 1){
            //头像
            if(indexPath.row == 0){
                let cell:HealthFamilyDetCell2 = tableView.dequeueReusableCell(withIdentifier: HealthFamilyDetCell2Id, for: indexPath) as! HealthFamilyDetCell2
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }
            //姓名 年龄 身份证
            else if(indexPath.row == 1 || indexPath.row == 3 ||
                indexPath.row == 4){
                let cell:HealthFamilyDetCell3 = tableView.dequeueReusableCell(withIdentifier: HealthFamilyDetCell3Id, for: indexPath) as! HealthFamilyDetCell3
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.indexPath = indexPath as NSIndexPath
                cell.famDetDic = NSDictionary.init()
                return cell
            }
                //性别
            else{
                let cell:HealthFamilyGenderCell = tableView.dequeueReusableCell(withIdentifier: HealthFamilyGenderCellId, for: indexPath) as! HealthFamilyGenderCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.indexPath = indexPath as NSIndexPath
                return cell
            }
        }
        
            //手机号 家人关系
        else{
            let cell:HealthFamilyDetCell3 = tableView.dequeueReusableCell(withIdentifier: HealthFamilyDetCell3Id, for: indexPath) as! HealthFamilyDetCell3
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.indexPath = indexPath as NSIndexPath
            cell.famDetDic = NSDictionary.init()
            return cell
        }
        
    } 
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //进入二维码界面
        if(indexPath.section == 0){
            let vc :HealthQrCodeController = HealthQrCodeController()
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    
    //设置默认就诊人10  编辑家人信息11
    func HealthFamilyDetailBottomViewBtnClick(sender: UIButton) {
        if(sender.tag == 10){
            sender.setTitleColor(UIColor.hexStringToColor(hexString: "999999"), for: UIControl.State.normal)
            sender.isEnabled = false
        }
        else{
            let vc :HealthEditFamilyController = HealthEditFamilyController()
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}

