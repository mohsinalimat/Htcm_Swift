//
//  MineVipCardDetController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/10.
//  Copyright © 2019 soldoros. All rights reserved.
//

//健康卡详情
import UIKit

class MineVipCardDetController: BaseController ,UITableViewDelegate,UITableViewDataSource {
    
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
        self.setNavgaionTitle(string: "详情")
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.rowHeight = UITableView.automaticDimension
        mTableView?.estimatedRowHeight = 100
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mTableView?.register(MineVipCardDetCell.classForCoder(), forCellReuseIdentifier: MineVipCardDetCellId)
        mTableView?.register(AccountRegisterFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: AccountRegisterFooterId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let header:MineVipCodeDetHeader = MineVipCodeDetHeader.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: MineVipCodeDetHeaderH))
        mTableView?.tableHeaderView = header
        
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
        let footer:AccountRegisterFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountRegisterFooterId) as! AccountRegisterFooter
        footer.vipCardDetDic = NSDictionary.init()
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineVipCardDetCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineVipCardDetCell = tableView.dequeueReusableCell(withIdentifier: MineVipCardDetCellId, for: indexPath) as! MineVipCardDetCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.indexPath = indexPath
        cell.dataDic = NSDictionary.init()
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
            //修改卡密码
        if(indexPath.row == 2){
            let vc:MineChangeVipCardPWController = MineChangeVipCardPWController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
            //交易记录
        else if(indexPath.row == 3){
            let vc:MineTransactionRecordsController = MineTransactionRecordsController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
