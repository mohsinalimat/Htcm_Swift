//
//  HealthAddFamilyController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/23.
//  Copyright © 2019 soldoros. All rights reserved.
//

//添加家人
import UIKit

class HealthAddFamilyController: BaseController ,UITableViewDelegate,UITableViewDataSource,HealthViewsDelegate{
    
    
    var family_id:NSString?
    var mTableView:UITableView?
    var datas:NSMutableArray?
    
    //家人关系  是否添加家人关系
    var relationship:NSInteger?
    var _otherRelationship:CGFloat?
    
    //姓名 生日 身份证 手机号 验证码
    var string1:NSString?
    var string2:NSString?
    var string3:NSString?
    var string4:NSString?
    var string5:NSString?
    
    override init() {
        super.init()
        family_id = ""
        relationship = 0
        _otherRelationship = 2
        string1 = ""
        string2 = ""
        string3 = ""
        string4 = ""
        string5 = ""
        datas = NSMutableArray.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgaionTitle(string: "添加家人")
        view.backgroundColor = UIColor.white
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        
        mTableView?.register(HealthAddFamilyCell1.classForCoder(), forCellReuseIdentifier: HealthAddFamilyCell1Id)
        mTableView?.register(HealthAddFamilyCell2.classForCoder(), forCellReuseIdentifier: HealthAddFamilyCell2Id)
        mTableView?.register(HealthAddFamilyCell5.classForCoder(), forCellReuseIdentifier: HealthAddFamilyCell5Id)
        mTableView?.register(HealthAddFamilyCell6.classForCoder(), forCellReuseIdentifier: HealthAddFamilyCell6Id)
        mTableView?.register(HealthFamilyFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: HealthFamilyFooterId)
        
    }
    
    
    //头像 姓名 性别  年龄 身份证号 手机号 验证码  家人关系
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==2){return HealthFamilyFooterH}
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section==2){
            let footer:HealthFamilyFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: HealthFamilyFooterId) as! HealthFamilyFooter
            return footer
        }
        else {return nil}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0) {return 5}
        else if(section==1) {return 2}
        else {return NSInteger(_otherRelationship!)}
    }
    
    //头像 姓名 性别  年龄 身份证号 手机号 验证码  家人关系
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //头像 姓名 性别 年龄 身份证号
        if(indexPath.section == 0){
            if(indexPath.row == 0){return HealthAddFamilyCell1H}
            else {return HealthAddFamilyCell2H}
        }
            //手机号 验证码
        else if (indexPath.section == 1){
            return HealthAddFamilyCell2H
        }
            //家人关系
        else {
            if(indexPath.row == 0) {
                return UITableView.automaticDimension
            }
            else {return HealthAddFamilyCell6H}
        }
    }
    
    //头像 姓名 性别  年龄 身份证号 手机号 验证码  家人关系
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //头像 姓名 性别 年龄 身份证号
        if(indexPath.section==0){
            if(indexPath.row==0){
                let cell: HealthAddFamilyCell1 = tableView.dequeueReusableCell(withIdentifier: HealthAddFamilyCell1Id, for: indexPath) as! HealthAddFamilyCell1
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }
                
            else{
                
                let cell: HealthAddFamilyCell2 = tableView.dequeueReusableCell(withIdentifier: HealthAddFamilyCell2Id, for: indexPath) as! HealthAddFamilyCell2
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.indexPath = indexPath as NSIndexPath
                cell.familyDetDic = NSDictionary.init()
                return cell
            }
        }
            
            //手机号 验证码
        else if (indexPath.section==1){
            let cell: HealthAddFamilyCell2 = tableView.dequeueReusableCell(withIdentifier: HealthAddFamilyCell2Id, for: indexPath) as! HealthAddFamilyCell2
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.indexPath = indexPath as NSIndexPath
            cell.familyDetDic = NSDictionary.init()
            return cell
        }
            
            //家人关系
        else{
            if(indexPath.row==0){
                let cell: HealthAddFamilyCell5 = tableView.dequeueReusableCell(withIdentifier: HealthAddFamilyCell5Id, for: indexPath) as! HealthAddFamilyCell5
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.indexPath = indexPath as NSIndexPath
                return cell
            }
                //输入其他关系
            else{
                
                let cell: HealthAddFamilyCell6 = tableView.dequeueReusableCell(withIdentifier: HealthAddFamilyCell6Id, for: indexPath) as! HealthAddFamilyCell6
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.indexPath = indexPath as NSIndexPath
                return cell
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    func HealthFamilyDetailBottomViewBtnClick(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

