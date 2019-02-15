//
//  AccountRegisterController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/7.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit

//注册新用户
class AccountRegisterController: BaseController ,UITableViewDelegate,UITableViewDataSource,AccountViewsDelegate{
  
    
 
    
    //表单+数据源
    var mTableView:UITableView?
    var datas:NSMutableArray?
    //客服电话
    var servicePhone:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setRightOneBtnTitle(string: "登录")
        self.navLine?.isHidden = true
        
        
        mTableView = UITableView.init(frame: CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height), style: UITableView.Style.grouped)
        view.addSubview(mTableView!)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.bounces = false
        mTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        mTableView?.backgroundView?.backgroundColor = UIColor.white
        mTableView?.backgroundColor = UIColor.white
        mTableView?.register(AccountRegisterCell.classForCoder(), forCellReuseIdentifier: AccountRegisterCellId)
        mTableView?.register(AccountRegisterFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: AccountRegisterFooterId)
        mTableView?.register(AccountRegisterHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: AccountRegisterHeaderId)
        
        if #available(iOS 11.0, *) {
            mTableView!.contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        
        servicePhone = UITextView.init()
        servicePhone?.bounds = CGRect.init(x: 0, y: 0, width: 150, height: 20)
        servicePhone?.text = "客服电话：400-028-3020"
        servicePhone?.textColor = UIColor.hexStringToColor(hexString: "999999")
        servicePhone?.dataDetectorTypes = UIDataDetectorTypes.all
        servicePhone?.backgroundColor = UIColor.white
        servicePhone?.textAlignment = NSTextAlignment.center
        servicePhone?.sizeToFit()
        servicePhone?.width = 200
        servicePhone?.bottom = SCREEN_Height - SafeAreaBottom_Height - 25
        servicePhone?.centerX = SCREEN_Width * 0.5
        view.addSubview(servicePhone!)
        servicePhone?.isScrollEnabled = false
        servicePhone?.isEditable = false
        servicePhone!.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        servicePhone?.layoutManager.allowsNonContiguousLayout = false
        servicePhone?.linkTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AccountRegisterHeaderH
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:AccountRegisterHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountRegisterHeaderId) as! AccountRegisterHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return AccountRegisterFooterH
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer:AccountRegisterFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountRegisterFooterId) as! AccountRegisterFooter
        footer.delegate = self
        footer.registerDic = NSDictionary.init()
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AccountRegisterCellH
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell:AccountRegisterCell = tableView.dequeueReusableCell(withIdentifier: AccountRegisterCellId, for: indexPath) as! AccountRegisterCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.indexPath = indexPath as NSIndexPath
        cell.registerDic = NSDictionary.init()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //返回登录
    @objc override func navgationButtonClick(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /// 立即注册回调
    func AccountRegisterFooterBtnClick(sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    /// 点击服务协议回调
    func AccountRegisterFooterTextViewClick(textView: UITextView, url: URL) {
        let vc:PBWebViewController = PBWebViewController()
        vc.titleString = "用户服务协议"
        vc.urlString = "https://www.baidu.com"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
