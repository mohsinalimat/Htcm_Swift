//
//  BaseController.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

class BaseController: BaseVirtualController {
    
    //是否是根控制器
    var _isRoot:Bool?
    //导航栏标题
    var _titleString:NSString?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        _isRoot = false
    }
    
    init(isRoot:Bool) {
        super.init(nibName: nil, bundle: nil)
        _isRoot = isRoot
    }
    
    init(isRoot:Bool, titleString:NSString) {
        super.init(nibName: nil, bundle: nil)
        _isRoot = isRoot
        _titleString = titleString
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isTranslucent = false;
        
        if(_isRoot == true){
            self.navigationController?.tabBarController!.tabBar.isHidden = false;
            self.navigationController?.tabBarController!.tabBar.isTranslucent = false;
        }
        
        
        //适配ios 11  滚动视图返回时有偏移 reloadData的时候，会重新计算contentSize，就有可能会引起contentOffset的变化 在这里关闭
        for subView:UIView in view.subviews{
            if(subView .isKind(of: UITableView.classForCoder())){
                let tableView:UITableView = subView as! UITableView
                if #available(iOS 11.0, *) {
                    tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
                }
                tableView.scrollIndicatorInsets = tableView.contentInset;
                tableView.estimatedRowHeight = 0.01;
                tableView.estimatedSectionHeaderHeight = 0.01;
                tableView.estimatedSectionFooterHeight = 0.01;
                
                let scro:UIScrollView = subView as! UIScrollView
                scro.scrollIndicatorInsets = tableView.contentInset;
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgationBarColorImg(color: UIColor.white)
        self.setNavgationBarLine(color: BackGroundColor)
        self.setNavgationTitleAttribute(font: UIFont.boldSystemFont(ofSize: 18), color: UIColor.hexStringToColor(hexString: "333333"))
        if(_isRoot == false){
            self.setLeftOneBtnImg(imgStr: "fanhui")
        }
        
        
    }
    
    
    override func navgationButtonClick(sender: UIButton) {
        if(sender == self.leftBtn1){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view .endEditing(true)
    }

}
