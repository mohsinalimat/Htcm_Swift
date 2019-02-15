//
//  FoundController.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

class FoundController: BaseController ,UITableViewDelegate,UITableViewDataSource{

    var mTableView:UITableView?
    var datas:NSMutableArray?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgaionTitle(string: _titleString!)
        view.backgroundColor = UIColor.white
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewRoot_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        
        mTableView?.register(homeTitleHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: homeTitleHeaderId)
        mTableView?.register(FoundTopCell.classForCoder(), forCellReuseIdentifier: FoundTopCellId)
        mTableView?.register(FoundBeautyCell.classForCoder(), forCellReuseIdentifier: FoundBeautyCellId)
        mTableView?.register(FoundServiceListCell.classForCoder(), forCellReuseIdentifier: FoundServiceListCellId)
        
    }
    

    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }else{
            return homeTitleHeaderH
        }
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){return nil}
        else {
            let header:homeTitleHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: homeTitleHeaderId) as! homeTitleHeader
            header.section = section
            header.foundDict = (NSDictionary.init() as! [NSString : NSInteger])
            header.mRightIcon?.isHidden = false
            header.bottomLine?.isHidden = true
            if(section == 2){
                header.bottomLine?.isHidden = false
            }
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 2) {
            return 5
        }
        else {return 1}
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return FoundTopCellH
        }
        else if(indexPath.section == 1){
            return FoundBeautyCellH
        }else{
            return FoundServiceListCellH
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cell:FoundTopCell = tableView.dequeueReusableCell(withIdentifier: FoundTopCellId, for: indexPath) as! FoundTopCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        else if(indexPath.section == 1){
            let cell:FoundBeautyCell = tableView.dequeueReusableCell(withIdentifier: FoundBeautyCellId, for: indexPath) as! FoundBeautyCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.dataArray = []
            return cell
        }
        else{
            let cell:FoundServiceListCell = tableView.dequeueReusableCell(withIdentifier: FoundServiceListCellId, for: indexPath) as! FoundServiceListCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.dataDic = NSDictionary.init()
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
