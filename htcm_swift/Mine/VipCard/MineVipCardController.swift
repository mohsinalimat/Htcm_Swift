//
//  MineVipCardController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/10.
//  Copyright © 2019 soldoros. All rights reserved.
//

//健康卡列表
import UIKit

class MineVipCardController: BaseController ,UITableViewDelegate,UITableViewDataSource,MineViewsDelegate{
    
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    
    //卡号点击弹窗
    var backView:UIView?
    var window:MineVipCodeWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: "健康卡")
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = UIColor.white
        mTableView?.backgroundColor = UIColor.white
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mTableView?.register(MineVipCardCell.classForCoder(), forCellReuseIdentifier: MineVipCardCellId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let bottomView = MineAddVipCardView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width , height: MineAddVipCardViewH))
        bottomView.delegate = self as MineViewsDelegate
        mTableView?.tableFooterView = bottomView
        
        
        mTableView?.reloadData()
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
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineVipCardCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineVipCardCell = tableView.dequeueReusableCell(withIdentifier: MineVipCardCellId, for: indexPath) as! MineVipCardCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.delegate = self
        cell.indexPath = indexPath as NSIndexPath
        cell.dataDic = NSDictionary.init()
        return cell
        
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc:MineVipCardDetController = MineVipCardDetController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //底部添加卡片的按钮点击回调
    func MineAddVipCardViewBtnClick(sender: UIButton) {
        
        let vc:MineAddVipCardController = MineAddVipCardController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //卡片二维码点击弹窗
    func MineVipCardCellBtnClick(indexPath: NSIndexPath, sender: UIButton) {
        
        let number:NSString = "5674563"
        
        backView = UIView.init()
        backView?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Height)
        backView?.backgroundColor = UIColor.black
        backView?.alpha = 0.01
        view.addSubview(backView!)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(backViewTouch))
        backView?.addGestureRecognizer(tapGesture)
        
        window = MineVipCodeWindow.init(frame: CGRect.init(x: 0, y: 0, width: MineVipCodeWindowW, height: MineVipCodeWindowH), number: number)
        window?.center = view.center
        view.addSubview(window!)
        
        window?.animateIn()
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.25, animations: {
            self.backView?.alpha = 0.5
        }) { (Bool) in
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
    @objc func backViewTouch(){
        
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.25, animations: {
            self.backView?.alpha = 0.01
            self.window!.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { (Bool) in
            self.view.isUserInteractionEnabled = true
            self.window?.removeFromSuperview()
            self.backView?.removeFromSuperview()
            self.window = nil
            self.backView = nil
        }
        
    }
    
}
