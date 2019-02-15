//
//  MineCouponsController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/25.
//  Copyright © 2019 soldoros. All rights reserved.
//

//优惠券
import UIKit

class MineCouponsController: BaseController,UITableViewDelegate,UITableViewDataSource,MineViewsDelegate {
    
    var topView:SSTableSwitchView?
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    //单例
    var user:UserDefaults?
    
    //顶部t兑换码输入框
    var exchangeView:MineVouchersListTopView?
    
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
        self.setNavgaionTitle(string: "优惠券")
        
        exchangeView = MineVouchersListTopView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MineVouchersListTopViewH))
        exchangeView?.delegate = self as MineViewsDelegate
        view.addSubview(exchangeView!)
        
        topView = SSTableSwitchView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height + 60, width: SCREEN_Width, height: 45), switchBlock: { (sender) in
            
        })
        topView?.buttonArr = ["未使用","已使用","已过期"]
        view.addSubview(topView!)
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: (topView?.bottom)!, width: SCREEN_Width, height: MainViewSub_Height - (topView?.height)! - 60), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mTableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
      
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        mTableView?.reloadData()
    }
    
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainViewSub_Height - (topView?.height)! - 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.textColor = UIColor.hexStringToColor(hexString: "999999")
        cell.textLabel?.text = "暂无数据"
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        
    }
    
    
    //兑换10  扫描11
    func MineVouchersListTopViewBtnClick(sender: UIButton, string: NSString) {
        
    }
    
}
