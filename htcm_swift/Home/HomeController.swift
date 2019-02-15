//
//  HomeController.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

class HomeController: BaseController,HomeViewsDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var mTableView:UITableView?
    var datas:NSMutableArray?
    var banner:HomeBanner?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgaionTitleImg(imgStr: "htcmlogo")
        self.setRightOneBtnImg(imgStr: "xiaoxi")
        view.backgroundColor = UIColor.white
        
        datas = NSMutableArray.init()
        datas?.addObjects(from: [["type":-2],["type":0],
            ["type":6]])
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewRoot_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mTableView?.register(HomeTopChoiceView.classForCoder(), forHeaderFooterViewReuseIdentifier: HomeTopChoiceViewId)
        mTableView?.register(homeTitleHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: homeTitleHeaderId)
        mTableView?.register(HomeNologoinCell.classForCoder(), forCellReuseIdentifier: HomeNologoinCellId)
        mTableView?.register(HomeAssistantImageCell.classForCoder(), forCellReuseIdentifier: HomeAssistantImageCellId)
        mTableView?.register(HomeAssistantCell.classForCoder(), forCellReuseIdentifier: HomeAssistantCellId)
        mTableView?.register(HomeInformationCell.classForCoder(), forCellReuseIdentifier: HomeInformationCellId)
   
        banner = HomeBanner.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: HomeBannerH))
        banner?.delegate = self
        mTableView?.tableHeaderView = banner;
    
    }
    
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func numberOfSections(in tableView: UITableView) -> Int {
        return (datas?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let type:NSInteger = ((datas![section] as? [NSString:NSInteger])?["type"])!
        if(type == -2){
            return CGFloat(HomeTopChoiceViewH)
        }
        else{
            if(section==0) {return homeTitleHeaderH2}
            else {return homeTitleHeaderH}
        }
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type:NSInteger = ((datas![section] as? [NSString:NSInteger])?["type"])!
        if(type == -2){
            let header:HomeTopChoiceView  = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTopChoiceViewId) as! HomeTopChoiceView
            header.delegate = self
            return header
        }
        else {
            let header:homeTitleHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: homeTitleHeaderId) as! homeTitleHeader
            header.section = section
            header.delegate = self
            header.homeDict = (datas![section] as! [NSString : NSInteger])
            header.mRightIcon?.isHidden = false
            header.bottomLine?.isHidden = true
            if(type == 6){
                header.bottomLine?.isHidden = false;
            }
            if(type == -1){
                header.mRightIcon?.isHidden = true
            }
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type:NSInteger = ((datas![section] as? [NSString:NSInteger])?["type"])!
        
        if(type == -2) {return 0}
        else if(type == -1) {return 1}
        else if(type == 0) {return 2}
        else {return 6}
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type:NSInteger = ((datas![indexPath.section] as? [NSString:NSInteger])?["type"])!
        
        if(type == -1) {return HomeNologoinCellH}
        else if(type == 0) {return HomeAssistantCellH}
        else {return HomeInformationCellH}
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type:NSInteger = ((datas![indexPath.section] as? [NSString:NSInteger])?["type"])!
        
        //未登录
        if(type == -1){
            let cell:HomeNologoinCell = tableView.dequeueReusableCell(withIdentifier: HomeNologoinCellId, for: indexPath) as! HomeNologoinCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        //智能助理
        else if(type == 0){
            let cell:HomeAssistantCell  = tableView.dequeueReusableCell(withIdentifier: HomeAssistantCellId, for: indexPath) as! HomeAssistantCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.homeDict = (NSDictionary.init() as! [NSString : NSInteger])
            return cell
        }
        //推荐资讯
        else {
            let cell:HomeInformationCell  = tableView.dequeueReusableCell(withIdentifier: HomeInformationCellId, for: indexPath) as! HomeInformationCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.homeDict = (NSDictionary.init() as! [NSString : NSInteger])
            
            return cell
        }
    }
    
    //右上角消息按钮点击跳转
    override func navgationButtonClick(sender: UIButton) {
        let vc:MineMessageListController = MineMessageListController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    //首页banner点击回调
    func homeBannerCallBack(index: NSInteger) {
        print("当前网络图片 Index:\(index)")
    }
    
    //首页预约体检10 体检报告11 我的体检12
    func homeTopViewCallBack(sender: UIButton) {
        print(sender.tag)
    }
    
    //首页header点击回调
    func HomeTitleHeaderBtnClick(section: NSInteger) {
        print(section)
    }
    
    //首页智能助理控制点击回调
    func HomeAssistantCellBtnClick(indexPath: NSIndexPath, sender: UIButton) {
        print(sender.tag)
    }
    
}
