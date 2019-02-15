//
//  MineController.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

class MineController: BaseController ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MineViewsDelegate{

    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    //单例
    var user:UserDefaults?
    //表头个人信息
    var defHeader:MineDefaultHeader?
    //直接对接到表单的header
    var tableHeader:UIView?
    //登录和未let登录的数据
    var defaultArr:NSArray?
    var noLoginArr:NSArray?
    
    //表头的高度
    var headerH:CGFloat?
    //表头头像的高度
    var headerImgY:CGFloat?
    //表头昵称的高度
    var headerNameY:CGFloat?
    //表头账号的高度
    var headernumberY:CGFloat?
    //表头箭头的高度
    var headerJiantouY:CGFloat?
    
    override init(isRoot: Bool, titleString: NSString) {
        super.init(isRoot: isRoot, titleString: titleString)
        user = UserDefaults.standard
        self.datas = NSMutableArray.init()
        headerH = MineDefaultHeaderH
        
        let dic1:NSDictionary = ["status":"0"]
        let dic2:NSDictionary = ["status":"1","title":"家人管理","img":"jiarenguanli"]
        let dic3:NSDictionary = ["status":"2","title":"我的设备","img":"shebei"]
        let dic4:NSDictionary = ["status":"3","title":"我的收藏","img":"wodeshoucang"]
        let dic5:NSDictionary = ["status":"4","title":"设置","img":"shezhi"]
        let dic6:NSDictionary = ["status":"5","title":"联系客服","img":"lianxikefu"]
        let dic7:NSDictionary = ["status":"6","title":"常见问题","img":"wenti"]
        let dic8:NSDictionary = ["status":"7","title":"体检订单","img":"tijiandingdan"]
        let dic9:NSDictionary = ["status":"8","title":"服务订单","img":"fuwudingdan"]
        
        defaultArr = [[dic1],[dic8,dic9],[dic2,dic4,dic3],[dic7],[dic5,dic6]]
        noLoginArr = [[dic5,dic6]]

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func registerNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(newMessageChange(noti:)), name: NSNotification.Name(rawValue:NotiNewMessageChange), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(mineMessageChange), name: NSNotification.Name(rawValue:NotiMyMsgChange), object: nil)
        
    }
    
    //消息发生变化后更新红点
    @objc func newMessageChange(noti:NSNotification){
        let dic:NSDictionary = noti.object as! NSDictionary
        if(dic["news"] as! NSString == "1"){
            self.setRedViewOnRightButton()
        }else{
            self.deleteRedView()
        }
    }
    
    //个人信息变更后刷新界面
    @objc func mineMessageChange(){
        
        let login:Bool = (user?.value(forKey: USER_Login) as! Bool)
        defHeader?.login = login
        
        self.datas?.removeAllObjects()
        
        if(login == true){
            self.datas?.addObjects(from: defaultArr as! [Any])
            rightBtn1?.isHidden = false
        }
        else{
            self.datas?.addObjects(from: noLoginArr as! [Any])
            rightBtn1?.isHidden = false
        }
        
        defHeader?.dataDict = (NSDictionary.init() as! [NSString : NSString])
        mTableView?.reloadData()
        
        headerImgY = defHeader?.mHeadImgBtn?.centerY
        headerNameY = defHeader?.mNameBtn?.centerY
        headernumberY = defHeader?.mNumberBtn?.centerY
        headerJiantouY = defHeader?.mRightBtn?.centerY
    }
    
    
    func setNavGationStatus(){
        self.setNavgaionTitle(string: "我的")
        self.setRightOneBtnImg(imgStr: "xiaoxi_white")
        navtionImgView?.alpha = 0.01
        self.view.bringSubviewToFront(navtionBar!)
        
        let nav:UINavigationController = self.tabBarController?.viewControllers![0] as! UINavigationController
        let vc:BaseVirtualController = nav.viewControllers[0] as!BaseVirtualController
        if(vc.redView != nil){
            self.setRedViewOnRightButton()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.registerNoti()
        

        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: MainViewRoot_Height + SafeAreaTop_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.backgroundView?.backgroundColor = BackGroundColor
        mTableView?.backgroundColor = BackGroundColor
        mTableView?.register(MineTopCell.classForCoder(), forCellReuseIdentifier: MineTopCellId)
        mTableView?.register(MineMessageCell.classForCoder(), forCellReuseIdentifier: MineMessageCellId)
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        tableHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: headerH!))
        mTableView?.tableHeaderView = tableHeader
        
        defHeader = MineDefaultHeader.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: headerH!))
        defHeader?.delegate = self
        mTableView?.addSubview(defHeader!)
        
        self.setNavGationStatus()
        self.mineMessageChange()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if(offsetY < -130){
            scrollView.contentOffset.y = -130
        }
        
        var alp = offsetY * 0.005
        if(alp > 1){alp = 1}
        if(alp < 0.01){alp = 0.01}
        navtionImgView!.alpha = alp
        
        if(alp > 0.5){
            self .setRightOneBtnImg(imgStr: "xiaoxi")
        }
        else{
            self .setRightOneBtnImg(imgStr: "xiaoxi_white")
        }
        
        if(offsetY < 0){
            print(offsetY)
            var rect:CGRect = (defHeader?.frame)!
            rect.origin.y = offsetY
            rect.size.height = headerH! - offsetY
            defHeader?.frame = rect
            defHeader!.mHeadImgBtn!.centerY = headerImgY! - offsetY
            defHeader!.mNameBtn!.centerY  = headerNameY! - offsetY
            defHeader!.mNumberBtn!.centerY  = headernumberY! - offsetY
            defHeader!.mRightBtn!.centerY  = headerJiantouY! - offsetY
        }
    }
 
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func numberOfSections(in tableView: UITableView) -> Int {
        return (datas?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //顶部选项-2  智能助理0（未登录-1） 推荐资讯6
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datas![section] as! [Any]).count
    }
    
    //健康卡、优惠券    其他信息
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let arr:NSArray = (datas![indexPath.section] as! NSArray)
        let status:NSString = (((arr[indexPath.row] as? [NSString :NSString])?["status"])!)
        
        if(status.integerValue == 0){return MineTopCellH}
        else {return MineMessageCellH}
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr:NSArray = (datas![indexPath.section] as! NSArray)
        let status:NSString = ((arr[indexPath.row] as? [NSString :NSString])?["status"])!
        
        if(status.integerValue == 0){
            let cell:MineTopCell = tableView.dequeueReusableCell(withIdentifier: MineTopCellId, for: indexPath) as! MineTopCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.delegate = self
            return cell
        }
        else {
            let cell:MineMessageCell = tableView.dequeueReusableCell(withIdentifier: MineMessageCellId, for: indexPath) as! MineMessageCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.dataDict =  (arr[indexPath.row] as! NSDictionary)
            return cell
        }
        
    }
    
    
    /// 家人管理1  我的设备2 我的收藏3 设置4 联系客服4 体检订单10 服务订单11
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let arr:NSArray = (datas![indexPath.section] as! NSArray)
        let status:NSString = ((arr[indexPath.row] as? [NSString :NSString])?["status"])!
        
        //家人管理
        if(status.integerValue == 1){
            let vc:HealthFamilyListController = HealthFamilyListController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //我的设备
        else if(status.integerValue == 2){
            let vc:MineEquipmentController = MineEquipmentController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //我的收藏
        else if(status.integerValue == 3){
            let vc:MineCollectionListController = MineCollectionListController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //设置
        else if(status.integerValue == 4){
            let vc:MineSettingController = MineSettingController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //联系客服
        else if(status.integerValue == 4){
            
        }
        //常见问题
        else if(status.intValue == 6){
            
            let vc:MineGeneralListController = MineGeneralListController()
            vc.hidesBottomBarWhenPushed = true
            vc.listType = MineGeneralListType.listProblems
            vc.datas = ["体检预约","体检报告","订单相关"]
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        //体检订单
        else if(status.integerValue == 7){
            let vc:MineMedicalOrderListController = MineMedicalOrderListController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //服务订单
        else if(status.integerValue == 8){
            let vc:MineServiceOrderListController = MineServiceOrderListController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //点击个人信息部分回调
    func MineDefaultHeaderBtnClick(sender: UIButton, login: Bool) {
        let login:Bool = (user?.value(forKey: USER_Login) as! Bool)
        if(login == true){
            let vc:MinePersonalController = MinePersonalController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc:AccountLoginController = AccountLoginController()
            let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
            self.navigationController?.present(nav, animated: true, completion: nil)
        }
    }
    
    //健康卡100、优惠券点击回调101
    func MineTopCellBtnClick(sender: UIButton) {
        if(sender.tag == 100){
            let vc:MineVipCardController = MineVipCardController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc:MineCouponsController = MineCouponsController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //右上角消息按钮点击跳转
    override func navgationButtonClick(sender: UIButton) {
        let vc:MineMessageListController = MineMessageListController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
