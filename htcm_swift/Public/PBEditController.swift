//
//  PBEditController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/23.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit



/// 编辑的类型
///
/// - PBEditTypeName: 姓名
/// - PBEditTypeIdCard: 身份证号
enum PBEditType {
    case editTypeName
    case editTypeIdCard
}


protocol PBEditControllerDelegate: NSObjectProtocol{
    
    func PBEditControllerBtnClick(string:NSString,editType:PBEditType)
}


class PBEditController: BaseController ,UITextFieldDelegate{

    weak var delegate:PBEditControllerDelegate?
    
    var titleString:NSString?
    var editType:PBEditType?
    var editPlaceholder:NSString?
    
    var topView:UIView?
    var topTextF:UITextField?
    
    override init() {
        super.init()
        editType = PBEditType.editTypeName
        titleString = "编辑姓名"
        editPlaceholder = "请输入"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackGroundColor
        self.setNavgaionTitle(string: titleString!)
        self.setRightOneBtnTitle(string: "完成")
        
        topView = UIView.init()
        topView?.backgroundColor = UIColor.white
        view.addSubview(topView!)
        topView!.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_Width)
            make.height.equalTo(50)
            make.top.equalTo(SafeAreaTop_Height + 10)
            make.left.equalTo(0)
        }
        
        topTextF = UITextField.init()
        topTextF?.delegate = self
        topTextF?.placeholder = (editPlaceholder! as String)
        topView!.addSubview(topTextF!)
        topTextF?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.right.equalTo(10)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            
        })
        
    }
    
    /// 点击返回
    override func navgationButtonClick(sender: UIButton) {
        if(sender == rightBtn1){
            let string:NSString = (topTextF?.text)! as NSString
            delegate?.PBEditControllerBtnClick(string: string, editType: editType!)
        }
        self.navigationController?.popViewController(animated: true)
    }

}
