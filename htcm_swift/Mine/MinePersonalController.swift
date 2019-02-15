//
//  MinePersonalController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

class MinePersonalController: BaseController,UITableViewDelegate,UITableViewDataSource {

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
    
    func registerNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(mineMessageChange), name: NSNotification.Name(rawValue:NotiMyMsgChange), object: nil)
    }
    
    @objc func mineMessageChange(){
        mTableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackGroundColor
        self.setNavgaionTitle(string: "账户设置")
        self.registerNoti()
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.register(MinePersonalImgCell.classForCoder(), forCellReuseIdentifier: MinePersonalImgCellId)
        mTableView?.register(MinePersonalCell.classForCoder(), forCellReuseIdentifier: MinePersonalCellId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        datas?.addObjects(from: ["安全设置","通用","分享给好友","意见反馈","关于"])
        if(user?.bool(forKey: USER_Login) == false){
            datas?.removeObject(at: 0)
        }
        
        mTableView?.reloadData()
    }
    
    
    //判断是否需要退出登录的按钮
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){return MinePersonalImgCellH}
        else {return MinePersonalCellH}
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell:MinePersonalImgCell = tableView.dequeueReusableCell(withIdentifier: MinePersonalImgCellId, for: indexPath) as! MinePersonalImgCell
            cell.indexPath = indexPath as NSIndexPath
            cell.string =  ""
            return cell
        }
        else{
            let cell:MinePersonalCell = tableView.dequeueReusableCell(withIdentifier: MinePersonalCellId, for: indexPath) as! MinePersonalCell
            cell.indexPath = indexPath as NSIndexPath
            cell.dataDic = NSDictionary.init()
            return cell
        }
  
    }
    
    
    /// 家人管理1 我的收藏2 设置3 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
            //设置头像
        if(indexPath.row == 0){
            let vc:MineHeaderImgController = MineHeaderImgController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
            //手机号
        else if(indexPath.row == 1){
            let vc:MineChangePhoneController = MineChangePhoneController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
            //昵称
        else if(indexPath.row == 2){
            self.setNikeName()
        }
            //修改密码
        else if(indexPath.row == 3){
            let vc:MineChangePWController = MineChangePWController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //昵称
    func setNikeName(){
        
        let textField = UITextField.init()
        
        let alert:UIAlertController = UIAlertController.init(title: "修改昵称", message: nil, preferredStyle: UIAlertController.Style.alert)
        let outAction:UIAlertAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let deleteAction:UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.destructive) { (UIAlertAction) in
            print(textField.text as Any)
            self.mTableView?.reloadData()
        }
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "请输入新的昵称"
        }
        
        outAction.setValue(TitleColor, forKey: "_titleTextColor")
        deleteAction.setValue(TitleColor, forKey: "_titleTextColor")
        alert.addAction(outAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    

}
