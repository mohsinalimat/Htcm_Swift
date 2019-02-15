//
//  HealthEditFamilyController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/23.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit


class HealthEditFamilyController: BaseController ,UITableViewDelegate,UITableViewDataSource,HealthViewsDelegate{
    
    var mAddImage:SSAddImage?
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
        self.setNavgaionTitle(string: "编辑家人信息")
        view.backgroundColor = UIColor.white
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        
        mTableView?.register(HealthFamilyFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: HealthFamilyFooterId)
        
        mTableView?.register(HealthFamilyDetCell2.classForCoder(), forCellReuseIdentifier: HealthFamilyDetCell2Id)
        mTableView?.register(HealthFamilyDetCell3.classForCoder(), forCellReuseIdentifier: HealthFamilyDetCell3Id)
        mTableView?.register(HealthAddFamilyCell5.classForCoder(), forCellReuseIdentifier: HealthAddFamilyCell5Id)
        mTableView?.register(HealthAddFamilyCell6.classForCoder(), forCellReuseIdentifier: HealthAddFamilyCell6Id)
        mTableView?.register(HealthFamilyGenderCell.classForCoder(), forCellReuseIdentifier: HealthFamilyGenderCellId)
        

    }
    
    
    //头像 姓名 性别  年龄 身份证号 手机号   家人关系
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
            footer.delegate = self
            footer.type = 2
            return footer
        }
        else {return nil}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0) {return 5}
        else if(section==1) {return 1}
        else {return NSInteger(_otherRelationship!)}
    }
    
    //头像 姓名 性别  年龄 身份证号 手机号  家人关系
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //头像 姓名 性别  年龄 身份证号
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                return HealthFamilyDetCell2H
            }
            else if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4){
                return HealthFamilyDetCell3H
            }
            else{
                return HealthFamilyGenderCellH
            }
        }
        //手机号
        else if(indexPath.section == 1){
            return HealthFamilyDetCell3H
        }
        
        //家人关系
        else{
            if(indexPath.row==0){
                return UITableView.automaticDimension
            }
            else {
                return HealthAddFamilyCell6H
            }
        }
        
    }
    
    //头像 姓名 性别  年龄 身份证号 手机号 验证码  家人关系
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section==0){
            //头像
            if(indexPath.row==0){
                let cell:HealthFamilyDetCell2 = tableView.dequeueReusableCell(withIdentifier: HealthFamilyDetCell2Id, for: indexPath) as! HealthFamilyDetCell2
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.indexPath = indexPath as NSIndexPath
                return cell
            }
                //姓名 年龄 身份证
            else if (indexPath.row==1 || indexPath.row==3 || indexPath.row==4){
                let cell:HealthFamilyDetCell3 = tableView.dequeueReusableCell(withIdentifier: HealthFamilyDetCell3Id, for: indexPath) as! HealthFamilyDetCell3
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.indexPath = indexPath as NSIndexPath
                cell.famEditDic = NSDictionary.init()
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
            
            //手机号
        else if(indexPath.section==1){
            let cell:HealthFamilyDetCell3 = tableView.dequeueReusableCell(withIdentifier: HealthFamilyDetCell3Id, for: indexPath) as! HealthFamilyDetCell3
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.indexPath = indexPath as NSIndexPath
            cell.famEditDic = NSDictionary.init()
            return cell
        }
            
            //家人关系
        else{
            if(indexPath.row==0){
                let cell:HealthAddFamilyCell5 = tableView.dequeueReusableCell(withIdentifier: HealthAddFamilyCell5Id, for: indexPath) as! HealthAddFamilyCell5
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.indexPath = indexPath as NSIndexPath
                return cell

            }
            else{
                let cell:HealthAddFamilyCell6 = tableView.dequeueReusableCell(withIdentifier: HealthAddFamilyCell6Id, for: indexPath) as! HealthAddFamilyCell6
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.indexPath = indexPath as NSIndexPath
                return cell
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.section == 2){return}
        
        //手机号
        else if(indexPath.section == 1){
            let vc:AccountForgotPasswordController = AccountForgotPasswordController()
            vc.style = SMSStyle.styleValue5
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //头像
       else if(indexPath.row == 0){
            DispatchQueue.main.async(execute: {
                self.mAddImage = SSAddImage()
                self.mAddImage!.getImagePicker(controller: self, modelType: SSImagePickerModelType.SSImagePickerModelImage, pickerBlock: { (_ style:SSImagePickerWayStyle,_ type:SSImagePickerModelType,_ datas:Any) in
                    
                    let cell:HealthFamilyDetCell2 = tableView.cellForRow(at: indexPath) as! HealthFamilyDetCell2
                    cell.mHeaderImg?.image = (datas as! UIImage)
                    
                })
            })
        }
        
        //姓名
        else if(indexPath.row == 1){
            let vc:PBEditController = PBEditController()
            vc.editType = PBEditType.editTypeName
            vc.titleString = "编辑姓名"
            vc.editPlaceholder = "请输入姓名"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //身份证号
        else if(indexPath.row == 4){
            let vc:PBEditController = PBEditController()
            vc.editType = PBEditType.editTypeIdCard
            vc.titleString = "编辑身份证"
            vc.editPlaceholder = "请输入身份证号"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //生日
        else if(indexPath.row == 3){
            
            DispatchQueue.main.async(execute: {
              
                let vc:SSDatePickerController = SSDatePickerController()
                self.definesPresentationContext = true
                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.present(vc, animated: false, completion: {
                    vc.setPickerViewAnimation()
                })

                vc.datePickerBlock = {(string)in
                    
                    let cell:HealthFamilyDetCell3 = tableView.cellForRow(at: indexPath) as! HealthFamilyDetCell3
                    cell.mDetLab?.text = string as String
                    
                }
            })
        }
    }
    
    
    
    
    //保存
    func HealthFamilyBottomBtnClick(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    
}


